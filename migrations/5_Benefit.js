  
const Benefit = artifacts.require("PoolzBenefit");

module.exports = function (deployer) {
  deployer.deploy(Benefit);
};