// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x80b31b79(bytes32 c__0x80b31b79) pure {}


contract LockedDealEvents {
function c_0x9c47393b(bytes32 c__0x9c47393b) internal pure {}

    event TokenWithdrawn(uint256 PoolId, address Recipient, uint256 Amount);
    event MassPoolsCreated(uint256 FirstPoolId, uint256 LastPoolId);
    event NewPoolCreated(
        uint256 PoolId,
        address Token,
        uint256 StartTime,
        uint256 FinishTime,
        uint256 StartAmount,
        address Owner
    );
    event PoolTransferred(
        uint256 PoolId,
        uint256 oldPoolId,
        address NewOwner,
        address OldOwner
    );
    event PoolApproval(uint256 PoolId, address Spender, uint256 Amount);
    event PoolSplit(
        uint256 OldPoolId,
        uint256 NewPoolId,
        uint256 NewAmount,
        address NewOwner
    );
}
