const HodlersWhitelist = artifacts.require("HodlersWhitelist")

module.exports = function (deployer) {
  deployer.deploy(HodlersWhitelist)
}
