// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "poolz-helper-v2/contracts/GovManager.sol";

contract MultiManageable is GovManager {
    constructor() {
        maxTransactionLimit = 500;
    }

    address public LockedDealAddress;
    uint256 public maxTransactionLimit;

    function setLockedDealAddress(
        address _LockedDealAddress
    ) public onlyOwnerOrGov {
        require(
            LockedDealAddress != _LockedDealAddress,
            "Can't set the same LockedDeal address"
        );
        LockedDealAddress = _LockedDealAddress;
    }

    function setMaxTransactionLimit(uint256 _newLimit) external onlyOwnerOrGov {
        maxTransactionLimit = _newLimit;
    }
}
