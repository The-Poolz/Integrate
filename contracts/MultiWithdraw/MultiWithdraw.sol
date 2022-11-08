// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MultiManageable.sol";
import "poolz-helper-v2/contracts/interfaces/ILockedDealV2.sol";

/// @author The-Poolz contracts team
contract MultiWithdraw is MultiManageable {
    event TokensWithdrawn(uint256[] PoolsIds, uint256 Length);

    modifier notZeroAddress(address _LockedDeal) {
        require(
            _LockedDeal != address(0x0),
            "LockedDeal can't be zero address"
        );
        _;
    }

    function MultiWithdrawTokens(
        uint256[] memory _poolIds
    ) public notZeroAddress(LockedDealAddress) {
        require(
            maxTransactionLimit >= _poolIds.length,
            "Max array length limit exceeded"
        );
        for (uint256 i = 0; i < _poolIds.length; i++) {
            ILockedDealV2(LockedDealAddress).WithdrawToken(_poolIds[i]);
        }
        emit TokensWithdrawn(_poolIds, _poolIds.length);
    }
}
