// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FlexStakingData.sol";

// FlexStakingPO - contains all Project Owner settings
contract FlexStakingPO is FlexStakingData {
    event WithdrawnLeftover(uint256 Id, address Receiver, uint256 Amount);

    event CreatedPool(
        address Owner,
        uint256 Id,
        address LockedToken,
        address RewardToken,
        uint256 TokensAmount,
        uint256 StartTime,
        uint256 FinishTime,
        uint256 APR,
        uint256 MinDuration,
        uint256 MaxDuration,
        uint256 MinAmount,
        uint256 MaxAmount,
        uint256 EarlyWithdraw
    );

    function CreateStakingPool(
        address lockedToken, // The token address that is locking
        address rewardToken, // The reward token address
        uint256 tokensAmount, // Total amount of reward tokens
        uint256 startTime, // The time that can start using the staking (all time is Unix, sec)
        uint256 finishTime, // The time that no longer can use the staking
        uint256 APR, // Annual percentage rate
        uint256 minDuration, // For how long the user can set up the staking
        uint256 maxDuration,
        uint256 minAmount, // How much user can stake
        uint256 maxAmount,
        uint256 earlyWithdraw
    )
        public
        whenNotPaused
        notNullAddress(lockedToken)
        notNullAddress(rewardToken)
    {
        require(
            APR > 0 && minDuration > 0 && minAmount > 0 && tokensAmount > 0,
            "the value should be greater than zero!"
        );
        require(
            startTime >= block.timestamp - 60 && finishTime > startTime,
            "invalid start time!"
        );
        require(maxAmount >= minAmount, "invalid maxium amount!");
        require(
            maxDuration <= finishTime - startTime && maxDuration >= minDuration,
            "invalid maximum duration time!"
        );
        PoolsMap[++TotalPools] = Pool(
            msg.sender,
            lockedToken,
            rewardToken,
            tokensAmount,
            startTime,
            finishTime,
            APR,
            minDuration,
            maxDuration,
            minAmount,
            maxAmount,
            earlyWithdraw
        );
        TransferInToken(
            PoolsMap[TotalPools].RewardToken,
            msg.sender,
            tokensAmount
        );
        Reserves[TotalPools] = tokensAmount;
        emit CreatedPool(
            msg.sender,
            TotalPools,
            lockedToken,
            rewardToken,
            tokensAmount,
            startTime,
            finishTime,
            APR,
            minDuration,
            maxDuration,
            minAmount,
            maxAmount,
            earlyWithdraw
        );
    }

    function WithdrawLeftOver(uint256 id) public {
        require(id > 0 && id <= TotalPools, "invalid id!");
        require(PoolsMap[id].Owner == msg.sender, "invalid owner address!");
        require(
            block.timestamp > PoolsMap[id].FinishTime,
            "should wait when pool is over!"
        );
        require(Reserves[id] > 0, "all tokens distributed!");
        TransferToken(PoolsMap[id].RewardToken, msg.sender, Reserves[id]);
        emit WithdrawnLeftover(id, msg.sender, Reserves[id]);
        Reserves[id] = 0;
    }
}
