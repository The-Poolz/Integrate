const ThePoolz = artifacts.require("PoolzBack")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require('PoolzWhiteList')
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')
var BN = web3.utils.BN

const pozRate = new BN('1000000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN('500000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN('3000000') //3 tokens for sale
const invest = web3.utils.toWei('1', 'ether') //1eth
const zero_address = "0x0000000000000000000000000000000000000000"

const { createNewWhiteList } = require('./helper')

contract('Interation Between PoolzBack and WhiteList for Investing', (accounts) => {
    let poolzBack, testToken, whiteList, mainCoin, firstAddress = accounts[0]
    let tokenWhiteListId, mainCoinWhiteListId, investorWhiteListId, investors, allowances
    let poolId

    before( async () => {
        poolzBack = await ThePoolz.deployed()
        whiteList = await WhiteList.deployed()
        testToken = await Token.new('TestToken', 'TEST')
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
            await whiteList.AddAddress(mainCoinWhiteListId, addressArray, allowanceArray, {from: firstAddress})
            const result =  await whiteList.Check(mainCoin.address, mainCoinWhiteListId)
            assert.equal(result, 100000000)
        })

        it('should add Token Address to whiteList ID 2', async () => {
            const addressArray = [testToken.address]
            const allowanceArray = [100000000] // random allowance
            await whiteList.AddAddress(tokenWhiteListId, addressArray, allowanceArray, {from: firstAddress})
            const result =  await whiteList.Check(testToken.address, tokenWhiteListId)
            assert.equal(result, 100000000)
        })
    })

    describe('PoolzBack Setup', () => {
        it('should set whitelist address', async () => {
            await poolzBack.SetWhiteList_Address(whiteList.address, {from: firstAddress})
            const result = await poolzBack.WhiteList_Address()
            assert.equal(whiteList.address, result)
        })
        it('should set Token WhiteList ID', async () => {
            await poolzBack.setTokenWhitelistId(tokenWhiteListId, {from: firstAddress})
            const result = await poolzBack.TokenWhitelistId()
            assert.equal(tokenWhiteListId, result)
        })
        it('should set Main Coin WhiteList ID', async () => {
            await poolzBack.setMCWhitelistId(mainCoinWhiteListId, {from: firstAddress})
            const result = await poolzBack.MCWhitelistId()
            assert.equal(mainCoinWhiteListId, result)
        })
        it('should set Token Filter to true', async () => {
            await poolzBack.SwapTokenFilter({from: firstAddress})
            const result = await poolzBack.IsTokenFilterOn()
            assert.equal(true, result)
        })
    })

    describe('Creating Whitelist of Investors and New Pool', () => {
        it('should create new whitelist for investors', async () => {
            const tx = await createNewWhiteList(whiteList, poolzBack.address, firstAddress)
            investorWhiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        })

        it('should grant allowances to investers', async () => {
            investors = [accounts[9], accounts[8], accounts[7], accounts[6]]
            allowances = []
            allowances.push(web3.utils.toWei('0.4'))
            allowances.push(web3.utils.toWei('0.3'))
            allowances.push(web3.utils.toWei('0.2'))
            allowances.push(web3.utils.toWei('0.1'))
            await whiteList.AddAddress(investorWhiteListId, investors, allowances, {from: firstAddress})
            investors.forEach(async (value, index) => {
                const result =  await whiteList.Check(value, investorWhiteListId)
                assert.equal(result, allowances[index])
            })
        })

        it('should create new pool with ETH as Main Coin', async () => {
            await testToken.approve(poolzBack.address, amount, {from: firstAddress})
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            const tx = await poolzBack.CreatePool(testToken.address, future, publicRate, pozRate, amount, 0, zero_address,true,0, investorWhiteListId, { from: firstAddress })
            poolId = tx.logs[1].args[1].toString()
            let newpools = await poolzBack.poolsCount.call()
            assert.equal(newpools.toNumber(), 1, "Got 1 pool")
            let tokensInContract = await testToken.balanceOf(poolzBack.address)
            assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
            const result = await poolzBack.GetPoolExtraData(poolId)
            assert.equal(investorWhiteListId ,result[1].toString())
            const status = await poolzBack.GetPoolStatus(poolId)
        })
    })

    describe('Investing in Pool', () => {
        it('should invest', async () => {
            await poolzBack.InvestETH(poolId, {from: investors[0], value: allowances[0]})
            const bal = await testToken.balanceOf(investors[0])
            
        })
    })
})