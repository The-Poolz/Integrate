  
const LockedDeal = artifacts.require("PoolzLockedDeal");

module.exports = function (deployer) {
  deployer.deploy(LockedDeal);
};