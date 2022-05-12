const ThePoolz = artifacts.require("ThePoolz")
const Token = artifacts.require("Token")
const WhiteList = artifacts.require("WhiteList")
const WhiteListConvertor = artifacts.require("WhiteListConvertor")
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')
const BigNumber = require("bignumber.js")
const constants = require("@openzeppelin/test-helpers/src/constants")
const BN = web3.utils.BN

contract('Integration Between PoolzBack and WhiteListConvertor', accounts => {
    let poolzBack, testToken, whiteList, mainCoin, firstAddress = accounts[0]
    let whiteListConvertor, secondAddress = accounts[1]
    let whiteListId, ethPoolId

    before(async () => {
        poolzBack = await ThePoolz.deployed()
        whiteList = await WhiteList.deployed()
        whiteListConvertor = await WhiteListConvertor.new(whiteList.address)
        testToken = await Token.new('TestToken', 'TEST', { from: firstAddress })
    })

    it('should create white list', async () => {
        const now = Date.now() / 1000 // current timestamp in seconds
        const timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
        const whiteListCost = web3.utils.toWei('0.01', 'ether')
        await whiteList.CreateManualWhiteList(timestamp, whiteListConvertor.address, { from: firstAddress, value: whiteListCost })
        whiteListId = (await whiteList.WhiteListCount() - 1).toString()
        assert.equal(whiteListId, '1')
    })

    it('should create new pool with ETH as Main Coin', async () => {
        const date = new Date()
        date.setDate(date.getDate() + 1)   // add a day
        const future = Math.floor(date.getTime() / 1000) + 60
        const pozRate = new web3.utils.BN('1000000000')
        const publicRate = new web3.utils.BN('500000000')
        const amount = new BN('100000000')
        await testToken.approve(poolzBack.address, amount, { from: firstAddress })
        const tx = await poolzBack.CreatePool(testToken.address, future, publicRate, pozRate, amount, 0, constants.ZERO_ADDRESS, true, 0, whiteListId, { from: firstAddress })
        ethPoolId = tx.logs[1].args[1].toString()
        const result = await poolzBack.GetPoolExtraData(ethPoolId)
        assert.equal(whiteListId, result[1].toString())
    })

    it('should add Main Coin Address to Whitelist', async () => {
        const addressArray = [testToken.address]
        const amount = '100000000'
        const allowanceArray = [amount] // random allowance
        await whiteList.AddAddress(whiteListId, addressArray, allowanceArray, { from: firstAddress })
        const result = await whiteList.Check(testToken.address, whiteListId)
        assert.equal(result, amount)
        await poolzBack.SetWhiteList_Address(whiteListConvertor.address)
        await poolzBack.setMCWhitelistId(whiteListId)
        await poolzBack.SwapTokenFilter()
        const data = await poolzBack.IsTokenFilterOn()
        assert.equal(true, data)
    })

    it('add user to WhiteList', async () => {
        const addressArray = [secondAddress]
        const allowanceArray = [web3.utils.toWei('100')]// 100 ETH
        await whiteList.AddAddress(whiteListId, addressArray, allowanceArray)
        const result = await whiteList.Check(secondAddress, whiteListId)
        assert.equal(result.toString(), web3.utils.toWei('100'), 'check value in original white list')
    })

    it('should revert with new price', async () => {
        const divide = false
        const price = '10'
        const tx = await whiteListConvertor.SetPrice(whiteListId, price, divide, poolzBack.address)
        const currentPrice = tx.logs[0].args.Price.toString()
        const currentOperation = tx.logs[0].args.Operation.toString()
        const currentId = tx.logs[0].args.Id.toString()
        assert.equal(currentId, whiteListId)
        assert.equal(currentPrice, price)
        assert.equal(currentOperation, divide.toString())
        const result = await whiteListConvertor.Check(secondAddress, whiteListId)
        assert.equal(result.toString(), web3.utils.toWei('10'), 'check value in convertor white list')
        await truffleAssert.reverts(poolzBack.InvestETH(ethPoolId, { from: secondAddress, value: web3.utils.toWei('50') }), 'Sorry, no alocation for Subject')
    })

    it('should invest', async () => {
        await poolzBack.InvestETH(ethPoolId, { from: secondAddress, value: web3.utils.toWei('5') })
        const convertorResult = await whiteListConvertor.Check(secondAddress, whiteListId)// convertor WhiteList
        assert.equal(convertorResult.toString(), web3.utils.toWei('5'), 'check value in convertor whitelist')
        const originalResult = await whiteList.Check(secondAddress, whiteListId) // original WhiteList
        assert.equal(originalResult.toString(), web3.utils.toWei('50'), 'check value in original whitelist')
    })

    it('should last round register', async () => {
        const contractAddress = accounts[9]
        const now = Date.now() / 1000;  // current timestamp in seconds
        const timestamp = Number(now.toFixed()) + 3600;  // timestamp one hour from now
        await whiteList.CreateManualWhiteList(timestamp, whiteListConvertor.address, { from: contractAddress })
        const id = (await whiteList.WhiteListCount() - 1).toString()
        await whiteListConvertor.SetPrice(id, '10', false, contractAddress)
        await whiteListConvertor.LastRoundRegister(secondAddress, id, { from: contractAddress })

        const userLimit = await whiteListConvertor.Check(secondAddress, id)
        const MAX_INT = constants.MAX_UINT256 / 10
        assert.equal(userLimit.toString(), MAX_INT)
    })

    describe('should invoke only by creator', async () => {
        let now, timestamp, whiteListCost

        before(async () => {
            now = Date.now() / 1000 // current timestamp in seconds
            timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
            whiteListCost = web3.utils.toWei('0.01', 'ether')
            await whiteList.CreateManualWhiteList(timestamp, whiteListConvertor.address, { from: secondAddress, value: whiteListCost })
            whiteListId = (await whiteList.WhiteListCount() - 1).toString()
        })


        it('Only creator can change creator', async () => {
            await truffleAssert.reverts(
                whiteList.ChangeCreator(whiteListId, secondAddress),
                "Only creator can access"
            )
        })

        it('Only creator can change contract', async () => {
            await truffleAssert.reverts(
                whiteList.ChangeContract(whiteListId, secondAddress),
                "Only creator can access"
            )
        })

        it('Only creator can add address', async () => {
            const addressArray = [testToken.address]
            const amount = '100000000'
            const allowanceArray = [amount]  // random allowance

            await truffleAssert.reverts(
                whiteList.AddAddress(whiteListId, addressArray, allowanceArray, { from: firstAddress }),
                "Only creator can access"
            )
        })

        it('Only creator can remove address', async () => {
            const addressArray = [testToken.address];

            await truffleAssert.reverts(
                whiteList.RemoveAddress(whiteListId, addressArray, { from: firstAddress }),
                "Only creator can access"
            )
        })
    })
})