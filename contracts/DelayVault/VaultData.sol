// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VaultManageable.sol";

/// @title VaultData - getter view functions
contract VaultData is VaultManageable {
    function GetAllMyTokens() public view returns (address[] memory) {
        return MyTokens[msg.sender];
    }

    function GetMyTokens() public view returns (address[] memory) {
        address[] storage allTokens = MyTokens[msg.sender];
        address[] memory tokens = new address[](allTokens.length);
        uint256 index;
        for (uint256 i = 0; i < allTokens.length; i++) {
            if (VaultMap[allTokens[i]][msg.sender].Amount > 0) {
                tokens[index++] = allTokens[i];
            }
        }
        return Array.KeepNElementsInArray(tokens, index);
    }

    function GetDelayLimits()
        public
        view
        returns (uint256[] memory _amount, uint256[] memory _minDelays)
    {
        return (DelayLimit.Amounts, DelayLimit.MinDelays);
    }

    function GetMinDelay(uint256 _amount) public view returns (uint256 _delay) {
        if (DelayLimit.Amounts.length == 0 || DelayLimit.Amounts[0] > _amount)
            return 0;
        uint256 tempAmount = 0;
        _delay = DelayLimit.MinDelays[0];
        for (uint256 i = 0; i < DelayLimit.Amounts.length; i++) {
            if (
                _amount > DelayLimit.Amounts[i] &&
                tempAmount < DelayLimit.Amounts[i]
            ) {
                _delay = DelayLimit.MinDelays[i];
                tempAmount = DelayLimit.Amounts[i];
            }
        }
    }
}
