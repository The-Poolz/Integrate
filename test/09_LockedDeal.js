const ThePoolz = artifacts.require("ThePoolz")
const Token = artifacts.require("Token")
const LockedDeal = artifacts.require("LockedDeal")
const { assert } = require("chai")
const timeMachine = require("ganache-time-traveler")
const constants = require("@openzeppelin/test-helpers/src/constants")
var BN = web3.utils.BN

const pozRate = new BN("1000000000") // with decimal21 (shifter) 1 eth^18 = 1 token^6
const publicRate = new BN("500000000") // with decimal21 (shifter) 1 eth^18 = 1 token^6
const amount = new BN("3000000") //3 tokens for sale

contract("Integration between PoolzBack and LockedDeal", (accounts) => {
    let poolzBack,
        lockedDeal,
        testToken,
        firstAddress = accounts[0]
    let poolId

    before(async () => {
        poolzBack = await ThePoolz.new()
        lockedDeal = await LockedDeal.new()
        testToken = await Token.new("TestToken", "TEST")
    })

    describe("PoolzBack Setup", () => {
        it("should set LockedDeal address", async () => {
            await poolzBack.SetLockedDealAddress(lockedDeal.address, { from: firstAddress })
            const result = await poolzBack.LockedDealAddress()
            assert.equal(lockedDeal.address, result)
        })
        it("should use LockedDeal for creating TLP", async () => {
            await poolzBack.SwitchLockedDealForTlp({ from: firstAddress })
            const result = await poolzBack.UseLockedDealForTlp()
            assert.isTrue(result)
        })
        it("should create a TLP", async () => {
            await testToken.approve(poolzBack.address, amount, { from: firstAddress })
            const date = new Date()
            date.setDate(date.getDate() + 1) // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            const tx = await poolzBack.CreatePool(
                testToken.address,
                future,
                publicRate,
                pozRate,
                amount,
                future,
                constants.ZERO_ADDRESS,
                true,
                0,
                0,
                { from: firstAddress }
            )
            poolId = tx.logs[1].args[1].toString()
            let newpools = await poolzBack.poolsCount.call()
            assert.equal(newpools.toNumber(), 1, "Got 1 pool")
            let tokensInContract = await testToken.balanceOf(poolzBack.address)
            assert.equal(tokensInContract.toString(), amount.toString(), "Got the tokens")
        })
    })
    describe("Investing", () => {
        const investor = accounts[9]
        let lockedDealId
        it("Investing in Locked Deal", async () => {
            const tx = await poolzBack.InvestETH(poolId, { from: investor, value: web3.utils.toWei("0.4") })
            lockedDealId = tx.logs[2].args[2].toString()
            const investorId = tx.logs[2].args[0].toString()
            const result = await poolzBack.GetInvestmentData(investorId)
            assert.equal(investor, result[1].toString())
        })
        it("should withdraw investment at unlock time", async () => {
            const date = new Date()
            date.setDate(date.getDate() + 1) // add a day
            const future = Math.floor(date.getTime() / 1000) + 60
            await timeMachine.advanceBlockAndSetTime(future)
            // await timeMachine.advanceTimeAndBlock();
            const tx = await lockedDeal.WithdrawToken(lockedDealId, { from: firstAddress })
            const result = tx.logs[0].args[0].toString()
            const bal = await testToken.balanceOf(investor)
            const now = Date.now()
            await timeMachine.advanceBlockAndSetTime(Math.floor(now / 1000))
            assert.equal(result, bal)
        })
    })

    describe("Withdrawing", () => {
        it("should withdraw eth fee", async () => {
            await lockedDeal.WithdrawETHFee(firstAddress)
        })

        it("should withdraw ERC20 fee", async () => {
            await lockedDeal.WithdrawERC20Fee(testToken.address, firstAddress)
        })
    })
})
