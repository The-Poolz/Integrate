const MultiSender = artifacts.require("MultiSender")
const TestToken = artifacts.require("ERC20Token")
const WhiteList = artifacts.require("WhiteList")
const { assert } = require("chai")
const constants = require("@openzeppelin/test-helpers/src/constants");
const truffleAssert = require("truffle-assertions");

const { createNewWhiteList } = require('./helper')

contract("MultiSender and WhiteList integration tests", (accounts) => {
    let instance, token, whiteList, feeToken
    let whiteListId
    const fee = 100
    const amount = 100
    const amounts = [amount, amount, amount, amount, amount, amount, amount, amount, amount, amount]
    const discount = 50 // half fee price

    before(async () => {
        instance = await MultiSender.new()
        token = await TestToken.new("TestToken", "TEST")
        feeToken = await TestToken.new("Fee", "FEE")
        whiteList = await WhiteList.new()
        let tx = await createNewWhiteList(whiteList, instance.address, accounts[0])
        whiteListId = tx.logs[0].args._WhiteListCount.toNumber()
        await instance.setWhiteListAddress(whiteList.address)
        await instance.setWhiteListId(whiteListId)
        await instance.SetFeeAmount(fee)
    })

    it("fee when multi send ERC20", async () => {
        await token.approve(instance.address, amount * amounts.length)
        await truffleAssert.reverts(instance.MultiSendERC20(token.address, accounts, amounts), 
        "Not Enough Fee Provided")
        await whiteList.AddAddress(whiteListId, [accounts[0]], [fee])
        const oldEthBal = await web3.eth.getBalance(instance.address)
        await instance.MultiSendERC20(token.address, accounts, amounts)
        const ethBal = await web3.eth.getBalance(instance.address)
        assert.equal(oldEthBal, ethBal)
        await instance.SetFeeToken(feeToken.address)
        await token.approve(instance.address, amount * amounts.length)
        await truffleAssert.reverts(instance.MultiSendERC20(token.address, accounts, amounts), 
        "no allowance")
        const oldFeeBal = await feeToken.balanceOf(instance.address)
        await feeToken.approve(instance.address, fee)
        await instance.MultiSendERC20(token.address, accounts, amounts)
        const feeBal = await feeToken.balanceOf(instance.address)
        await instance.WithdrawFee(feeToken.address, accounts[0])
        assert.equal(oldFeeBal, '0')
        assert.equal(parseInt(oldFeeBal) + fee, feeBal.toString())
    })

    it("fee when multi send ETH", async () => {
        await instance.SetFeeToken(constants.ZERO_ADDRESS)
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts), "Not Enough Fee Provided")
        await whiteList.AddAddress(whiteListId, [accounts[0]], [fee])
        const oldEthBal = await web3.eth.getBalance(instance.address)
        await instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length})
        const ethBal = await web3.eth.getBalance(instance.address)
        assert.equal(ethBal.toString(), '0')
        assert.equal(oldEthBal, ethBal)
        await instance.SetFeeToken(feeToken.address)
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts), 
        "no allowance")
        const oldFeeBal = await feeToken.balanceOf(instance.address)
        await feeToken.approve(instance.address, fee)
        await instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length})
        const feeBal = await feeToken.balanceOf(instance.address)
        assert.equal(oldFeeBal, '0', "invalid balance 1")
        assert.equal(parseInt(oldFeeBal) + fee, feeBal.toString(), "invalid balance 2")
    })

    it('(multi ETH) pay with erc20 dicount', async () => {
        await feeToken.approve(instance.address, discount)
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length}), 
        "no allowance")
        await whiteList.AddAddress(whiteListId, [accounts[0]], [discount])
        const oldFeeBal = await feeToken.balanceOf(instance.address)
        await instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length})
        const feeBal = await feeToken.balanceOf(instance.address)
        assert.equal((parseInt(oldFeeBal)  + discount).toString(), (feeBal).toString())
    })
    
    it("(multi ERC20) pay with erc20 dicount", async () => {
        await feeToken.approve(instance.address, discount)
        await token.approve(instance.address, amount * amounts.length)
        await truffleAssert.reverts(instance.MultiSendERC20(token.address, accounts, amounts),
        "no allowance")
        await whiteList.AddAddress(whiteListId, [accounts[0]], [discount])
        const oldFeeBal = await feeToken.balanceOf(instance.address)
        await instance.MultiSendERC20(token.address, accounts, amounts)
        const feeBal = await feeToken.balanceOf(instance.address)
        assert.equal((parseInt(oldFeeBal)  + discount).toString(), (feeBal).toString())
    })

    it('(multi ETH) pay with eth dicount', async () => {
        await instance.SetFeeToken(constants.ZERO_ADDRESS)
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length + discount}), 
        "Reqired Amount=" + amount * amounts.length + " Fee=" + amount)
        await whiteList.AddAddress(whiteListId, [accounts[0]], [discount])
        const oldEthBal = await web3.eth.getBalance(instance.address)
        await instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length + discount})
        const ethBal = await web3.eth.getBalance(instance.address)
        assert.equal(parseInt(oldEthBal) + discount, ethBal)
    })

    it('should pass MultiSendEth', async () => {
        await truffleAssert.passes(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length + discount * 2}))
        await instance.SetFeeAmount(0)
        await truffleAssert.passes(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length}))
        await instance.SetFeeToken(feeToken.address)
        await truffleAssert.passes(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length}))
    })

    it("should pass MultiSendERC20", async () => {
        await instance.SetFeeToken(constants.ZERO_ADDRESS)
        await token.approve(instance.address, amount * amounts.length)
        await truffleAssert.passes(instance.MultiSendERC20(token.address, accounts, amounts))
        await instance.SetFeeAmount(amount)
        await token.approve(instance.address, amount * amounts.length)
        await truffleAssert.passes(instance.MultiSendERC20(token.address, accounts, amounts, {value: amount}))
    })

    it("should revert MultiSendERC20 when sending the wrong fee", async () => {
        await truffleAssert.reverts(instance.MultiSendERC20(token.address, accounts, amounts, {value: amount + 1}),
            "Reqired ETH fee=" + amount)
        await truffleAssert.reverts(instance.MultiSendERC20(token.address, accounts, amounts, {value: amount - 1}), "Not Enough Fee Provided")
    })

    it("should revert MultiSendETH when sending the wrong fee", async () => {
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length + amount + 1}),
            "Reqired Amount=" + amount * amounts.length + " Fee=" + amount)
        await truffleAssert.reverts(instance.MultiSendEth(accounts, amounts, {value: amount * amounts.length + amount - 1}), 
            "Reqired Amount=" + amount * amounts.length + " Fee=" + amount)
    })
})
