// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FlexStakingPO.sol";
import "poolz-helper-v2/contracts/interfaces/ILockedDealV2.sol";

// FlexStakingUser - contains all user settings
contract FlexStakingUser is FlexStakingPO {
    event StakeInfo(
        address User,
        uint256 Id,
        uint256 LockedAmount,
        uint256 Earn,
        uint256 Duration
    );

    function Stake(
        uint256 id,
        uint256 amount,
        uint256 duration // in seconds
    ) public whenNotPaused notNullAddress(LockedDealAddress) {
        require(id > 0 && id <= TotalPools, "invalid id!");
        require(
            amount >= PoolsMap[id].MinAmount &&
                amount <= PoolsMap[id].MaxAmount,
            "wrong amount!"
        );
        require(
            duration <= PoolsMap[id].MaxDuration &&
                duration >= PoolsMap[id].MinDuration,
            "wrong duration time!"
        );
        uint256 earn = ((amount * PoolsMap[id].APR * duration) / 100) /
            365 /
            24 /
            60 /
            60;
        require(Reserves[id] >= earn, "not enough tokens!");
        require(
            PoolsMap[id].StartTime <= block.timestamp &&
                PoolsMap[id].FinishTime >= block.timestamp,
            "Pool is not started or is finished!"
        );
        uint256 lockedAmount = amount;
        address rewardToken = PoolsMap[id].RewardToken;
        address lockedToken = PoolsMap[id].LockedToken;
        uint256 earlyWithdraw = PoolsMap[id].EarlyWithdraw;
        TransferInToken(lockedToken, msg.sender, amount);
        if (rewardToken != lockedToken && earn > 0) {
            LockToken(rewardToken, earn, duration, earlyWithdraw);
        } else {
            lockedAmount += earn;
        }
        LockToken(lockedToken, lockedAmount, duration, earlyWithdraw);
        Reserves[id] -= earn;
        emit StakeInfo(msg.sender, id, amount, earn, duration);
    }

    function LockToken(
        address token,
        uint256 amount,
        uint256 duration,
        uint256 earlyWithdraw
    ) internal {
        ApproveAllowanceERC20(token, LockedDealAddress, amount);
        ILockedDealV2(LockedDealAddress).CreateNewPool(
            token,
            block.timestamp + duration - earlyWithdraw,
            block.timestamp + duration,
            amount,
            msg.sender
        );
    }
}
