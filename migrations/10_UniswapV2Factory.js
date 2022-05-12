const UniswapV2Factory = artifacts.require("UniswapV2Factory")
const constants = require("@openzeppelin/test-helpers/src/constants")

module.exports = function (deployer) {
    deployer.deploy(UniswapV2Factory, constants.ZERO_ADDRESS)
}