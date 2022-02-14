const WhiteListConvertor = artifacts.require("WhiteListConvertor");
const { assert } = require('chai');
const truffleAssert = require('truffle-assertions');

contract('WhiteListConvertor', accounts => {
    let instance, ownerAddress;
    const newOperation = false;
    const newPrice = 50;
    const contract = accounts[9];

    before(async () => {
        instance = await WhiteListConvertor.deployed({ from: accounts[0] });
        const owner = await instance.owner();
        ownerAddress = owner.toString();
    })

    describe('Setting new price, whitelist address', async () => {
        const id = 1;

        it('should set new price', async () => {
            await instance.SetPrice(id, newPrice, newOperation, contract, { from: ownerAddress });
            const newCheckPrice = await instance.Identifiers(id);

            assert.equal(newCheckPrice[0].toNumber(), newPrice);
            assert.equal(newCheckPrice[1], newOperation);
        });

        it('NewPrice event is emitted', async () => {
            result = await instance.SetPrice(id, newPrice, newOperation, contract, { from: ownerAddress });
            // Check event
            truffleAssert.eventEmitted(result, 'NewPrice', (ev) => {
                return ev.Id == id && ev.Price == newPrice;
            });
        })

        it('should set new address', async () => {
            const previousAddr = await instance.WhiteListAddress();
            const newAddr = accounts[2];
            await instance.SetWhiteListAddress(newAddr);
            const currentAddr = await instance.WhiteListAddress();
            assert.notEqual(previousAddr, currentAddr);
            assert.equal(newAddr, currentAddr);
        })
    })

    describe('Validation', async () => {
        it('Price validation', async () => {
            const wrongPrice = 0;

            await truffleAssert.reverts(
                instance.SetPrice(1, wrongPrice, newOperation, contract, { from: ownerAddress }),
                "Should be greater than zero"
            );
        })

        it('should revert when the same address', async () => {
            const previousAddr = await instance.WhiteListAddress();
            await truffleAssert.reverts(
                instance.SetWhiteListAddress(previousAddr), 'Should use new address');
        })

        it('wrong user ownership', async () => {
            const subject = accounts[5];
            const wrongAddr = accounts[3];
            const id = '1';
            await truffleAssert.reverts(
                instance.SetWhiteListAddress(subject, { from: wrongAddr }), 'Authorization Error');
            await truffleAssert.reverts(
                instance.Register(subject, id, '10000000', { from: wrongAddr }), 'Only the Contract can call this');
            await truffleAssert.reverts(
                instance.LastRoundRegister(subject, id, { from: wrongAddr }), 'Only the Contract can call this');
        })
    });
});