const Token = artifacts.require("POOLZSYNT")
const TestToken = artifacts.require("OriginalToken")
const LockedDeal = artifacts.require("LockedDeal")
const WhiteList = artifacts.require("WhiteList")
const ThePoolz = artifacts.require("ThePoolz")
const UniswapV2Factory = artifacts.require("UniswapV2Factory")
const UniswapV2Pair = artifacts.require("UniswapV2Pair")
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')
const BigNumber = require("bignumber.js")
const timeMachine = require('ganache-time-traveler')
BigNumber.config({ EXPONENTIAL_AT: 1e+9 })

const { createNewWhiteList } = require('./helper')

contract('Integration Between Envelop Token, WhiteList and LockedDeal', accounts => {
    let token, originalToken, lockedDealContract, firstAddress = accounts[0]
    let whiteList, uniswapV2Factory, uniswapV2Pair, poolzBack, liquidity, id
    const cap = new BigNumber(10000)
    const timestamps = []
    const ratios = [1, 1, 1]

    before(async () => {
        originalToken = await TestToken.new('OrgToken', 'ORGT', { from: firstAddress })
        lockedDealContract = await LockedDeal.new()
        whiteList = await WhiteList.deployed()
        uniswapV2Factory = await UniswapV2Factory.deployed()
        poolzBack = await ThePoolz.deployed()
        const now = new Date()
        timestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
        timestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
        timestamps.push((now.setHours(now.getHours() + 1) / 1000).toFixed())
    })

    describe('setting up Envelop Token', () => {
        it('should deploy new envelop token', async () => {
            const tokenName = "REAL Synthetic"
            const tokenSymbol = "~REAL Poolz"
            const _decimals = '18'
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            id = tx.logs[0].args._WhiteListCount.toString()
            token = await Token.new(tokenName, tokenSymbol, cap.toString(), _decimals, firstAddress, lockedDealContract.address, whiteList.address, { from: firstAddress })
            const name = await token.name()
            const symbol = await token.symbol()
            const firstBalance = await token.balanceOf(firstAddress)
            const decimals = await token.decimals()
            const capp = await token.cap()
            const expectedCapp = '10000000000000000000000'
            const lockedAddress = await token.LockedDealAddress()
            const whitelistAddress = await token.WhitelistAddress()
            assert.equal(tokenName, name, 'check name')
            assert.equal(tokenSymbol, symbol, 'check symbol')
            assert.equal(decimals.toString(), _decimals, 'check decimals')
            assert.equal(firstBalance.toString(), cap.multipliedBy(10 ** 18).toString(), 'check first address balance')
            assert.equal(lockedAddress, lockedDealContract.address, 'check lockedDeal address')
            assert.equal(whitelistAddress, whiteList.address, 'check whitelist address')
            assert.equal(capp, expectedCapp, 'check capitalization')
        })

        it('should set locking details', async () => {
            await originalToken.approve(token.address, cap.multipliedBy(10 ** 18).toString(), { from: firstAddress })
            const approval = await originalToken.allowance(firstAddress, token.address)
            const balance = await originalToken.balanceOf(firstAddress)
            const time = new Date()
            time.setDate(time.getDate() + 1)
            const future = Math.floor(time.getTime() / 1000) + 60
            const tx = await token.SetLockingDetails(originalToken.address, timestamps, ratios, future, id, { from: firstAddress })
            const originalAddress = tx.logs[3].args.TokenAddress
            const totalAmount = tx.logs[3].args.Amount
            const totalUnlocks = tx.logs[3].args.TotalUnlocks
            const finishTime = tx.logs[3].args.FinishTime
            const tokenCap = await token.cap()
            const whitelistId = await token.WhitelistId()
            assert.equal(originalToken.address, originalAddress, 'check token address')
            assert.equal(totalAmount.toString(), tokenCap.toString(), 'check total amount')
            assert.equal(totalUnlocks, timestamps.length, 'check total unlocks')
            assert.equal(finishTime, time, 'check finish time')
            assert.equal(whitelistId.toString(), id.toString(), 'check whitelist ID')
        })

        it('verifying locking details', async () => {
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

        it('should set whitelist address', async () => {
            const oldWhiteList = whiteList.address
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            const oldID = id
            id = tx.logs[0].args._WhiteListCount.toString()
            await token.setWhiteListAddress(whiteList.address)
            await token.setWhiteListId(id)
            const whiteListAddress = await token.WhitelistAddress()
            const whiteListID = await token.WhitelistId()
            assert.notEqual(oldID, id)
            assert.equal(whiteListID, id)
            assert.notEqual(oldWhiteList, whiteList.address)
            assert.equal(whiteList.address, whiteListAddress)
            // await token.setWhiteListAddress(oldWhiteList)
            // await token.setWhiteListId(oldID)
            // await whiteList.ChangeContract(oldID, oldWhiteList)
        })
    })

    describe('Integration with LP contract', () => {
        let testToken
        it('create liquidity pair with synth token', async () => {
            testToken = await TestToken.new('TestToken', 'TEST', { from: firstAddress })
            await uniswapV2Factory.createPair(token.address, testToken.address, { from: firstAddress })
            const pair = await uniswapV2Factory.getPair(token.address, testToken.address)
            uniswapV2Pair = await UniswapV2Pair.at(pair)
            const [token0, token1] = token.address < testToken.address ? [token.address, testToken.address] : [testToken.address, token.address]
            assert.equal(token0, (await uniswapV2Pair.token0()), 'check first token address')
            assert.equal(token1, (await uniswapV2Pair.token1()), 'check second token address')
        })

        it('add liquidity with synth token', async () => {
            const amount = '15000000'
            await token.transfer(uniswapV2Pair.address, amount)
            await testToken.transfer(uniswapV2Pair.address, amount)
            liquidity = await uniswapV2Pair.mint.call(firstAddress)
            await uniswapV2Pair.mint(firstAddress)
            const reserve0 = (await uniswapV2Pair.getReserves())['0']
            const reserve1 = (await uniswapV2Pair.getReserves())['1']
            assert.equal(reserve0, amount, 'check first token reserve')
            assert.equal(reserve1, amount, 'check second token reserve')
        })

        it('should transfer when in whitelist', async () => {
            const whitelistAddress = accounts[5]
            let result = await whiteList.Check(whitelistAddress, id)
            assert.equal(result, 0)
            await whiteList.AddAddress(id, [whitelistAddress], ['10000000'])
            result = await whiteList.Check(whitelistAddress, id)
            assert.equal(result.toString(), '10000000')
            const transferAmount = '1999980000000'
            const swapAmount = '1000'
            await token.transfer(uniswapV2Pair.address, transferAmount)
            await testToken.transfer(uniswapV2Pair.address, transferAmount)
            await uniswapV2Pair.swap(swapAmount, swapAmount, whitelistAddress, '0x', { from: whitelistAddress })
        })

        it('should revert when not in whitelist', async () => {
            const notWhitelistAddress = accounts[6]
            const amount = '1000'
            const result = await whiteList.Check(notWhitelistAddress, id)
            assert.equal(result, 0)
            await truffleAssert.reverts(uniswapV2Pair.swap(amount, amount, notWhitelistAddress, '0x', { from: notWhitelistAddress }))
        })

        it('check transfer time and To address', async () => {
            const secondAddress = accounts[1]
            const thirdAddress = accounts[2]
            const amount = 1000
            const tokenName = "REAL Synthetic"
            const tokenSymbol = "~REAL Poolz"
            const _decimals = '18'
            const time = new Date()
            time.setDate(time.getDate() - 1)
            const past = Math.floor(time.getTime() / 1000) + 60
            const testToken2 = await TestToken.new('TEST2', 'TEST2', { from: secondAddress })
            const newToken = await Token.new(tokenName, tokenSymbol, cap.toString(), _decimals, secondAddress, lockedDealContract.address, whiteList.address, { from: secondAddress  })
            await testToken2.approve(newToken.address, cap.multipliedBy(10 ** 18).toString(), { from: secondAddress })
            await newToken.SetLockingDetails(testToken2.address, timestamps, ratios, past, id, { from: secondAddress })
            await newToken.transfer(thirdAddress, amount.toString(), {from: secondAddress})
            let thirdBalance = await token.balanceOf(thirdAddress)
            assert.equal(thirdBalance.toString(), amount.toString(), 'check third address balance')
            await truffleAssert.reverts(newToken.transfer(secondAddress, (amount - 1).toString(), {from: thirdAddress}), "Invalid Transfer Time or To Address")
            await whiteList.AddAddress(id, [thirdAddress], ['10000000'])
            await newToken.transfer(secondAddress, (amount - 1).toString(), {from: thirdAddress})
            thirdBalance = await newToken.balanceOf(thirdBalance)
            assert.equal('1', thirdBalance.toString(), 'check third address balance')
        })
    })

    describe('Integration with locked deal contract', () => {
        const secondAddress = accounts[1], thirdAddress = accounts[2], fourthAddress = accounts[3], fifthAddress = accounts[4]
        const ten = new BigNumber(18)
        const amount = new BigNumber(10 ** 19)

        const runSimulation = (amountToActivate, blockTime) => {
            let totalAmount = new BigNumber(0), creditableAmount = new BigNumber(0)
            const unlockTimes = [], unlockAmounts = []
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
            const data = await lockedDealContract.GetPoolData(dealId, { from: ownerAddress })
            return {
                unlockTime: data[0],
                amount: data[1],
                owner: data[2],
                tokenAddress: data[3]
            }
        }

        before(async () => {
            // sending token to 3 addresses
            const balance = await token.balanceOf(firstAddress)
            await token.transfer(secondAddress, amount.toString(), { from: firstAddress })
            await token.transfer(thirdAddress, amount.toString(), { from: firstAddress })
            await token.transfer(fourthAddress, amount.toString(), { from: firstAddress })
            await token.transfer(fifthAddress, amount.toString(), { from: firstAddress })
        })

        after(async () => {
            const now = Date.now()
            await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
        })

        it('should set locked deal contract address', async () => {
            await token.SetLockedDealAddress(lockedDealContract.address, { from: firstAddress })
            const address = await token.LockedDealAddress()
            assert.equal(lockedDealContract.address, address)
        })

        it('simulation for no unlock', async () => {
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
        it('simulation for first unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[0])
            const data = await token.getActivationResult(amount.toString())
            const sim = runSimulation(amount, timestamps[0])
            assert.equal(data[0].toString(), sim.totalAmount.toString())
            assert.equal(data[1].toString(), sim.creditableAmount.toString())
            data[2].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockTimes[index].toString())
            })
            data[3].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockAmounts[index].toString())
            })
        })
        it('simulation for second unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[1])
            const data = await token.getActivationResult(amount.toString())
            const sim = runSimulation(amount, timestamps[1])
            assert.equal(data[0].toString(), sim.totalAmount.toString())
            assert.equal(data[1].toString(), sim.creditableAmount.toString())
            data[2].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockTimes[index].toString())
            })
            data[3].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockAmounts[index].toString())
            })
        })
        it('simulation for third unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[2])
            const data = await token.getActivationResult(amount.toString())
            const sim = runSimulation(amount, timestamps[2])
            assert.equal(data[0].toString(), sim.totalAmount.toString())
            assert.equal(data[1].toString(), sim.creditableAmount.toString())
            data[2].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockTimes[index].toString())
            })
            data[3].forEach((item, index) => {
                if (item.toString() === '0') return
                assert.equal(item.toString(), sim.unlockAmounts[index].toString())
            })
            const now = Date.now()
            await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
        })

        it('activating token before all unlocks', async () => {
            const userSyntheticBalance = await token.balanceOf(secondAddress)
            const time = new Date().getTime / 1000
            const now = Math.floor(time)
            const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), now)
            const tx = await token.ActivateSynthetic({ from: secondAddress })
            const deals = await lockedDealContract.GetMyPoolsId({ from: secondAddress })
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

        it('activating token after first unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[0])
            const userSyntheticBalance = await token.balanceOf(thirdAddress)
            const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[0])
            const tx = await token.ActivateSynthetic({ from: thirdAddress })
            const deals = await lockedDealContract.GetMyPoolsId({ from: thirdAddress })
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
        it('activating token after second unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[1])
            const userSyntheticBalance = await token.balanceOf(fourthAddress)
            const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[1])
            const tx = await token.ActivateSynthetic({ from: fourthAddress })
            const deals = await lockedDealContract.GetMyPoolsId({ from: fourthAddress })
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
        it('activating token after third unlock', async () => {
            await timeMachine.advanceBlockAndSetTime(timestamps[2])
            const userSyntheticBalance = await token.balanceOf(fifthAddress)
            const sim = runSimulation(new BigNumber(userSyntheticBalance.toString()), timestamps[2])
            const tx = await token.ActivateSynthetic({ from: fifthAddress })
            const deals = await lockedDealContract.GetMyPoolsId({ from: fifthAddress })
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