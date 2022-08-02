const WhiteListConvertor = artifacts.require("WhiteListConvertor")
const constants = require("@openzeppelin/test-helpers/src/constants")

module.exports = function (deployer) {
  deployer.deploy(WhiteListConvertor, constants.ZERO_ADDRESS)
}
