const FlexStakingUser = artifacts.require("FlexStakingUser.sol")

module.exports = function (deployer) {
  deployer.deploy(FlexStakingUser)
}
