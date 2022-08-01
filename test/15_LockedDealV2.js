const LockedDealV2 = artifacts.require("LockedDealV2")
const TestToken = artifacts.require("ERC20Token")
const WhiteList = artifacts.require("WhiteList")
const { assert } = require('chai')
const truffleAssert = require('truffle-assertions')

const { createNewWhiteList } = require('./helper')

contract("LockedDealV2 with WhiteList integration", accounts => {
    let instance, Token
    let whiteList
    const amount = '100000', fromAddress = accounts[0], owner = accounts[9], allow = 100

    before(async () => {
        instance = await LockedDealV2.new()
        Token = await TestToken.new('TestToken', 'TEST')
        whiteList = await WhiteList.new()
        await instance.setWhiteListAddress(whiteList.address)
        let tx = await createNewWhiteList(whiteList, instance.address, fromAddress)
        let Id = tx.logs[0].args._WhiteListCount.toNumber()
        await instance.setTokenFeeWhiteListId(Id)
        tx = await createNewWhiteList(whiteList, instance.address, fromAddress)
        Id = tx.logs[0].args._WhiteListCount.toNumber()
        await instance.setUserWhiteListId(Id)
    })

    it('should pay fee', async () => {
        await instance.SetFeeAmount(amount)
        await Token.transfer(owner, allow)
        await Token.approve(instance.address, allow, { from: owner })
        const date = new Date()
        date.setDate(date.getDate() + 1)
        const startTime = Math.floor(date.getTime() / 1000)
        const finishTime = startTime + 60 * 60 * 24 * 30
        await truffleAssert.reverts(instance.CreateNewPool(Token.address, startTime, finishTime, allow, owner, { from: owner, value: '99999' }), "Not Enough Fee Provided")
        await instance.CreateNewPool(Token.address, startTime, finishTime, allow, owner, { from: owner, value: amount })
        const contractBal = await web3.eth.getBalance(instance.address)
        assert.equal(contractBal, amount, 'invalid contract balance')
        await instance.WithdrawFee(fromAddress)
    })

    it('should pay fee when create mass pools', async () => {
        const numberOfPools = 5
        await Token.approve(instance.address, allow * numberOfPools, { from: fromAddress })
        let date = new Date()
        date.setDate(date.getDate() + 1)
        let future = Math.floor(date.getTime() / 1000)
        const startTimeStamps = []
        startTimeStamps.push(future)
        startTimeStamps.push(future - 3600)
        startTimeStamps.push(future + 3600)
        startTimeStamps.push(future + 7200)
        startTimeStamps.push(future - 7200)
        future = future + 60 * 60 * 24 * 30
        const finishTimeStamps = []
        finishTimeStamps.push(future)
        finishTimeStamps.push(future - 3600)
        finishTimeStamps.push(future + 3600)
        finishTimeStamps.push(future + 7200)
        finishTimeStamps.push(future - 7200)
        const startAmounts = [allow, allow, allow, allow, allow]
        const owners = [accounts[9], accounts[8], accounts[7], accounts[6], accounts[5]]
        await instance.CreateMassPools(Token.address, startTimeStamps, finishTimeStamps, startAmounts, owners, { from: fromAddress, value: amount * numberOfPools })
        const contractBal = await web3.eth.getBalance(instance.address)
        assert.equal(contractBal, amount * numberOfPools, 'invalid contract balance')
        await instance.WithdrawFee(fromAddress)
    })

    it('should pay fee when create pool wrt time', async () => {
        const allow = 100
        const numberOfOwners = 3
        const numberOfTimestamps = 6
        await Token.approve(instance.address, allow * numberOfOwners * numberOfTimestamps, { from: fromAddress })
        let date = new Date()
        date.setDate(date.getDate() + 1)
        let future = Math.floor(date.getTime() / 1000)
        const startTimeStamps = []
        for (let i = 1; i <= numberOfTimestamps; i++) { // generating array of length 5
            startTimeStamps.push(future + 3600 * i)
        }
        future = future + 60 * 60 * 24 * 30
        const finishTimeStamps = []
        for (let i = 1; i <= numberOfTimestamps; i++) { // generating array of length 5
            finishTimeStamps.push(future + 3600 * i)
        }
        const startAmounts = [allow, allow, allow]
        const owners = [accounts[9], accounts[8], accounts[7]]
        await instance.CreatePoolsWrtTime(Token.address, startTimeStamps, finishTimeStamps, startAmounts, owners, { from: fromAddress, value: amount * numberOfOwners * numberOfTimestamps })
        const contractBal = await web3.eth.getBalance(instance.address)
        assert.equal(contractBal, amount * numberOfOwners * numberOfTimestamps, 'invalid contract balance')
        await instance.WithdrawFee(fromAddress)
    })

    describe('enable white list filter', () => {
        it('should revert wrong tokens', async () => {
            await instance.swapTokenFilter()
            let tx = await createNewWhiteList(whiteList, instance.address, fromAddress)
            let Id = tx.logs[0].args._WhiteListCount.toNumber()
            await instance.setTokenFilterWhiteListId(Id)
            await Token.transfer(owner, allow)
            await Token.approve(instance.address, allow, { from: owner })
            const date = new Date()
            date.setDate(date.getDate() + 1)
            const startTime = Math.floor(date.getTime() / 1000)
            const finishTime = startTime + 60 * 60 * 24 * 30
            await truffleAssert.reverts(instance.CreateNewPool(Token.address, startTime, finishTime, allow, owner, { from: owner, value: amount }), "Need Valid ERC20 Token")
        })

        it('should accept right token', async () => {
            await Token.transfer(owner, allow)
            await Token.approve(instance.address, allow, { from: owner })
            const date = new Date()
            date.setDate(date.getDate() + 1)
            const startTime = Math.floor(date.getTime() / 1000)
            const finishTime = startTime + 60 * 60 * 24 * 30
            const address = [Token.address]
            const allowance = [1]
            const whiteListId = await instance.TokenFilterWhiteListId()
            await whiteList.AddAddress(whiteListId, address, allowance)
            await instance.CreateNewPool(Token.address, startTime, finishTime, allow, owner, { from: owner, value: amount })
        })
    })
})