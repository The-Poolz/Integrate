const DelayVault = artifacts.require("DelayVault")
const LDV2 = artifacts.require("LockedDealV2")
const TestToken = artifacts.require("ERC20Token")

const constants = require("@openzeppelin/test-helpers/src/constants")
const { assert } = require("chai")
const truffleAssert = require("truffle-assertions")

contract("DelayVault Integration tests", (accounts) => {
    let delayVault, token, lockedDealV2
    const day = 86400 // seconds
    const week = day * 7
    const month = 2629743 // 30.44 days
    const firstRange = 0
    const secondRange = 250
    const thirdRange = 1000
    const fourthRange = 20000
    const fifthRange = 50000
    //______________________________________________________________________________________
    // up to 250 poolz tokens - its a week start time (finish=clif=0)                       |
    // up to 1000 tokens - its 2-week start time                                            |
    // up to 20000 tokens. its 4 weeks start time                                           |
    // up to 50000, its 0 start time, 3 month finish time with 1-month cliff                |
    // and up to 100000 and above its 0 start time, 4 month finish time with 0 cliff        |
    //```````````````````````````````````````````````````````````````````````````````````````
    const amounts = [firstRange, secondRange, thirdRange, fourthRange, fifthRange]
    const startDelays = [week, week * 2, week * 4, 0, 0]
    const cliffDelays = [0, 0, 0, month, 0]
    const finishDelays = [0, 0, 0, month * 3, month * 4]
    // vault amounts
    const firstAmount = 200 // limit range 0 - 249
    const secondAmount = 500 // limit range 250 - 999
    const thirdAmount = 2000 // limit range 1000 - 19999
    const fourthAmount = 25000 // limit range 20000 - 49999
    const fifthAmount = 100000 // limit range 50000 - infinity

    before(async () => {
        delayVault = await DelayVault.new()
        token = await TestToken.new("TestToken", "TEST")
        lockedDealV2 = await LDV2.new()
        await token.approve(delayVault.address, constants.MAX_UINT256)
        const fullAmount = await token.totalSupply()
        for (let i = 1; i < accounts.length; i++) {
            await token.transfer(accounts[i], fullAmount / 10)
            await token.approve(delayVault.address, constants.MAX_UINT256, { from: accounts[i] })
        }
        await delayVault.setMinDelays(token.address, amounts, startDelays, cliffDelays, finishDelays)
    })

    it("should set LockedDeal", async () => {
        await delayVault.setLockedDealAddress(lockedDealV2.address)
        const lockedDeal = await delayVault.LockedDealAddress()
        assert.equal(lockedDealV2.address, lockedDeal.toString())
    })

    it("fail to create vaults with invalid delay limits", async () => {
        await truffleAssert.reverts(
            delayVault.CreateVault(token.address, firstAmount, day, day, week),
            "delay less than min delay"
        )
        await truffleAssert.reverts(
            delayVault.CreateVault(token.address, secondAmount, week, day, week),
            "delay less than min delay"
        )
        await truffleAssert.reverts(
            delayVault.CreateVault(token.address, thirdAmount, week * 2, day, week),
            "delay less than min delay"
        )
        await truffleAssert.reverts(
            delayVault.CreateVault(token.address, fourthAmount, week * 4, month, week),
            "delay less than min delay"
        )
    })

    it("create vaults with all limits", async () => {
        // create vault with first limit
        await truffleAssert.passes(
            delayVault.CreateVault(token.address, firstAmount, week, 0, 0, { from: accounts[1] })
        )
        // create vault with second limit
        await truffleAssert.passes(
            delayVault.CreateVault(token.address, secondAmount, week * 2, 0, 0, { from: accounts[2] })
        )
        // create vault with third limit
        await truffleAssert.passes(
            delayVault.CreateVault(token.address, thirdAmount, week * 4, 0, 0, { from: accounts[3] })
        )
        // create vault with fourth limit
        await truffleAssert.passes(
            delayVault.CreateVault(token.address, fourthAmount, 0, month, month * 3, { from: accounts[4] })
        )
        // create vault with fifth limit
        await truffleAssert.passes(
            delayVault.CreateVault(token.address, fifthAmount, 0, 0, month * 4, { from: accounts[5] })
        )
        // get vaults length
        const usersArr = await delayVault.GetAllUsersData(token.address)
        const delayData = await delayVault.GetDelayLimits(token.address)
        const limitsLength = delayData._amount.length
        assert.equal(usersArr[0].length, limitsLength)
    })

    it("withdraw tokens from delay vault contract", async () => {
        const data = await delayVault.GetAllUsersData(token.address)
        const usersArr = data[0]
        const vaultArr = data._vaults
        for (let i = 0; i < usersArr.length; i++) {
            const tx = await delayVault.Withdraw(token.address, { from: usersArr[i] })
            const logs = tx.logs[tx.logs.length - 1].args
            assert.equal(logs.Token, token.address)
            assert.equal(logs.Amount, 0)
            assert.equal(logs.StartDelay, 0)
            assert.equal(logs.FinishDelay, 0)
            assert.equal(logs.Owner, usersArr[i])
        }
        // check locked Deal V2 pools amounts
        for (let i = 0; i < usersArr.length; i++) {
            const data = await lockedDealV2.GetMyPoolDataByToken(usersArr[i].toString(), [token.address])
            assert.equal(data.pools[0].StartAmount, vaultArr[i][0])
        }
    })
})
