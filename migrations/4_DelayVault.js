const DelayVault = artifacts.require("DelayVault")

module.exports = function (deployer) {
    deployer.deploy(DelayVault)
}
