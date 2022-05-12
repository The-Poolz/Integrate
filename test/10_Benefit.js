const ThePoolz = artifacts.require("ThePoolz")
const Benefit = artifacts.require("Benefit")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require('WhiteList')
const UniswapV2Pair = artifacts.require('UniswapV2Pair')
const UniswapV2Factory = artifacts.require('UniswapV2Factory')
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')
const timeMachine = require('ganache-time-traveler')
const BigNumber = require('bignumber.js')
const BN = web3.utils.BN
const pozRate = new BN('1000000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN('500000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN('3000000') //3 tokens for sale
const constants = require("@openzeppelin/test-helpers/src/constants")
const { createNewWhiteList } = require('./helper')

contract('Integration between PoolzBack, Uniswap and Benefit', accounts => {
    let poolzBack, benefit, pozToken, whiteList, testToken, firstAddress = accounts[0]
    let poolId, uniswapV2Pair, uniswapV2Factory

    before(async () => {
        poolzBack = await ThePoolz.deployed()
        benefit = await Benefit.deployed()
        whiteList = await WhiteList.deployed()
        pozToken = await Token.new('Poolz', 'POZ')
        testToken = await Token.new('TestToken', 'TEST')
        //uniswapV2Pair = await UniswapV2Pair.deployed()
        uniswapV2Factory = await UniswapV2Factory.deployed()
    })

    describe('Setting up PoolzBack', () => {
        let poolWhiteListId

        it('should set address of Benefit contract', async () => {
            await poolzBack.SetBenefit_Address(benefit.address, { from: firstAddress })
            const result = await poolzBack.Benefit_Address()
            assert.equal(result, benefit.address)
        })

        it('should set address of whiteList contract', async () => {
            await poolzBack.SetWhiteList_Address(whiteList.address, { from: firstAddress })
            const result = await poolzBack.WhiteList_Address()
            assert.equal(whiteList.address, result)
        })

        it('Creating new WhiteList for pool', async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            poolWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it('should create new ETH Pool', async () => {
            await testToken.approve(poolzBack.address, amount, { from: firstAddress })
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const lockedUntil = Math.floor(date.getTime() / 1000) + 60
            date.setDate(date.getDate() + 1)   // add a day
            const finishTime = Math.floor(date.getTime() / 1000) + 60
            const tx = await poolzBack.CreatePool(testToken.address, finishTime, publicRate, pozRate, amount, lockedUntil, constants.ZERO_ADDRESS, true, 0, poolWhiteListId, { from: firstAddress })
            poolId = tx.logs[1].args[1].toString()
            let newpools = await poolzBack.poolsCount.call()
            assert.equal(newpools.toNumber(), 1, "Got 1 pool")
            let tokensInContract = await testToken.balanceOf(poolzBack.address)
            assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
        })
    })

    describe('Setting up Benefit Contract', () => {
        it('Adding POZ token to Benefit contract', async () => {
            await benefit.AddNewToken(pozToken.address, { from: firstAddress })
            const count = await benefit.ChecksCount()
            assert.equal(count, 1, "Got 1 Check")
        })

        it('Create liquidity pair', async () => {
            await uniswapV2Factory.createPair(pozToken.address, testToken.address, { from: firstAddress })
            const pair = await uniswapV2Factory.getPair(pozToken.address, testToken.address)
            uniswapV2Pair = await UniswapV2Pair.at(pair)
            const [token0, token1] = pozToken.address < testToken.address ? [pozToken.address, testToken.address] : [testToken.address, pozToken.address]
            assert.equal(token0, (await uniswapV2Pair.token0()), 'check first token address')
            assert.equal(token1, (await uniswapV2Pair.token1()), 'check second token address')
        })

        it('Tracking POZ token in LP', async () => {
            await benefit.AddNewLpCheck(pozToken.address, uniswapV2Pair.address, { from: firstAddress })
            const count = await benefit.ChecksCount()
            assert.equal(count, 2, "Got 2 Check")
        })
    })

    describe('Benefit and LP integration', () => {
        const pozHolder = accounts[3]
        it('add liquidity (low-level)', async () => {
            const amount = '15000000'
            await pozToken.transfer(uniswapV2Pair.address, amount)
            await testToken.transfer(uniswapV2Pair.address, amount)
            await uniswapV2Pair.mint(firstAddress)

            const reserve0 = (await uniswapV2Pair.getReserves())['0']
            const reserve1 = (await uniswapV2Pair.getReserves())['1']
            assert.equal(reserve0, amount, 'check first token reserve')
            assert.equal(reserve1, amount, 'check second token reserve')
        })

        it('calc tokens without LP', async () => {
            const amount = '5000000'
            await pozToken.transfer(pozHolder, amount)
            await testToken.transfer(pozHolder, amount)
            const result = await benefit.CalcTotal(pozHolder)
            assert.equal(result.toString(), amount, 'check token amount')
        })

        it('calc tokens with LP', async () => {
            const amount = await pozToken.balanceOf(pozHolder) / 2
            await pozToken.transfer(uniswapV2Pair.address, amount.toString(), { from: pozHolder })
            await testToken.transfer(uniswapV2Pair.address, amount.toString(), { from: pozHolder })
            await uniswapV2Pair.mint(pozHolder, { from: pozHolder })
            const balance = await uniswapV2Pair.balanceOf(pozHolder)
            assert.equal(amount, balance, 'checking how many tokens were added to LP')
            const result = await benefit.CalcTotal(pozHolder)
            const expectedBalance = await pozToken.balanceOf(pozHolder) * 2
            assert.equal(result.toString(), expectedBalance.toString(), 'check token amount')
        })

        it('check when remove lp traking', async () => {
            await benefit.RemoveLastBalanceCheckData()
            const expected = await pozToken.balanceOf(pozHolder)
            const actual = await benefit.CalcTotal(pozHolder)
            assert.equal(expected.toString(), actual.toString(), 'calc tokens without LP contract')
        })

        it('calculation of tokens when change liquidity', async () => {
            await benefit.AddNewLpCheck(pozToken.address, uniswapV2Pair.address, { from: firstAddress })
            //
            const amount = '1000'
            await pozToken.transfer(uniswapV2Pair.address, amount, { from: pozHolder })
            await testToken.transfer(uniswapV2Pair.address, amount, { from: pozHolder })
            await uniswapV2Pair.mint(pozHolder, { from: pozHolder })
            let result = await benefit.CalcTotal(pozHolder)
            let expectedBalance = '5000000'
            assert.equal(result.toString(), expectedBalance, 'check token amount')
            //
            await pozToken.transfer(uniswapV2Pair.address, amount, { from: pozHolder })
            await testToken.transfer(uniswapV2Pair.address, amount, { from: pozHolder })
            await uniswapV2Pair.mint(pozHolder, { from: pozHolder })
            result = await benefit.CalcTotal(pozHolder)
            assert.equal(result.toString(), expectedBalance, 'check token amount')
            expectedBalance = '2502000'
            result = await uniswapV2Pair.balanceOf(pozHolder)
            assert.equal(expectedBalance, result.toString(), 'check lp amount')
            //
            await uniswapV2Pair.skim(pozHolder, { from: pozHolder })
            result = await benefit.CalcTotal(pozHolder)
            expectedBalance = '5000000'
            assert.equal(result.toString(), expectedBalance, 'check token amount')
        })
    })

    describe('Investing in Pool', () => {
        const investor = accounts[9]
        it('Fail to invest when investor has no POZ', async () => {
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            await timeMachine.advanceBlockAndSetTime(future)
            await truffleAssert.reverts(poolzBack.InvestETH(poolId, { from: investor, value: web3.utils.toWei('0.4') }), 'Only POZ holder can invest')
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })

        it('sending POZ to investor', async () => {
            const amount = '1000000'
            await pozToken.transfer(investor, amount, { from: firstAddress })
            const result = await pozToken.balanceOf(investor)
            assert.equal(result.toString(), amount)
        })

        it('should invest in Pool when it is open for all', async () => {
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            await timeMachine.advanceBlockAndSetTime(future)
            await poolzBack.InvestETH(poolId, { from: investor, value: web3.utils.toWei('0.4') })
            const tokenDecimals = await testToken.decimals()
            const realRate = publicRate.div(new BN(10).pow(new BN(21 + tokenDecimals.toNumber() - 18))) // converting decimal21Rate to realRate
            const tokens = 0.4 * realRate.toNumber()
            const bal = await testToken.balanceOf(investor)
            assert.deepEqual(bal, new BN(tokens).mul(new BN(10).pow(tokenDecimals)))
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })

        after(async () => {
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })
    })
})