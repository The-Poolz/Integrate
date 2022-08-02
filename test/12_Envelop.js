const Token = artifacts.require("POOLZSYNT")
const TestToken = artifacts.require("OriginalToken")
const LockedDeal = artifacts.require("LockedDeal")
const WhiteList = artifacts.require("WhiteList")
const UniswapV2Factory = artifacts.require("UniswapV2Factory")
const UniswapV2Pair = artifacts.require("UniswapV2Pair")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const BigNumber = require("bignumber.js")
const timeMachine = require("ganache-time-traveler")
BigNumber.config({ EXPONENTIAL_AT: 1e9 })
const { uintMinusOne } = require("./helper/index")
BigNumber.config({ EXPONENTIAL_AT: 1e9 })

contract("Integration Between Envelop Token, WhiteList and LockedDeal", (accounts) => {
  let token,
    originalToken,
    lockedDealContract,
    whitelistContract,
    firstAddress = accounts[0]
  let uniswapV2Factory, uniswapV2Pair, whitelistId
  let finishTime = parseInt(new Date().setHours(new Date().getHours() + 1) / 1000) // current time + 1H
  // let whitelistId = 1

  const cap = new BigNumber(10000)
  const timestamps = []
  const ratios = [1, 1, 1]
  const tokenName = "REAL Synthetic"
  const tokenSymbol = "~REAL Poolz"
  const decimals = "18"

  before(async () => {
    originalToken = await TestToken.new("OrgToken", "ORGT", {
      from: firstAddress
    })
    lockedDealContract = await LockedDeal.new()
    uniswapV2Factory = await UniswapV2Factory.deployed()
    whitelistContract = await WhiteList.new()
    const now = new Date()
    timestamps.push((now.setHours(now.getHours() + 2) / 1000).toFixed()) // current time + 2H
    timestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
    timestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
  })

  describe("setting up Envelop Token", () => {
    it("should deploy new envelop token", async () => {
      token = await Token.new(
        tokenName,
        tokenSymbol,
        cap.toString(),
        decimals,
        firstAddress,
        lockedDealContract.address,
        whitelistContract.address,
        { from: firstAddress }
      )
      // const tx = await web3.eth.getTransactionReceipt(token.transactionHash)
      // console.log(tx)
      // tx.logs.forEach(item => {
      //     const data  = web3.eth.abi.decodeParameter('string', item.data)
      //     console.log(data)
      // })
      const name = await token.name()
      const symbol = await token.symbol()
      const firstBalance = await token.balanceOf(firstAddress)
      const tokenDecimals = await token.decimals()
      const capp = await token.cap()
      const expectedCapp = cap.multipliedBy(10 ** 18).toString()
      const lockedAddress = await token.LockedDealAddress()
      const whitelistAddress = await token.WhitelistAddress()
      whitelistId = await token.WhitelistId()
      const whitelistCount = await whitelistContract.WhiteListCount()
      const whitelistSettings = await whitelistContract.WhitelistSettings(whitelistId)
      assert.equal(tokenName, name, "check name")
      assert.equal(tokenSymbol, symbol, "check symbol")
      assert.equal(tokenDecimals.toString(), decimals, "check decimals")
      assert.equal(firstBalance.toString(), cap.multipliedBy(10 ** 18).toString(), "check first address balance")
      assert.equal(lockedAddress, lockedDealContract.address, "check lockedDeal address")
      assert.equal(whitelistAddress, whitelistContract.address, "check whitelist address")
      assert.equal(capp, expectedCapp, "check capitalization")
      assert.equal(whitelistCount.toString(), "2")
      assert.equal(firstAddress, whitelistSettings.Creator)
      assert.equal(uintMinusOne, whitelistSettings.ChangeUntil.toString())
      assert.equal(token.address, whitelistSettings.Contract)
      assert.equal(false, whitelistSettings.isReady)
    })
    it("should set locking details", async () => {
      await originalToken.approve(token.address, cap.multipliedBy(10 ** 18).toString(), { from: firstAddress })
      const _cap = await token.cap()
      const tx = await token.SetLockingDetails(originalToken.address, timestamps, ratios, finishTime, {
        from: firstAddress
      })
      const originalAddress = tx.logs[3].args.TokenAddress
      const totalAmount = tx.logs[3].args.Amount
      const totalUnlocks = tx.logs[3].args.TotalUnlocks
      const time = tx.logs[3].args.FinishTime
      const tokenCap = await token.cap()
      assert.equal(originalToken.address, originalAddress, "check token address")
      assert.equal(totalAmount.toString(), tokenCap.toString(), "check total amount")
      assert.equal(totalUnlocks, timestamps.length, "check total unlocks")
      assert.equal(time, finishTime, "check finish time")
    })

    it("verifying locking details", async () => {
      const totalRatios = ratios.reduce((a, b) => a + b, 0)
      const orgToken = await token.OriginalTokenAddress()
      const totalUnlocks = await token.totalUnlocks()
      const ratioTotal = await token.totalOfRatios()
      assert.equal(orgToken, originalToken.address)
      assert.equal(totalUnlocks, timestamps.length)
      assert.equal(ratioTotal, totalRatios)
      for (let i = 0; i < totalUnlocks; i++) {
        const details = await token.LockDetails(i)
        assert.equal(details.unlockTime.toString(), timestamps[i].toString())
        assert.equal(details.ratio.toString(), ratios[i].toString())
      }
    })
  })

  describe("Integration with LP contract", () => {
    let testToken
    it("create liquidity pair with synth token", async () => {
      testToken = await TestToken.new("TestToken", "TEST", {
        from: firstAddress
      })
      await uniswapV2Factory.createPair(token.address, testToken.address, {
        from: firstAddress
      })
      const pair = await uniswapV2Factory.getPair(token.address, testToken.address)
      uniswapV2Pair = await UniswapV2Pair.at(pair)
      const [token0, token1] =
        token.address < testToken.address ? [token.address, testToken.address] : [testToken.address, token.address]
      assert.equal(token0, await uniswapV2Pair.token0(), "check first token address")
      assert.equal(token1, await uniswapV2Pair.token1(), "check second token address")
    })

    it("add liquidity with synth token", async () => {
      const amount = "15000000"
      await token.transfer(uniswapV2Pair.address, amount)
      await testToken.transfer(uniswapV2Pair.address, amount)
      await uniswapV2Pair.mint(firstAddress)
      const reserve0 = (await uniswapV2Pair.getReserves())["0"]
      const reserve1 = (await uniswapV2Pair.getReserves())["1"]
      assert.equal(reserve0, amount, "check first token reserve")
      assert.equal(reserve1, amount, "check second token reserve")
    })

    it("should transfer when in whitelist", async () => {
      const whitelistAddress = accounts[5]
      let result = await whitelistContract.Check(whitelistAddress, whitelistId)
      assert.equal(result, 0)
      await whitelistContract.AddAddress(whitelistId, [whitelistAddress], ["10000000"])
      result = await whitelistContract.Check(whitelistAddress, whitelistId)
      assert.equal(result.toString(), "10000000", "Check if address is whitelisted")
      const transferAmount = "1999980000000"
      const swapAmount = "1000"
      await token.transfer(uniswapV2Pair.address, transferAmount)
      await testToken.transfer(uniswapV2Pair.address, transferAmount)
      await uniswapV2Pair.swap(swapAmount, swapAmount, whitelistAddress, "0x", { from: whitelistAddress })
      const balance = await token.balanceOf(whitelistAddress)
      assert.equal(balance.toString(), swapAmount, "check whitelist balance")
    })

    it("should revert when not in whitelist", async () => {
      const notWhitelistAddress = accounts[6]
      const swapAmount = "1000"
      const result = await whitelistContract.Check(notWhitelistAddress, whitelistId)
      assert.equal(result, 0, "Check if address is whitelisted")
      const transferAmount = "1999980000000"
      await uniswapV2Pair.sync()
      await token.transfer(uniswapV2Pair.address, transferAmount)
      await truffleAssert.reverts(
        uniswapV2Pair.swap(swapAmount, swapAmount, notWhitelistAddress, "0x", { from: notWhitelistAddress }),
        "UniswapV2: TRANSFER_FAILED"
      )
      // check transfer if add notWhitelistAddress to whitelist
      await whitelistContract.AddAddress(whitelistId, [notWhitelistAddress], ["10000000"])
      await uniswapV2Pair.swap(swapAmount, swapAmount, notWhitelistAddress, "0x", { from: notWhitelistAddress })
      const balance = await token.balanceOf(notWhitelistAddress)
      assert.equal(balance.toString(), swapAmount, "check notWhitelistAddress balance")
    })

    it("check when the finish time is over", async () => {
      // create another synth token with past time configuration
      const secondAddress = accounts[1]
      const thirdAddress = accounts[2]
      const amount = 1000
      const time = new Date()
      time.setDate(time.getDate() - 1)
      const past = Math.floor(time.getTime() / 1000) + 60
      const testToken2 = await TestToken.new("TEST2", "TEST2", {
        from: secondAddress
      })
      const newToken = await Token.new(
        tokenName,
        tokenSymbol,
        cap.toString(),
        decimals,
        secondAddress,
        lockedDealContract.address,
        whitelistContract.address,
        { from: secondAddress }
      )
      await testToken2.approve(newToken.address, cap.multipliedBy(10 ** 18).toString(), { from: secondAddress })
      await newToken.SetLockingDetails(testToken2.address, timestamps, ratios, past, { from: secondAddress })
      // check transfer functionality
      await newToken.transfer(thirdAddress, (amount * 2).toString(), {
        from: secondAddress
      })
      let thirdBalance = await newToken.balanceOf(thirdAddress)
      assert.equal(thirdBalance.toString(), (amount * 2).toString(), "check third address balance")
      await newToken.transfer(secondAddress, amount.toString(), {
        from: thirdAddress
      }) // no whitelist address
      const newTokenID = await newToken.WhitelistId()
      await whitelistContract.AddAddress(newTokenID, [thirdAddress], ["10000000"], { from: secondAddress })
      await newToken.transfer(secondAddress, amount.toString(), {
        from: thirdAddress
      }) // whitelist address
      thirdBalance = await newToken.balanceOf(thirdAddress)
      assert.equal("0", thirdBalance.toString(), "check third address balance")
    })

    after(async () => {
      await uniswapV2Pair.sync()
      await uniswapV2Pair.skim(firstAddress)
    })
  })

  describe("Integration with Locked Deal and Whitelist Contract", () => {
    const secondAddress = accounts[1],
      thirdAddress = accounts[2],
      fourthAddress = accounts[3],
      fifthAddress = accounts[4]
    const amount = new BigNumber(10 ** 19)

    const runSimulation = (amountToActivate, blockTime) => {
      let totalAmount = new BigNumber(0),
        creditableAmount = new BigNumber(0)
      const unlockTimes = [],
        unlockAmounts = []
      for (let i = 0; i < timestamps.length; i++) {
        const amount = amountToActivate.multipliedBy(ratios[i]).dividedToIntegerBy(ratios.length)
        totalAmount = totalAmount.plus(amount)
        if (timestamps[i] <= blockTime) {
          creditableAmount = creditableAmount.plus(amount)
        } else {
          unlockTimes.push(timestamps[i])
          unlockAmounts.push(amount)
        }
      }
      if (totalAmount.isLessThan(amountToActivate)) {
        const difference = amountToActivate.minus(totalAmount)
        if (unlockAmounts.length) {
          unlockAmounts[unlockAmounts.length - 1] = unlockAmounts[unlockAmounts.length - 1].plus(difference)
        } else {
          creditableAmount = creditableAmount.plus(difference)
        }
        totalAmount = totalAmount.plus(difference)
      }
      // console.log(totalAmount.toString())
      // console.log(creditableAmount.toString())
      // unlockTimes.forEach(item => {
      //     console.log(item.toString())
      // })
      // unlockAmounts.forEach(item => {
      //     console.log(item.toString())
      // })
      return { totalAmount, creditableAmount, unlockTimes, unlockAmounts }
    }

    const getLockedDealData = async (dealId, ownerAddress) => {
      const data = await lockedDealContract.GetPoolData(dealId, {
        from: ownerAddress
      })
      return {
        unlockTime: data[0],
        amount: data[1],
        owner: data[2],
        tokenAddress: data[3]
      }
    }

    before(async () => {
      // sending token to 4 addresses
      await token.transfer(secondAddress, amount.toString(), {
        from: firstAddress
      })
      await token.transfer(thirdAddress, amount.toString(), {
        from: firstAddress
      })
      await token.transfer(fourthAddress, amount.toString(), {
        from: firstAddress
      })
      await token.transfer(fifthAddress, amount.toString(), {
        from: firstAddress
      })
    })

    after(async () => {
      const now = Date.now()
      await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
    })

    it("should fail to transfer token before FinishTime to Non Whitelisted Address", async () => {
      const tx = token.transfer(thirdAddress, amount.toString(), {
        from: secondAddress
      })
      await truffleAssert.reverts(tx, "Sorry, no alocation for Subject")
    })

    it("should successfully transfer tokens to whitelisted address before FinishTime", async () => {
      await whitelistContract.AddAddress(
        whitelistId,
        [secondAddress, thirdAddress],
        [amount.toString(), amount.toString()]
      )
      await token.transfer(thirdAddress, amount.toString(), {
        from: secondAddress
      })
      const balance3 = await token.balanceOf(thirdAddress)
      assert.equal(balance3.toString(), amount.multipliedBy(2).toString())
      await token.transfer(secondAddress, amount.toString(), {
        from: thirdAddress
      })
      const balance2 = await token.balanceOf(secondAddress)
      assert.equal(balance2.toString(), amount.toString())
    })

    it("simulation for no unlock", async () => {
      // await timeMachine.advanceBlockAndSetTime(timestamps[1])
      const data = await token.getActivationResult(amount.toString())
      const time = new Date().getTime / 1000
      const now = Math.floor(time)
      const sim = runSimulation(amount, now)
      assert.equal(data[0].toString(), sim.totalAmount.toString())
      assert.equal(data[1].toString(), sim.creditableAmount.toString())
      data[2].forEach((item, index) => {
        assert.equal(item.toString(), sim.unlockTimes[index].toString())
      })
      data[3].forEach((item, index) => {
        assert.equal(item.toString(), sim.unlockAmounts[index].toString())
      })
    })
    it("simulation for first unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[0])
      const data = await token.getActivationResult(amount.toString())
      const sim = runSimulation(amount, timestamps[0])
      assert.equal(data[0].toString(), sim.totalAmount.toString())
      assert.equal(data[1].toString(), sim.creditableAmount.toString())
      data[2].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockTimes[index].toString())
      })
      data[3].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockAmounts[index].toString())
      })
    })
    it("simulation for second unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[1])
      const data = await token.getActivationResult(amount.toString())
      const sim = runSimulation(amount, timestamps[1])
      assert.equal(data[0].toString(), sim.totalAmount.toString())
      assert.equal(data[1].toString(), sim.creditableAmount.toString())
      data[2].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockTimes[index].toString())
      })
      data[3].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockAmounts[index].toString())
      })
    })
    it("simulation for third unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[2])
      const data = await token.getActivationResult(amount.toString())
      const sim = runSimulation(amount, timestamps[2])
      assert.equal(data[0].toString(), sim.totalAmount.toString())
      assert.equal(data[1].toString(), sim.creditableAmount.toString())
      data[2].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockTimes[index].toString())
      })
      data[3].forEach((item, index) => {
        if (item.toString() === "0") return
        assert.equal(item.toString(), sim.unlockAmounts[index].toString())
      })
      const now = Date.now()
      await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
    })

    it("activating token before all unlocks", async () => {
      const userSyntheticBalance = await token.balanceOf(secondAddress)
      const time = new Date().getTime / 1000
      const now = Math.floor(time)
      const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), now)
      const tx = await token.ActivateSynthetic({ from: secondAddress })
      const deals = await lockedDealContract.GetMyPoolsId({
        from: secondAddress
      })
      const userOriginalBalance = await originalToken.balanceOf(secondAddress)
      assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
      assert.equal(tx.logs[tx.logs.length - 1].args.Amount.toString(), sim.totalAmount.toString())
      const promises = []
      deals.forEach(async (item) => {
        promises.push(getLockedDealData(item.toString(), secondAddress))
      })
      const dealData = await Promise.all(promises)
      assert.equal(dealData.length, sim.unlockTimes.length)
      dealData.forEach((item, index) => {
        assert.equal(item.unlockTime.toString(), sim.unlockTimes[index].toString())
        assert.equal(item.amount.toString(), sim.unlockAmounts[index].toString())
        assert.equal(item.owner, secondAddress)
        assert.equal(item.tokenAddress, originalToken.address)
      })
    })

    it("activating token after first unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[0])
      const userSyntheticBalance = await token.balanceOf(thirdAddress)
      const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[0])
      const tx = await token.ActivateSynthetic({ from: thirdAddress })
      const deals = await lockedDealContract.GetMyPoolsId({
        from: thirdAddress
      })
      const userOriginalBalance = await originalToken.balanceOf(thirdAddress)
      assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
      assert.equal(tx.logs[tx.logs.length - 1].args.Amount.toString(), sim.totalAmount.toString())
      const promises = []
      deals.forEach(async (item) => {
        promises.push(getLockedDealData(item.toString(), thirdAddress))
      })
      const dealData = await Promise.all(promises)
      assert.equal(dealData.length, sim.unlockTimes.length)
      dealData.forEach((item, index) => {
        assert.equal(item.unlockTime.toString(), sim.unlockTimes[index].toString())
        assert.equal(item.amount.toString(), sim.unlockAmounts[index].toString())
        assert.equal(item.owner, thirdAddress)
        assert.equal(item.tokenAddress, originalToken.address)
      })
    })
    it("activating token after second unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[1])
      const userSyntheticBalance = await token.balanceOf(fourthAddress)
      const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[1])
      const tx = await token.ActivateSynthetic({ from: fourthAddress })
      const deals = await lockedDealContract.GetMyPoolsId({
        from: fourthAddress
      })
      const userOriginalBalance = await originalToken.balanceOf(fourthAddress)
      assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
      assert.equal(tx.logs[tx.logs.length - 1].args.Amount.toString(), sim.totalAmount.toString())
      const promises = []
      deals.forEach(async (item) => {
        promises.push(getLockedDealData(item.toString(), fourthAddress))
      })
      const dealData = await Promise.all(promises)
      assert.equal(dealData.length, sim.unlockTimes.length)
      dealData.forEach((item, index) => {
        assert.equal(item.unlockTime.toString(), sim.unlockTimes[index].toString())
        assert.equal(item.amount.toString(), sim.unlockAmounts[index].toString())
        assert.equal(item.owner, fourthAddress)
        assert.equal(item.tokenAddress, originalToken.address)
      })
    })
    it("activating token after third unlock", async () => {
      await timeMachine.advanceBlockAndSetTime(timestamps[2])
      const userSyntheticBalance = await token.balanceOf(fifthAddress)
      const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[2])
      const tx = await token.ActivateSynthetic({ from: fifthAddress })
      const deals = await lockedDealContract.GetMyPoolsId({
        from: fifthAddress
      })
      const userOriginalBalance = await originalToken.balanceOf(fifthAddress)
      assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
      assert.equal(tx.logs[tx.logs.length - 1].args.Amount.toString(), sim.totalAmount.toString())
      const promises = []
      deals.forEach(async (item) => {
        promises.push(getLockedDealData(item.toString(), fifthAddress))
      })
      const dealData = await Promise.all(promises)
      assert.equal(dealData.length, sim.unlockTimes.length)
      dealData.forEach((item, index) => {
        assert.equal(item.unlockTime.toString(), sim.unlockTimes[index].toString())
        assert.equal(item.amount.toString(), sim.unlockAmounts[index].toString())
        assert.equal(item.owner, fifthAddress)
        assert.equal(item.tokenAddress, originalToken.address)
      })
    })
  })
})
