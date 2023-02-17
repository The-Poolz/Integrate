const TestToken = artifacts.require("ERC20Token")

module.exports = function (deployer) {
    deployer.deploy(TestToken, "TestToken", "TEST")
}
