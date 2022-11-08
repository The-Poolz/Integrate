const ThePoolz = artifacts.require("ThePoolz")
const HodlersWhitelist = artifacts.require("HodlersWhitelist")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require("WhiteList")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const timeMachine = require("ganache-time-traveler")
const BigNumber = require("bignumber.js")
const constants = require("@openzeppelin/test-helpers/src/constants")
const BN = web3.utils.BN

const pozRate = new BN("1000000000") // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN("500000000") // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN("3000000") //3 tokens for sale

const { createNewWhiteList } = require("./helper")

contract("Integration between HodlersWhitelist and PoolzBack", (accounts) => {
    let poolzBack,
        testToken,
        whiteList,
        firstAddress = accounts[0]
    let hodlers = []
    let poolId

    before(async () => {
        poolzBack = await ThePoolz.deployed()
        hodlersWhitelist = await HodlersWhitelist.deployed()
        whiteList = await WhiteList.deployed()
        // pozToken = await Token.new('Poolz', 'POZ')
        testToken = await Token.new("TestToken", "TEST")
    })

    describe("Setting up PoolzBack", () => {
        let poolWhiteListId

        it("should set address of HodlersWhitelist contract", async () => {
            await poolzBack.SetBenefit_Address(hodlersWhitelist.address, { from: firstAddress })
            const result = await poolzBack.Benefit_Address()
            assert.equal(result, hodlersWhitelist.address)
        })

        it("should set address of whiteList contract", async () => {
            await poolzBack.SetWhiteList_Address(whiteList.address, { from: firstAddress })
            const result = await poolzBack.WhiteList_Address()
            assert.equal(whiteList.address, result)
        })

        it("Creating new WhiteList for pool", async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            poolWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it("should set POZ Timer to 50%", async () => {
            await poolzBack.SetPozTimer(5000, { from: firstAddress })
            const result = await poolzBack.PozTimer()
            assert.equal(result.toNumber(), 5000)
        })

        it("should create new ETH Pool", async () => {
            await testToken.approve(poolzBack.address, amount, { from: firstAddress })
            const date = new Date()
            date.setHours(date.getHours() + 4) // add 4 hours
            const finishTime = Math.floor(date.getTime() / 1000)
            const tx = await poolzBack.CreatePool(
                testToken.address,
                finishTime,
                publicRate,
                pozRate,
                amount,
                0,
                constants.ZERO_ADDRESS,
                true,
                0,
                poolWhiteListId,
                { from: firstAddress }
            ) // dsp pool
            poolId = tx.logs[1].args[1].toString()
            let newpools = await poolzBack.poolsCount.call()
            assert.equal(newpools.toNumber(), 1, "Got 1 pool")
            let tokensInContract = await testToken.balanceOf(poolzBack.address)
            assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
        })
    })

    describe("Setting up HodlersWhitelist Contract", () => {
        let whitelistId

        it("should create new Hodlers Whitelist", async () => {
            const now = Date.now() / 1000 // current timestamp in seconds
            const timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
            const result = await hodlersWhitelist.CreateManualWhiteList(timestamp, { from: firstAddress })
            const count = await hodlersWhitelist.WhiteListCount()
            const logs = result.logs[0].args
            whitelistId = logs._WhitelistId.toString()
            assert.equal("0", logs._WhitelistId.toString())
            assert.equal(firstAddress, logs._creator.toString())
            assert.equal(timestamp, logs._changeUntil.toString())
            assert.equal("1", count.toString())
        })

        it("should set the main hodlers whitelist ID", async () => {
            await hodlersWhitelist.SetMainWhitelistId(whitelistId, { from: firstAddress })
            const result = await hodlersWhitelist.MainWhitelistId()
            assert.equal(result, whitelistId)
        })

        it("should add addresses to whitelist", async () => {
            hodlers = [accounts[1], accounts[2], accounts[3], accounts[4], accounts[5]]
            await hodlersWhitelist.AddAddress(whitelistId, hodlers, { from: firstAddress })
            const result1 = await hodlersWhitelist.IsPOZHolder(accounts[1])
            assert.isTrue(result1)
            const result2 = await hodlersWhitelist.IsPOZHolder(accounts[2])
            assert.isTrue(result2)
            const result3 = await hodlersWhitelist.IsPOZHolder(accounts[3])
            assert.isTrue(result3)
            const result4 = await hodlersWhitelist.IsPOZHolder(accounts[4])
            assert.isTrue(result4)
            const result5 = await hodlersWhitelist.IsPOZHolder(accounts[5])
            assert.isTrue(result5)
            const result6 = await hodlersWhitelist.IsPOZHolder(accounts[6])
            assert.isFalse(result6)
        })
    })

    describe("Investing in Pool", () => {
        it("moving time to when pool is open", async () => {
            await timeMachine.advanceTimeAndBlock(3600 * 2)
            const result = await poolzBack.GetPoolStatus(poolId)
            assert.equal(result.toString(), "1")
        })

        it("fail to invest when investor is not hodler", async () => {
            await truffleAssert.reverts(
                poolzBack.InvestETH(poolId, { from: accounts[9], value: web3.utils.toWei("0.1") }),
                "Only POZ holder can invest"
            )
        })

        it("Successfully invest when investor is Hodler", async () => {
            const result = await poolzBack.InvestETH(poolId, { from: hodlers[0], value: web3.utils.toWei("0.4") })
            const tokenDecimals = await testToken.decimals()
            const realRate = publicRate.div(new BN(10).pow(new BN(21 + tokenDecimals.toNumber() - 18))) // converting decimal21Rate to realRate
            const tokens = 0.4 * realRate.toNumber()
            const bal = await testToken.balanceOf(hodlers[0])
            assert.deepEqual(bal, new BN(tokens).mul(new BN(10).pow(tokenDecimals)))
        })

        after(async () => {
            await timeMachine.advanceTimeAndBlock(-3600 * 2)
        })
    })
})
