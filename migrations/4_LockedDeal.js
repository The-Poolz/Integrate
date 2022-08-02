const LockedDeal = artifacts.require("LockedDeal")

module.exports = function (deployer) {
  deployer.deploy(LockedDeal)
}
