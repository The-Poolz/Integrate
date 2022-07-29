const ThePoolz = artifacts.require("ThePoolz")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require('WhiteList')
const LockedDeal = artifacts.require("LockedDeal")
const { assert, should } = require('chai')
const truffleAssert = require('truffle-assertions')
const timeMachine = require('ganache-time-traveler')
const BigNumber = require('bignumber.js')
const constants = require("@openzeppelin/test-helpers/src/constants")
var BN = web3.utils.BN

const pozRate = new BN('1000000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN('500000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN('3000000') //3 tokens for sale
const invest = web3.utils.toWei('1', 'ether') //1eth

const { createNewWhiteList } = require('./helper')

contract('Interation Between PoolzBack and WhiteList for Investing', (accounts) => {
    let poolzBack, ethTestToken, ercTestToken, whiteList, lockedDeal, mainCoin, firstAddress = accounts[0]
    let tokenWhiteListId, mainCoinWhiteListId
    let ethInvestor, ethAllowance, ercInvestor, ercAllowance
    let ethPoolId, ercPoolId, ercPoolId2

    const ercPozRate = new BN('100')
    const ercPublicRate = new BN('50')

    before(async () => {
        poolzBack = await ThePoolz.deployed()
        whiteList = await WhiteList.deployed()
        lockedDeal = await LockedDeal.new()
        ethTestToken = await Token.new('TestToken', 'TEST')
        ercTestToken = await Token.new('TestToken', 'TEST')
        mainCoin = await Token.new('TestMainToken', 'TESTM')
    })

    describe('WhiteList Setup', () => {
        it('Creating new WhiteList for Main Coin', async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            mainCoinWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it('Creating new WhiteList for Token', async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            tokenWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it('should add Main Coin Address to whiteList ID 1', async () => {
            const addressArray = [mainCoin.address]
            const allowanceArray = [100000000] // random allowance
            await whiteList.AddAddress(mainCoinWhiteListId, addressArray, allowanceArray, { from: firstAddress })
            const result = await whiteList.Check(mainCoin.address, mainCoinWhiteListId)
            assert.equal(result, 100000000)
        })

        it('should add ethTestToken and ercTestToken Address to whiteList ID 2', async () => {
            const addressArray = [ethTestToken.address, ercTestToken.address]
            const allowanceArray = [100000000, 100000000] // random allowance
            await whiteList.AddAddress(tokenWhiteListId, addressArray, allowanceArray, { from: firstAddress })
            const result = await whiteList.Check(ethTestToken.address, tokenWhiteListId)
            assert.equal(result, 100000000)
        })
    })

    describe('PoolzBack Setup', () => {
        it('should set whitelist address', async () => {
            await poolzBack.SetWhiteList_Address(whiteList.address, { from: firstAddress })
            const result = await poolzBack.WhiteList_Address()
            assert.equal(whiteList.address, result)
        })
        it('should set Token WhiteList ID', async () => {
            await poolzBack.setTokenWhitelistId(tokenWhiteListId, { from: firstAddress })
            const result = await poolzBack.TokenWhitelistId()
            assert.equal(tokenWhiteListId, result)
        })
        it('should set Main Coin WhiteList ID', async () => {
            await poolzBack.setMCWhitelistId(mainCoinWhiteListId, { from: firstAddress })
            const result = await poolzBack.MCWhitelistId()
            assert.equal(mainCoinWhiteListId, result)
        })
        it('should set Token Filter to true', async () => {
            await poolzBack.SwapTokenFilter({ from: firstAddress })
            const result = await poolzBack.IsTokenFilterOn()
            assert.equal(true, result)
        })
    })

    describe('Creating Whitelist of Investors and New Pool', () => {
        describe('New ETH Pool', () => {
            let investorWhiteListId
            it('should create new whitelist for investors', async () => {
                const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
                investorWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
            })

            it('should grant allowances to investers', async () => {
                ethInvestor = [accounts[9], accounts[8], accounts[7], accounts[6]]
                ethAllowance = []
                ethAllowance.push(web3.utils.toWei('0.4'))
                ethAllowance.push(web3.utils.toWei('0.3'))
                ethAllowance.push(web3.utils.toWei('0.2'))
                ethAllowance.push(web3.utils.toWei('0.1'))
                await whiteList.AddAddress(investorWhiteListId, ethInvestor, ethAllowance, { from: firstAddress })
                ethInvestor.forEach(async (value, index) => {
                    const result = await whiteList.Check(value, investorWhiteListId)
                    assert.equal(result, ethAllowance[index])
                })
            })

            it('should create new pool with ETH as Main Coin', async () => {
                await ethTestToken.approve(poolzBack.address, amount, { from: firstAddress })
                const date = new Date()
                date.setDate(date.getDate() + 1)   // add a day
                const future = Math.floor(date.getTime() / 1000) + 60
                const tx = await poolzBack.CreatePool(ethTestToken.address, future, publicRate, pozRate, amount, 0, constants.ZERO_ADDRESS, true, 0, investorWhiteListId, { from: firstAddress })
                ethPoolId = tx.logs[1].args[1].toString()
                let newpools = await poolzBack.poolsCount.call()
                assert.equal(newpools.toNumber(), 1, "Got 1 pool")
                let tokensInContract = await ethTestToken.balanceOf(poolzBack.address)
                assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
                const result = await poolzBack.GetPoolExtraData(ethPoolId)
                assert.equal(investorWhiteListId, result[1].toString())
            })
        })
        describe('New ERC20 Pool', () => {
            let investorWhiteListId
            it('should create new whitelist for investors', async () => {
                const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
                investorWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
            })

            it('should grant allowances to investers', async () => {
                ercInvestor = [accounts[9], accounts[8], accounts[7], accounts[6]]
                const mainCoinDecimals = await mainCoin.decimals()
                ercAllowance = []
                ercAllowance.push(0.4 * 10 ** mainCoinDecimals)
                ercAllowance.push(0.3 * 10 ** mainCoinDecimals)
                ercAllowance.push(0.2 * 10 ** mainCoinDecimals)
                ercAllowance.push(0.1 * 10 ** mainCoinDecimals)
                await whiteList.AddAddress(investorWhiteListId, ercInvestor, ercAllowance, { from: firstAddress })
                ercInvestor.forEach(async (value, index) => {
                    const result = await whiteList.Check(value, investorWhiteListId)
                    assert.equal(result, ercAllowance[index])
                })
            })

            it('should create new pool with ERC20 as Main Coin', async () => {
                const startAmount = new BN('100000000') // 1000 tokens for sale
                await ercTestToken.approve(poolzBack.address, startAmount, { from: firstAddress })
                const date = new Date()
                date.setDate(date.getDate() + 1)   // add a day
                const future = Math.floor(date.getTime() / 1000) + 60
                const mainCoinDecimals = await mainCoin.decimals()
                const tokenDecimals = await ercTestToken.decimals()
                const d21PozRate = ercPozRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
                const d21PublicRate = ercPublicRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
                const tx = await poolzBack.CreatePool(ercTestToken.address, future, d21PublicRate, d21PozRate, startAmount, 0, mainCoin.address, true, 0, investorWhiteListId, { from: firstAddress })
                ercPoolId = tx.logs[1].args[1].toString()
                let newpools = await poolzBack.poolsCount.call()
                assert.equal(newpools.toNumber(), 2, "Got 1 pool")
                const result = await poolzBack.GetPoolExtraData(ercPoolId)
                assert.equal(investorWhiteListId, result[1].toString())
            })
        })
    })

    describe('Investing in ETH Pool', () => {
        const shouldInvest = async (index) => {
            await poolzBack.InvestETH(ethPoolId, { from: ethInvestor[index], value: ethAllowance[index] })
            const bal = await ethTestToken.balanceOf(ethInvestor[index])
            const tokenDecimals = await ethTestToken.decimals()
            const realRate = pozRate.div(new BN(10).pow(new BN(21 + tokenDecimals.toNumber() - 18))) // converting decimal21Rate to realRate
            const tokens = web3.utils.fromWei(ethAllowance[index]) * realRate
            assert.deepEqual(bal, new BN(tokens).mul(new BN(10).pow(tokenDecimals)))
        }
        it('should invest, for investor 0', async () => {
            await shouldInvest(0)
        })
        it('should invest, for investor 1', async () => {
            await shouldInvest(1)
        })
        it('should invest, for investor 2', async () => {
            await shouldInvest(2)
        })
        it('should invest, for investor 3', async () => {
            await shouldInvest(3)
        })
        it('should Fail to invest when investor not whitelisted', async () => {
            const fakeInvestor = accounts[1]
            await truffleAssert.reverts(poolzBack.InvestETH(ethPoolId, { from: fakeInvestor, value: web3.utils.toWei('0.1') }), 'Sorry, no alocation for Subject')
        })
    })

    describe('Investing in ERC20 Pool', () => {
        const shouldInvest = async (index) => {
            await mainCoin.approve(poolzBack.address, ercAllowance[index], { from: ercInvestor[index] })
            await poolzBack.InvestERC20(ercPoolId, ercAllowance[index], { from: ercInvestor[index] })
            const bal = await ercTestToken.balanceOf(ercInvestor[index])
            const tokenDecimals = await ercTestToken.decimals()
            const mainCoinDecimals = await mainCoin.decimals()
            const tokens = new BigNumber(ercAllowance[index]).div(new BigNumber(10).pow(mainCoinDecimals.toString())).multipliedBy(ercPozRate.toString())
            assert.deepEqual(new BigNumber(bal.toString()), tokens.multipliedBy(new BigNumber(10).pow(tokenDecimals)))
        }
        const fakeInvestor = accounts[1]
        const fakeInvestorAmt = '1000000'
        before(async () => {
            ercInvestor.forEach(async (value, index) => {
                await mainCoin.transfer(value, ercAllowance[index], { from: firstAddress })
                const bal = await mainCoin.balanceOf(value)
                assert.equal(bal.toNumber(), ercAllowance[index])
            })
            await mainCoin.transfer(fakeInvestor, fakeInvestorAmt, { from: firstAddress })
        })
        it('should invest, for investor 0', async () => {
            await shouldInvest(0)
        })
        it('should invest, for investor 1', async () => {
            await shouldInvest(1)
        })
        it('should invest, for investor 2', async () => {
            await shouldInvest(2)
        })
        it('should invest, for investor 3', async () => {
            await shouldInvest(3)
        })
        it('should Fail to invest when investor not whitelisted', async () => {
            await mainCoin.approve(poolzBack.address, fakeInvestorAmt, { from: fakeInvestor })
            await truffleAssert.reverts(poolzBack.InvestERC20(ercPoolId, fakeInvestorAmt, { from: fakeInvestor }), 'Sorry, no alocation for Subject')
        })
    })

    describe('should get info', async () => {
        let investorWhiteListId, ercPoolId
        it('should get investment ids', async () => {
            const res = await poolzBack.GetMyInvestmentIds({ from: ethInvestor[0] })
            assert.equal(2, res.length)
            assert.equal([0, 4].toString(), res.toString())
        })

        it('should return OutOfstock', async () => {
            await poolzBack.SwitchLockedDealForTlp();
            await poolzBack.SetLockedDealAddress(lockedDeal.address)
            const mainCoinDecimals = await mainCoin.decimals()
            const tx3 = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            const investorWhiteListId = tx3.logs[0].args._WhiteListCount.toNumber()
            await ercTestToken.approve(poolzBack.address, 100000, { from: firstAddress })
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            const tokenDecimals = await ercTestToken.decimals()
            const d21PozRate = ercPozRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const d21PublicRate = ercPublicRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const tx = await poolzBack.CreatePool(ercTestToken.address, future, d21PublicRate, d21PozRate, 100000, future, mainCoin.address, true, 0, investorWhiteListId, { from: firstAddress })
            const ercPoolId2 = tx.logs[1].args[1].toString()
            await whiteList.AddAddress(investorWhiteListId, [firstAddress], [1000], { from: firstAddress })
            await mainCoin.approve(poolzBack.address, 1000, { from: firstAddress })
            await poolzBack.InvestERC20(ercPoolId2, 1000, { from: firstAddress })
            const res = await poolzBack.GetPoolStatus(ercPoolId2)
            assert.equal(res.toString(), '3')
        })

        it('should return Finished', async () => {
            const mainCoinDecimals = await mainCoin.decimals()
            const tx3 = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            investorWhiteListId = tx3.logs[0].args._WhiteListCount.toNumber()
            await ercTestToken.approve(poolzBack.address, 100000, { from: firstAddress })
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            const tokenDecimals = await ercTestToken.decimals()
            const d21PozRate = ercPozRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const d21PublicRate = ercPublicRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const tx = await poolzBack.CreatePool(ercTestToken.address, future, d21PublicRate, d21PozRate, 100000, future + 100000, mainCoin.address, true, 0, investorWhiteListId, { from: firstAddress })
            ercPoolId2 = tx.logs[1].args[1].toString()
            await timeMachine.advanceBlockAndSetTime(future)
            const res = await poolzBack.GetPoolStatus(ercPoolId2)
            assert.equal(res.toString(), '4')
        })

        it('should return Close', async () => {
            const mainCoinDecimals = await mainCoin.decimals()
            const tx6 = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            investorWhiteListId = tx6.logs[0].args._WhiteListCount.toNumber()
            await ercTestToken.approve(poolzBack.address, 100000, { from: firstAddress })
            const date1 = new Date()
            date1.setDate(date1.getDate() + 1)   // add a day
            const future = Math.floor(date1.getTime() / 1000) + 60
            const tokenDecimals = await ercTestToken.decimals()
            const d21PozRate = ercPozRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const d21PublicRate = ercPublicRate.mul(new BN('10').pow(new BN(21 + tokenDecimals.toNumber() - mainCoinDecimals.toNumber())))
            const tx5 = await poolzBack.CreatePool(ercTestToken.address, future, d21PublicRate, d21PozRate, 100000, future + 10000000, mainCoin.address, true, 0, investorWhiteListId, { from: firstAddress })
            ercPoolId2 = tx5.logs[1].args[1].toString()
            // await timeMachine.advanceBlockAndSetTime(future)
            // const res2 = await poolzBack.GetPoolStatus(ercPoolId2)
            // assert.equal(res2.toString(), '4')

            const date = new Date()
            date.setDate(date.getDate() + 1)  
            const time = Math.floor(date.getTime() / 1000) + 60 + 1000000
            await timeMachine.advanceBlockAndSetTime(time)
            const tx = await poolzBack.GetPoolExtraData(ercPoolId2)
            console.log("TookLeftOvers: " + tx[0].toString())
            const result = await poolzBack.WithdrawLeftOvers(ercPoolId2)
            console.log(result.logs[0].args)
            const tx1 = await poolzBack.GetPoolExtraData(ercPoolId2)
            console.log("TookLeftOvers: " + tx1[0].toString())
            console.log("WhiteListId: " + tx1[1].toString())
            console.log("Maincoin: " + tx1[2].toString())
            const tx2 = await poolzBack.GetPoolMoreData(ercPoolId2)
            console.log("LockedUntil: " + tx2[0].toString())
            console.log("Lefttokens: " + tx2[1].toString())
            console.log("StartTime: " + tx2[2].toString())
            console.log("OpenForAll: " + tx2[3].toString())
            console.log("UnlockedTokens: " + tx2[4].toString())
            console.log("Is21DecimalRate: " + tx2[5].toString())
            const tx3 = await poolzBack.GetPoolBaseData(ercPoolId2)
            console.log("FinishTime: " + tx3[2].toString())
            console.log("StartAmount: " + tx3[5].toString())
            console.log("Now: " + time)
            const res = await poolzBack.GetPoolStatus(ercPoolId2)
            assert.equal(res.toString(), '5')
        })

        it('should get total investors', async () => {
            const res = await poolzBack.getTotalInvestor();
            assert.equal(9, res.toString());
        })
    })
})