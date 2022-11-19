const Token = artifacts.require("POOLZSYNT")
const TestToken = artifacts.require("OriginalToken")
const LockedDealV2 = artifacts.require("LockedDealV2")
const WhiteList = artifacts.require("WhiteList")
const UniswapV2Factory = artifacts.require("UniswapV2Factory")
const UniswapV2Pair = artifacts.require("UniswapV2Pair")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const BigNumber = require("bignumber.js")
const timeMachine = require("ganache-time-traveler")
BigNumber.config({ EXPONENTIAL_AT: 1e9 })
const { uintMinusOne } = require("./helper/index")

contract("Integration Between Envelop Token, WhiteList and LockedDeal", (accounts) => {
    let token,
        originalToken,
        lockedDealContract,
        whitelistContract,
        firstAddress = accounts[0]
    let uniswapV2Factory, uniswapV2Pair, whitelistId
    let finishTime = parseInt(new Date().setHours(new Date().getHours() + 1) / 1000) // current time + 1H
    const cap = new BigNumber(10000)
    const startTimestamps = [],
        finishTimestamps = []
    const ratios = [1, 1, 1]
    const tokenName = "REAL Synthetic"
    const tokenSymbol = "~REAL Poolz"
    const decimals = "18"

    before(async () => {
        originalToken = await TestToken.new("OrgToken", "ORGT")
        lockedDealContract = await LockedDealV2.new()
        uniswapV2Factory = await UniswapV2Factory.deployed()
        whitelistContract = await WhiteList.new()
        const now = new Date()
        startTimestamps.push((now.setHours(now.getHours() + 2) / 1000).toFixed()) // current time + 2H
        startTimestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
        startTimestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())

        finishTimestamps.push((now.setHours(now.getHours() + 4) / 1000).toFixed()) // current time + 4H
        finishTimestamps.push((now.setHours(now.getHours() + 3) / 1000).toFixed())
        finishTimestamps.push((now.setHours(now.getHours() + 3) / 1000).toFixed())
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
                whitelistContract.address
            )
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
            assert.equal(firstAddress, whitelistSettings.Creator, "Check whitelist creator")
            assert.equal(uintMinusOne, whitelistSettings.ChangeUntil.toString(), "check change until from whitelist")
            assert.equal(token.address, whitelistSettings.Contract, "check white list contract address")
            assert.equal(false, whitelistSettings.isReady, "check whitelist status")
        })

        it("should set locking details", async () => {
            await originalToken.approve(token.address, cap.multipliedBy(10 ** 18).toString())
            const tx = await token.SetLockingDetails(
                originalToken.address,
                startTimestamps,
                finishTimestamps,
                ratios,
                finishTime.toString()
            )
            const originalAddress = tx.logs[3].args.TokenAddress
            const totalAmount = tx.logs[3].args.Amount
            const tokenCap = await token.cap()
            assert.equal(originalToken.address, originalAddress)
            assert.equal(totalAmount.toString(), tokenCap.toString())
        })

        it("verifying locking details", async () => {
            const orgToken = await token.OriginalTokenAddress()
            const finish = await token.EndTime()
            const TotalLocks = await token.TotalLocks()
            assert.equal(TotalLocks, startTimestamps.length)
            assert.equal(orgToken, originalToken.address)
            assert.equal(finishTime.toString(), finish.toString())
            for (let i = 0; i < TotalLocks; i++) {
                const details = await token.LockDetails(i)
                assert.equal(details.startTime.toString(), startTimestamps[i].toString())
                assert.equal(details.finishTime.toString(), finishTimestamps[i].toString())
                assert.equal(details.ratio.toString(), ratios[i].toString())
            }
        })

        describe("Integration with Locked Deal and Whitelist Contract", () => {
            const secondAddress = accounts[1],
                thirdAddress = accounts[2],
                fourthAddress = accounts[3],
                fifthAddress = accounts[4]
            const amount = new BigNumber(10 ** 19)

            before(async () => {
                // sending token to 4 addresses
                await token.transfer(secondAddress, amount.toString())
                await token.transfer(thirdAddress, amount.toString())
                await token.transfer(fourthAddress, amount.toString())
                await token.transfer(fifthAddress, amount.toString())
            })

            const runSimulation = (amountToActivate, blockTime) => {
                let creditableAmount = new BigNumber(0)
                let lockStartTimes = [],
                    lockAmounts = []
                for (let i = 0; i < startTimestamps.length; i++) {
                    let amount = amountToActivate.multipliedBy(ratios[i]).dividedToIntegerBy(ratios.length)
                    if (finishTimestamps[i] <= blockTime) {
                        creditableAmount = creditableAmount.plus(amount)
                        lockStartTimes.push(0)
                        lockAmounts.push(0)
                    } else if (startTimestamps[i] <= blockTime) {
                        let totalPoolDuration = new BigNumber(finishTimestamps[i] - startTimestamps[i])
                        let timePassed = new BigNumber(blockTime - startTimestamps[i])
                        let timePassedPermille = timePassed.multipliedBy(1000)
                        let ratioPermille = timePassedPermille.dividedToIntegerBy(totalPoolDuration)
                        let _creditableAmount = amount.multipliedBy(ratioPermille).dividedToIntegerBy(1000)
                        creditableAmount = creditableAmount.plus(_creditableAmount)
                        lockStartTimes.push(blockTime)
                        lockAmounts.push(amount.minus(_creditableAmount))
                    } else if (startTimestamps[i] > blockTime) {
                        lockStartTimes.push(startTimestamps[i])
                        lockAmounts.push(amount)
                    }
                }
                return { creditableAmount, lockStartTimes, lockAmounts }
            }

            const getLockedDealData = async (dealId) => {
                const data = await lockedDealContract.GetPoolsData([dealId])
                return {
                    startTime: data[0].StartTime,
                    finishTime: data[0].FinishTime,
                    DebitedAmount: data[0].DebitedAmount,
                    StartAmount: data[0].StartAmount,
                    owner: data[0].Owner,
                    tokenAddress: data[0].Token
                }
            }

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
                const time = new Date().getTime() / 1000
                const now = Math.floor(time)
                const data = await token.getWithdrawableAmount(amount.toString())
                const sim = runSimulation(amount, now)
                assert.equal(data[0].toString(), sim.creditableAmount.toString())
                assert.equal(data[1].toString(), sim.lockStartTimes.toString())
                assert.equal(data[2].toString(), sim.lockAmounts.toString())
            })

            it("simulation after finish time", async () => {
                const day = 24 * 60 * 60
                const week = day * 7
                await timeMachine.advanceBlockAndSetTime(parseInt(finishTimestamps[0]) + week)
                const sim = runSimulation(amount, parseInt(finishTimestamps[0]) + week)
                const data = await token.getWithdrawableAmount(amount.toString())
                assert.equal(data[0].toString(), sim.creditableAmount.toString())
                assert.equal(data[1].toString(), sim.lockStartTimes.toString())
                assert.equal(data[2].toString(), sim.lockAmounts.toString())
            })

            it("simulation between start and finish times", async () => {
                const hour = 60 * 60
                for (let i = 0; i < finishTimestamps.length; i++) {
                    await timeMachine.advanceBlockAndSetTime(parseInt(startTimestamps[i]) + hour)
                    const sim = runSimulation(amount, parseInt(startTimestamps[i]) + hour)
                    const data = await token.getWithdrawableAmount(amount.toString())
                    assert.equal(data[0].toString(), sim.creditableAmount.toString())
                    assert.equal(data[1].toString(), sim.lockStartTimes.toString())
                    assert.equal(data[2].toString(), sim.lockAmounts.toString())
                }
            })

            it("activating token before all unlocks", async () => {
                await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
                const userSyntheticBalance = await token.balanceOf(secondAddress)
                const time = new Date().getTime() / 1000
                const now = Math.floor(time)
                const amount = new BigNumber(userSyntheticBalance.toString())
                await token.WithdrawToken({ from: secondAddress })
                const sim = runSimulation(amount, now)
                const deals = await lockedDealContract.GetMyPoolsId(secondAddress)
                const userOriginalBalance = await originalToken.balanceOf(secondAddress)
                assert.equal(userOriginalBalance.toString(), 0)
                const promises = []
                deals.forEach(async (item) => {
                    promises.push(getLockedDealData(item.toString(), secondAddress))
                })
                const dealData = await Promise.all(promises)
                assert.equal(dealData.length, sim.lockStartTimes.length)
                dealData.forEach((item, index) => {
                    assert.equal(item.startTime.toString(), sim.lockStartTimes[index].toString())
                    assert.equal(item.StartAmount.toString(), sim.lockAmounts[index].toString())
                    assert.equal(item.owner, secondAddress)
                    assert.equal(item.tokenAddress, originalToken.address)
                })
            })

            it("activating token between start and finish times", async () => {
                const hour = 60 * 60
                for (let i = 1; i < finishTimestamps.length; i++) {
                    await timeMachine.advanceBlockAndSetTime(parseInt(startTimestamps[i]) + hour)
                    const userSyntheticBalance = await token.balanceOf(accounts[2 + i])
                    const sim = runSimulation(
                        new BigNumber(userSyntheticBalance.toString()),
                        parseInt(startTimestamps[i]) + hour
                    )
                    await token.WithdrawToken({ from: accounts[2 + i] })
                    const deals = await lockedDealContract.GetMyPoolsId(accounts[2 + i])
                    const userOriginalBalance = await originalToken.balanceOf(accounts[2 + i])
                    assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
                    const promises = []
                    deals.forEach(async (item) => {
                        promises.push(getLockedDealData(item.toString(), accounts[2 + i]))
                    })
                    const dealData = await Promise.all(promises)
                    assert.equal(dealData.length, sim.lockStartTimes.length)
                    dealData.forEach((item, index) => {
                        assert.equal(item.startTime.toString(), sim.lockStartTimes[index].toString())
                        assert.equal(item.StartAmount.toString(), sim.lockAmounts[index].toString())
                        assert.equal(item.owner, accounts[2 + i])
                        assert.equal(item.tokenAddress, originalToken.address)
                    })
                }
            })

            it("activating token after finish time", async () => {
                const day = 24 * 60 * 60
                const week = day * 7
                await timeMachine.advanceBlockAndSetTime(parseInt(finishTimestamps[0]) + week)
                const userSyntheticBalance = await token.balanceOf(thirdAddress)
                const sim = runSimulation(
                    new BigNumber(userSyntheticBalance.toString()),
                    parseInt(finishTimestamps[0]) + week
                )
                const tx = await token.WithdrawToken({ from: thirdAddress })
                const userOriginalBalance = await originalToken.balanceOf(thirdAddress)
                assert.equal(userOriginalBalance.toString(), sim.creditableAmount.toString())
                //assert.equal(tx.logs[tx.logs.length - 1].args.Amount.toString(), sim.creditableAmount.toString())
            })

            after(async () => {
                const now = Date.now()
                await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
            })
        })

        describe("Integration with LP contract", () => {
            let testToken
            it("create liquidity pair with synth token", async () => {
                testToken = await TestToken.new("TestToken", "TEST")
                await uniswapV2Factory.createPair(token.address, testToken.address)
                const pair = await uniswapV2Factory.getPair(token.address, testToken.address)
                uniswapV2Pair = await UniswapV2Pair.at(pair)
                const [token0, token1] =
                    token.address < testToken.address
                        ? [token.address, testToken.address]
                        : [testToken.address, token.address]
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
                    uniswapV2Pair.swap(swapAmount, swapAmount, notWhitelistAddress, "0x", {
                        from: notWhitelistAddress
                    }),
                    "UniswapV2: TRANSFER_FAILED"
                )
                // check transfer if add notWhitelistAddress to whitelist
                await whitelistContract.AddAddress(whitelistId, [notWhitelistAddress], ["10000000"])
                await uniswapV2Pair.swap(swapAmount, swapAmount, notWhitelistAddress, "0x", {
                    from: notWhitelistAddress
                })
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
                await testToken2.approve(newToken.address, cap.multipliedBy(10 ** 18).toString(), {
                    from: secondAddress
                })
                await newToken.SetLockingDetails(testToken2.address, startTimestamps, finishTimestamps, ratios, past, {
                    from: secondAddress
                })
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
    })
})
