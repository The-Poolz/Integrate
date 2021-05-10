  
const WhiteList = artifacts.require("PoolzWhiteList");

module.exports = function (deployer) {
  deployer.deploy(WhiteList);
};