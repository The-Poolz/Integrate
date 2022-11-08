const MultiWithdraw = artifacts.require("MultiWithdraw")
const LockedDealV2 = artifacts.require("LockedDealV2")
const TestToken = artifacts.require("ERC20Token")
const timeMachine = require("ganache-time-traveler")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const constants = require("@openzeppelin/test-helpers/src/constants.js")

contract("MultiWithdraw", (accounts) => {
    let multiWithdraw, lockedDealV2, token
    const allow = '100', amount = '100000'
    const owners = [accounts[9], accounts[8], accounts[7], accounts[6], accounts[5]]
    let lastPoolId, finishTime

    before(async () => {
        multiWithdraw = await MultiWithdraw.new()
        lockedDealV2 = await LockedDealV2.new()
        token = await TestToken.new('TestToken', 'TEST')
    })

    it('should create mass pools', async () => {
        const numberOfPools = 5
        await token.approve(lockedDealV2.address, allow * numberOfPools)
        let date = new Date()
        date.setDate(date.getDate())
        let future = Math.floor(date.getTime() / 1000)
        const startTimeStamps = []
        for(let i = 0; i < owners.length; i++)
            startTimeStamps.push(future)
        finishTime = future = future + 60 * 60 * 24 * 30
        const finishTimeStamps = []
        for(let i = 0; i < owners.length; i++)
            finishTimeStamps.push(future)
        const startAmounts = [allow, allow, allow, allow, allow]
        const tx = await lockedDealV2.CreateMassPools(token.address, startTimeStamps, finishTimeStamps, startAmounts, owners, { value: amount * numberOfPools })
        lastPoolId = tx.logs[tx.logs.length - 1].args.LastPoolId.toString()
    })

    it("should mass withdraw", async () => {
        await multiWithdraw.setLockedDealAddress(lockedDealV2.address)
        let poolIds = []
        for(let i = 0; i <= lastPoolId; i++)
            poolIds.push(i.toString())
        let oldBalances = []
        for(let i = 0; i < owners.length; i++) {
            oldBalances.push((await token.balanceOf(owners[i])))
        }
        await timeMachine.advanceBlockAndSetTime(finishTime)
        await multiWithdraw.MultiWithdrawTokens(poolIds)
        let balances = []
        for(let i = 0; i < owners.length; i++) {
            balances.push((await token.balanceOf(owners[i])))
        }
        for(let i = 0; i < owners.length; i++) {
            assert.equal(balances[i].toString(), allow.toString())
            assert.notEqual(balances[i].toString(), oldBalances[i].toString())
        }
    })

    after(async () => {
        await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
    })
})