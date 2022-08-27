const DelayVault = artifacts.require("DelayVault")
const TestToken = artifacts.require("ERC20Token")
const LockedDeal = artifacts.require("LockedDeal")
const WhiteList = artifacts.require("WhiteList")

const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")
const timeMachine = require("ganache-time-traveler")
const BigNumber = require("bignumber.js")
const { createNewWhiteList } = require("./helper")
const constants = require('@openzeppelin/test-helpers/src/constants.js')

contract("Integration between DelayVault, LockedDeal and WhiteList", (accounts) => {
    let instance, lockedDeal, token
    const amount = 1000
    const day = 1 * 24 * 60 * 60
    const week = day * 7
    let poolId = 0

    before(async () => {
        instance = await DelayVault.new()
        token = await TestToken.new("TestToken", "TEST")
        lockedDeal = await LockedDeal.new()
        await instance.setLockedDealAddress(lockedDeal.address)
    })

    it("should withdraw", async () => {
        await token.approve(instance.address, amount)
        await instance.CreateVault(token.address, amount, week)
        const tx = await instance.Withdraw(token.address)
        const poolData = await lockedDeal.GetPoolData(poolId) // LockedDeal data
        const tokenLog = tx.logs[tx.logs.length - 1].args.Token.toString()
        const amountLog = tx.logs[tx.logs.length - 1].args.Amount.toString()
        const finishTimeLog = tx.logs[tx.logs.length - 1].args.FinishTime.toString()
        assert.equal(tokenLog.toString(), token.address.toString(), "invalid token")
        assert.equal(amountLog.toString(), amount.toString(), "invalid amount")
        assert.equal(finishTimeLog.toString(), poolData[0], "invalid finish time")
        assert.equal(poolData[1].toString(), amount)
        assert.equal(poolData[2].toString(), accounts[0])
        assert.equal(poolData[3].toString(), token.address.toString())
    })

    it("should return tokens from LockedDeal", async () => {
        const date = new Date()
        const startTime = Math.floor(date.getTime() / 1000) + 60
        await timeMachine.advanceBlockAndSetTime(startTime + week)
        const oldBal = new BigNumber(await token.balanceOf(accounts[0]))
        await lockedDeal.WithdrawToken(poolId)
        const actualBal = new BigNumber(await token.balanceOf(accounts[0]))
        assert.notEqual(actualBal.toString(), oldBal.toString())
        assert.equal(actualBal.toString(), BigNumber.sum(oldBal, amount))
        await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000))
    })

    describe("Creating Whitelist of tokens", () => {
        let whiteList, whiteListId
        before(async () => {
            whiteList = await WhiteList.new()
            const tx = await createNewWhiteList(whiteList, instance.address, accounts[0])
            whiteListId = tx.logs[0].args._WhiteListCount.toNumber()
            await instance.setWhiteListAddress(whiteList.address)
            await instance.setWhiteListId(whiteListId)
        })

        it("should revert wrong token", async () => {
            await token.approve(instance.address, amount)
            await truffleAssert.reverts(instance.CreateVault(token.address, amount, week), "Need Valid ERC20 Token")
        })

        it("should accept token", async () => {
            const allowance = [1]
            const address = [token.address]
            await whiteList.AddAddress(whiteListId, address, allowance)
            await token.approve(instance.address, amount)
            const tx = await instance.CreateVault(token.address, amount, week)
            const tokenAddr = tx.logs[tx.logs.length - 1].args.Token
            const quantity = tx.logs[tx.logs.length - 1].args.Amount
            const lockTime = tx.logs[tx.logs.length - 1].args.LockTime
            const owner = tx.logs[tx.logs.length - 1].args.Owner
            assert.equal(tokenAddr.toString(), token.address)
            assert.equal(quantity.toString(), amount.toString())
            assert.equal(lockTime.toString(), week.toString())
            assert.equal(owner.toString(), accounts[0].toString())
        })

        it('close filter', async () => {
            await instance.setWhiteListAddress(constants.ZERO_ADDRESS)
            await token.approve(instance.address, amount)
            const tx = await instance.CreateVault(token.address, amount, week)
            const tokenAddr = tx.logs[tx.logs.length - 1].args.Token
            const quantity = tx.logs[tx.logs.length - 1].args.Amount
            const lockTime = tx.logs[tx.logs.length - 1].args.LockTime
            const owner = tx.logs[tx.logs.length - 1].args.Owner
            assert.equal(tokenAddr.toString(), token.address)
            assert.equal(quantity.toString(), amount.toString())
            assert.equal(lockTime.toString(), week.toString())
            assert.equal(owner.toString(), accounts[0].toString())
        })
    })
})
