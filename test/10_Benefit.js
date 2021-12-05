const ThePoolz = artifacts.require("ThePoolz")
const Benefit = artifacts.require("Benefit")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require('WhiteList')
const { assert } = require('chai');
const truffleAssert = require('truffle-assertions')
const timeMachine = require('ganache-time-traveler');
const BigNumber = require('bignumber.js');
const BN = web3.utils.BN

const pozRate = new BN('1000000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN('500000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN('3000000') //3 tokens for sale
const invest = web3.utils.toWei('1', 'ether') //1eth
const zero_address = "0x0000000000000000000000000000000000000000"

const { createNewWhiteList } = require('./helper')

contract('Integration between PoolzBack and Benefit', accounts => {
    let poolzBack, benefit, pozToken, whiteList, testToken, firstAddress = accounts[0]
    let poolId

    before( async () => {
        poolzBack = await ThePoolz.deployed()
        benefit = await Benefit.deployed()
        whiteList = await WhiteList.deployed()
        pozToken = await Token.new('Poolz', 'POZ')
        testToken = await Token.new('TestToken', 'TEST')
    })

    describe('Setting up PoolzBack', () => {
        let poolWhiteListId

        it('should set address of Benefit contract', async () => {
            await poolzBack.SetBenefit_Address(benefit.address, {from: firstAddress})
            const result = await poolzBack.Benefit_Address()
            assert.equal(result, benefit.address)
        })

        it('should set address of whiteList contract', async () => {
            await poolzBack.SetWhiteList_Address(whiteList.address, {from: firstAddress})
            const result = await poolzBack.WhiteList_Address()
            assert.equal(whiteList.address, result)
        })

        it('Creating new WhiteList for pool', async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            poolWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it('should create new ETH Pool', async () => {
            await testToken.approve(poolzBack.address, amount, {from: firstAddress})
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const lockedUntil = Math.floor(date.getTime() / 1000) + 60
            date.setDate(date.getDate() + 1)   // add a day
            const finishTime = Math.floor(date.getTime() / 1000) + 60
            const tx = await poolzBack.CreatePool(testToken.address, finishTime, publicRate, pozRate, amount, lockedUntil, zero_address,true,0, poolWhiteListId, { from: firstAddress })
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
            const count =  await benefit.ChecksCount()
            assert.equal(count, 1, "Got 1 Check")
        })
    })

    describe('Investing in Pool', () => {
        const investor = accounts[9]
        let investorId
        it('Fail to invest when investor has no POZ', async () => {
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            await timeMachine.advanceBlockAndSetTime(future)
            await truffleAssert.reverts(poolzBack.InvestETH(poolId, {from: investor, value: web3.utils.toWei('0.4')}), 'Only POZ holder can invest')
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })

        it('sending POZ to investor', async () => {
            const amount = '1000000'
            await pozToken.transfer(investor, amount, {from: firstAddress})
            const result = await pozToken.balanceOf(investor)
            assert.equal(result.toString(), amount)
        })

        it('should invest in Pool when it is open for all', async () => {
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            await timeMachine.advanceBlockAndSetTime(future)
            await poolzBack.InvestETH(poolId, {from: investor, value: web3.utils.toWei('0.4')})
            const tokenDecimals = await testToken.decimals()
            const realRate = publicRate.div(new BN(10).pow(new BN(21 + tokenDecimals.toNumber() - 18))) // converting decimal21Rate to realRate
            const tokens  =  0.4 * realRate.toNumber()
            const bal = await testToken.balanceOf(investor)
            assert.deepEqual(bal, new BN(tokens).mul(new BN(10).pow(tokenDecimals)))
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })

        after(async () => {
            await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
        })
    })
})