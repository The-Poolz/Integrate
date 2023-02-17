// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title contain stores variables.
contract DelayData {
    address public LockedDealAddress;
    mapping(address => Delay) public DelayLimit; // delay limit for every token
    mapping(address => address[]) public MyTokens;
    mapping(address => mapping(address => Vault)) public VaultMap;
    mapping(address => address[]) public Users;

    struct Vault {
        uint256 Amount;
        uint256 StartDelay;
        uint256 CliffDelay;
        uint256 FinishDelay;
    }

    struct Delay {
        uint256[] Amounts;
        uint256[] StartDelays;
        uint256[] CliffDelays;
        uint256[] FinishDelays;
        bool isActive;
    }
}
