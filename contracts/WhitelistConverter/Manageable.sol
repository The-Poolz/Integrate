// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.7.0;

import "poolz-helper/contracts/GovManager.sol";

contract Manageable is GovManager {
    event NewPrice(uint256 Id, uint256 Price, bool Operation, address Contract);

    struct PriceConvert {
        uint256 Price;
        bool Operation; // false - devide || true - multiply
        address Contract;
    }

    address public WhiteListAddress;
    mapping(uint256 => PriceConvert) public Identifiers; // Pools

    modifier zeroAmount(uint256 amount) {
        require(amount > 0, "Should be greater than zero");
        _;
    }

    function SetPrice(
        uint256 _Id,
        uint256 _NewPrice,
        bool _Operation,
        address _Contract
    ) external onlyOwnerOrGov zeroAmount(_NewPrice) {
        Identifiers[_Id].Price = _NewPrice;
        Identifiers[_Id].Operation = _Operation;
        Identifiers[_Id].Contract = _Contract;
        emit NewPrice(_Id, _NewPrice, _Operation, _Contract);
    }

    function SetWhiteListAddress(address _NewAddress) public onlyOwnerOrGov {
        require(_NewAddress != WhiteListAddress, "Should use new address");
        WhiteListAddress = _NewAddress;
    }
}
