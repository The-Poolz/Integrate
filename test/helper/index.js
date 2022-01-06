const createNewWhiteList = async (whiteList, contractAddress, fromAddress) => {
    const now = Date.now() / 1000 // current timestamp in seconds
    const timestamp = Number(now.toFixed()) + 3600 // timestamp one hour from now
    let whiteListCost = web3.utils.toWei('0.01', 'ether')
    const result = await whiteList.CreateManualWhiteList(timestamp, contractAddress, { from: fromAddress, value: whiteListCost })
    const logs = result.logs[0].args
    assert.equal(logs._creator, fromAddress)
    assert.equal(logs._contract, contractAddress)
    assert.equal(logs._changeUntil, timestamp)
    return result
}

module.exports = {
    createNewWhiteList
}