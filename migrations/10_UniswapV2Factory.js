const UniswapV2Factory = artifacts.require("UniswapV2Factory");

module.exports = function (deployer) {
    const feeAddress = "0x0000000000000000000000000000000000000000";
    deployer.deploy(UniswapV2Factory, feeAddress);
};