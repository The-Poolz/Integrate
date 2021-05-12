const ThePoolz = artifacts.require("PoolzBack")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require('PoolzWhiteList')
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')
var BN = web3.utils.BN

const rate = new BN('1000000000') // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN('3000000') //3 tokens for sale
const invest = web3.utils.toWei('1', 'ether') //1eth
const zero_address = "0x0000000000000000000000000000000000000000"

contract('Integration between Poolz-Back and WhiteList', accounts => {
    let poolzBack, testToken, whiteList, mainCoin, firstAddress = accounts[0]
    let whiteListCost = web3.utils.toWei('0.01', 'ether')
    let tokenWhiteListId, mainCoinWhiteListId

    before( async () => {
        poolzBack = await ThePoolz.deployed()
        whiteList = await WhiteList.deployed()
        testToken = await Token.new('TestToken', 'TEST')
        mainCoin = await Token.new('TestMainToken', 'TESTM')
    })

    describe('WhiteList Setup', () => {
        const createNewWhiteList = async (address) => {
            const now = Date.now() / 1000 // current timestamp in seconds
            const timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
            const value = whiteListCost
            const result = await whiteList.CreateManualWhiteList(timestamp, address, {from: firstAddress, value: value})
            const logs = result.logs[0].args
            let id = logs._WhiteListCount.toNumber()
            assert.equal(logs._creator, firstAddress)
            assert.equal(logs._contract, address)
            assert.equal(logs._changeUntil, timestamp)
            return id
        }

        it('Creating new WhiteList for Main Coin', async () => {
            mainCoinWhiteListId = await createNewWhiteList(poolzBack.address)
        })

        it('Creating new WhiteList for Token', async () => {
            tokenWhiteListId = await createNewWhiteList(poolzBack.address)
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

    describe('Creating Pool', () => {
        let ethPoolId, ercPoolId

        it('should create new pool with ETH as Main Coin', async () => {
            await testToken.approve(poolzBack.address, amount, {from: firstAddress})
            const date = new Date()
            date.setDate(date.getDate() + 1)   // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            const tx = await poolzBack.CreatePool(testToken.address, future, rate, rate, amount, 0, zero_address,true,0,0, { from: firstAddress })
            ethPoolId = tx.logs[1].args[1].toString()
            let newpools = await poolzBack.poolsCount.call()
            assert.equal(newpools.toNumber(), 1, "Got 1 pool")
            let tokensInContract = await testToken.balanceOf(poolzBack.address)
            assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
        })
        // it('should create new pool with ERC20 Main Coin', async () => {
        //     await testToken.approve(poolzBack.address, amount, {from: firstAddress})
        //     const date = new Date()
        //     date.setDate(date.getDate() + 1)   // add a day
        //     const future = Math.floor(date.getTime() / 1000) + 60
        //     const tx = await poolzBack.CreatePool(testToken.address, future, rate, rate, amount, 0, mainCoin.address,true,0,0, { from: firstAddress })
        //     ercPoolId = tx.logs[1].args[1].toString()
        //     let newpools = await poolzBack.poolsCount.call()
        //     assert.equal(newpools.toNumber(), 2, "Got 1 pool")
        //     let tokensInContract = await testToken.balanceOf(poolzBack.address)
        //     assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
        // })
    })


})