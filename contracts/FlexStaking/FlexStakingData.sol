// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FlexStakingManageable.sol";

// FlexStakingData - stores all variables for the user and project owner
contract FlexStakingData is FlexStakingManageable {
    mapping(uint256 => Pool) public PoolsMap;
    uint256 TotalPools;
    mapping(uint256 => uint256) public Reserves; // Reserve of tokens

    struct Pool {
        address Owner; // stake pool owner
        address LockedToken; // The token address that is locking
        address RewardToken; // The reward token address
        uint256 TokensAmount; // Total amount of reward tokens
        uint256 StartTime; // The time that can start using the staking
        uint256 FinishTime; // The time that no longer can use the staking
        uint256 APR; // Annual percentage rate
        uint256 MinDuration; // For how long the user can set up the staking
        uint256 MaxDuration;
        uint256 MinAmount; // How much user can stake
        uint256 MaxAmount;
        uint256 EarlyWithdraw;
    }
}
