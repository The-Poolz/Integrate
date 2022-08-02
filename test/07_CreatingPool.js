const ThePoolz = artifacts.require("ThePoolz")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require("WhiteList")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const constants = require("@openzeppelin/test-helpers/src/constants")
var BN = web3.utils.BN

const rate = new BN("1000000000") // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN("3000000") //3 tokens for sale

const { createNewWhiteList } = require("./helper")

contract("Integration between Poolz-Back and WhiteList for Creating New Pool", (accounts) => {
  let poolzBack,
    testToken,
    whiteList,
    mainCoin,
    firstAddress = accounts[0]
  let tokenWhiteListId, mainCoinWhiteListId

  before(async () => {
    poolzBack = await ThePoolz.deployed()
    whiteList = await WhiteList.deployed()
    testToken = await Token.new("TestToken", "TEST")
    mainCoin = await Token.new("TestMainToken", "TESTM")
  })

  describe("WhiteList Setup", () => {
    it("Creating new WhiteList for Main Coin", async () => {
      const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
      mainCoinWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
    })

    it("Creating new WhiteList for Token", async () => {
      const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
      tokenWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
    })

    it("should add Main Coin Address to whiteList ID 1", async () => {
      const addressArray = [mainCoin.address]
      const allowanceArray = [100000000] // random allowance
      await whiteList.AddAddress(mainCoinWhiteListId, addressArray, allowanceArray, { from: firstAddress })
      const result = await whiteList.Check(mainCoin.address, mainCoinWhiteListId)
      assert.equal(result, 100000000)
    })

    it("should add Token Address to whiteList ID 2", async () => {
      const addressArray = [testToken.address]
      const allowanceArray = [100000000] // random allowance
      await whiteList.AddAddress(tokenWhiteListId, addressArray, allowanceArray, { from: firstAddress })
      const result = await whiteList.Check(testToken.address, tokenWhiteListId)
      assert.equal(result, 100000000)
    })
  })

  describe("PoolzBack Setup", () => {
    it("should set whitelist address", async () => {
      await poolzBack.SetWhiteList_Address(whiteList.address, { from: firstAddress })
      const result = await poolzBack.WhiteList_Address()
      assert.equal(whiteList.address, result)
    })
    it("should set Token WhiteList ID", async () => {
      await poolzBack.setTokenWhitelistId(tokenWhiteListId, { from: firstAddress })
      const result = await poolzBack.TokenWhitelistId()
      assert.equal(tokenWhiteListId, result)
    })
    it("should set Main Coin WhiteList ID", async () => {
      await poolzBack.setMCWhitelistId(mainCoinWhiteListId, { from: firstAddress })
      const result = await poolzBack.MCWhitelistId()
      assert.equal(mainCoinWhiteListId, result)
    })
    it("should set Token Filter to true", async () => {
      await poolzBack.SwapTokenFilter({ from: firstAddress })
      const result = await poolzBack.IsTokenFilterOn()
      assert.equal(true, result)
    })
  })

  describe("Creating Pool", () => {
    it("should create new pool with ETH as Main Coin", async () => {
      let poolId
      await testToken.approve(poolzBack.address, amount, { from: firstAddress })
      const date = new Date()
      date.setDate(date.getDate() + 1) // add a day
      const future = Math.floor(date.getTime() / 1000) + 60
      const tx = await poolzBack.CreatePool(
        testToken.address,
        future,
        rate,
        rate,
        amount,
        0,
        constants.ZERO_ADDRESS,
        true,
        0,
        0,
        { from: firstAddress }
      )
      poolId = tx.logs[1].args[1].toString()
      let newpools = await poolzBack.poolsCount.call()
      assert.equal(newpools.toNumber(), 1, "Got 1 pool")
      let tokensInContract = await testToken.balanceOf(poolzBack.address)
      assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
    })
    it("should create new pool with ERC20 Main Coin", async () => {
      let poolId
      await testToken.approve(poolzBack.address, amount, { from: firstAddress })
      const date = new Date()
      date.setDate(date.getDate() + 1) // add a day
      const future = Math.floor(date.getTime() / 1000) + 60
      const tx = await poolzBack.CreatePool(
        testToken.address,
        future,
        rate,
        rate,
        amount,
        0,
        mainCoin.address,
        true,
        0,
        0,
        { from: firstAddress }
      )
      poolId = tx.logs[1].args[1].toString()
      let newpools = await poolzBack.poolsCount.call()
      assert.equal(newpools.toNumber(), 2, "Got 1 pool")
      const data = await poolzBack.GetPoolExtraData(poolId)
      assert.equal(mainCoin.address, data[2], "Address match")
    })
  })

  describe("Fail to Create Pool", () => {
    it("should fail to create pool when token is not WhiteListed", async () => {
      const randomAddress = accounts[9]
      const date = new Date()
      date.setDate(date.getDate() + 1) // add a day
      const future = Math.floor(date.getTime() / 1000) + 60
      await truffleAssert.reverts(
        poolzBack.CreatePool(randomAddress, future, rate, rate, amount, 0, constants.ZERO_ADDRESS, true, 0, 0, {
          from: firstAddress
        }),
        "Need Valid ERC20 Token"
      )
    })
    it("should fail to create pool when main coin is not whitelisted", async () => {
      const randomAddress = accounts[9]
      const date = new Date()
      date.setDate(date.getDate() + 1) // add a day
      const future = Math.floor(date.getTime() / 1000) + 60
      await truffleAssert.reverts(
        poolzBack.CreatePool(testToken.address, future, rate, rate, amount, 0, randomAddress, true, 0, 0, {
          from: firstAddress
        }),
        "Main coin not in list"
      )
    })
  })
})
