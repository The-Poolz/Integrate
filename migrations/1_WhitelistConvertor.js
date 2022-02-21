const WhiteListConvertor = artifacts.require("WhiteListConvertor");

module.exports = function (deployer) {
  deployer.deploy(WhiteListConvertor, '0x0000000000000000000000000000000000000000');
};