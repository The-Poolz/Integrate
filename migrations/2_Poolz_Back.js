const ThePoolz = artifacts.require("PoolzBack");

module.exports = function (deployer) {
  deployer.deploy(ThePoolz);
};
