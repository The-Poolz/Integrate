const HodlersWhitelist = artifacts.require('HodlersWhitelist')
const { assert } = require('chai');
const truffleAssert = require('truffle-assertions');
const timeMachine = require('ganache-time-traveler');

contract('Hodlers Whitelist', accounts => {
    let instance, fromAddress = accounts[0], whitelistId, userLimit = 600

    before(async () => {
        instance = await HodlersWhitelist.deployed()
    })

    it('should create new hodlers whitelist', async () => {
        const now = Date.now() / 1000 // current timestamp in seconds
        const timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
        const result = await instance.CreateManualWhiteList(timestamp, {from: fromAddress})
        const count = await instance.WhiteListCount()
        const logs = result.logs[0].args
        whitelistId = logs._WhitelistId.toString()
        assert.equal('0', logs._WhitelistId.toString())
        assert.equal(fromAddress, logs._creator.toString())
        assert.equal(timestamp, logs._changeUntil.toString())
        assert.equal('1', count.toString())
    })

    it('isReady is false before adding the first address', async () => {
        const isReady = await instance.isWhiteListReady(whitelistId)
        assert.isFalse(isReady)
    })

    it('should set main whitelist ID', async () => {
        await instance.SetMainWhitelistId(whitelistId, {from: fromAddress})
        const result = await instance.MainWhitelistId()
        assert.equal(result, whitelistId)
    })

    it('should add addresses to whitelist', async () => {
        const accountsArray = [accounts[1], accounts[2], accounts[3], accounts[4], accounts[5]]
        await instance.AddAddress(whitelistId, accountsArray, {from: fromAddress})
        const result1 = await instance.IsPOZHolder(accounts[1])
        assert.isTrue(result1)
        const result2 = await instance.IsPOZHolder(accounts[2])
        assert.isTrue(result2)
        const result3 = await instance.IsPOZHolder(accounts[3])
        assert.isTrue(result3)
        const result4 = await instance.IsPOZHolder(accounts[4])
        assert.isTrue(result4)
        const result5 = await instance.IsPOZHolder(accounts[5])
        assert.isTrue(result5)
        const result6 = await instance.IsPOZHolder(accounts[6])
        assert.isFalse(result6)
    })

    it('isReady is true after adding the first address', async () => {
        const isReady = await instance.isWhiteListReady(whitelistId)
        assert.isTrue(isReady)
    })

    it('reverts when called by non creator address', async () => {
        const accountsArray = [accounts[1], accounts[2], accounts[3]] // array size - 5
        await truffleAssert.reverts(instance.AddAddress(whitelistId, accountsArray, {from: accounts[1]}), 'Only creator can access')
    })

    it('reverts when called invalid ID', async () => {
        const accountsArray = [accounts[1], accounts[2], accounts[3]] // array size - 5
        await truffleAssert.reverts(instance.AddAddress(100, accountsArray, {from: fromAddress}), 'Wrong ID')
    })

    it('revert after time is expired', async () => {
        await timeMachine.advanceTimeAndBlock(3601);
        const accountsArray = [accounts[1], accounts[2], accounts[3]] // array size - 5
        await truffleAssert.reverts(instance.AddAddress(whitelistId, accountsArray, {from: fromAddress}), 'Time for edit is finished')
        await timeMachine.advanceTimeAndBlock(-3601);
    })
    
    it('revers when no address is provided', async () => {
        await truffleAssert.reverts(instance.AddAddress(whitelistId, [], {from: fromAddress}), 'Need something...')
    })

    it('should remove the address from whitelist', async () => {
        const accountsArray = [accounts[4], accounts[5]]
        await instance.RemoveAddress(whitelistId, accountsArray, {from: fromAddress})
        const result1 = await instance.IsPOZHolder(accounts[4])
        assert.isFalse(result1)
        const result2 = await instance.IsPOZHolder(accounts[5])
        assert.isFalse(result2)
        const result3 = await instance.IsPOZHolder(accounts[1])
        assert.isTrue(result3)
    })

    it(`returns the value of MaxUsersLimit as ${userLimit}`, async () => {
        const limit = await instance.MaxUsersLimit()
        assert.equal(limit.toNumber(), userLimit)
    })

    it('update max user limit to 15', async () => {
        const newLimit = 15
        await instance.setMaxUsersLimit(newLimit)
        const result = await instance.MaxUsersLimit()
        assert.equal(result, newLimit)
        userLimit = result
    })

    it(`should not allow to add users more than ${userLimit}`, async () => {
        const accountsArray = []
        for(let i=0; i<userLimit + 1; i++){
            accountsArray.push(accounts[i % accounts.length])
        }
        await truffleAssert.reverts(instance.AddAddress(whitelistId, accountsArray, {from: fromAddress}), 'Maximum User Limit exceeded')        
    })

    it(`should not allow to remove users more than ${userLimit}`, async () => {
        const accountsArray = []
        for(let i=0; i<userLimit + 1; i++){
            accountsArray.push(accounts[i % accounts.length])
        }
        await truffleAssert.reverts(instance.RemoveAddress(whitelistId, accountsArray, {from: fromAddress}), 'Maximum User Limit exceeded')        
    })

    it('change creator address', async () => {
        await instance.ChangeCreator(whitelistId, accounts[1], {from: fromAddress})
        fromAddress = accounts[1]
        const result = await instance.WhitelistSettings(whitelistId)
        assert.equal(result.Creator, accounts[1])
    })

})