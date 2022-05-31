// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "poolz-helper-v2/contracts/ERC20Helper.sol";
import "poolz-helper-v2/contracts/ETHHelper.sol";
import "poolz-helper-v2/contracts/GovManager.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// FlexStakingManageable - contains all Admin settings
contract FlexStakingManageable is GovManager, ETHHelper, ERC20Helper, Pausable {
    modifier notNullAddress(address _contract) {
        require(_contract != address(0), "Invalid contract address!");
        _;
    }

    constructor() {}

    address public LockedDealAddress;

    function SetLockedDealAddress(address lockedDeal) public onlyOwnerOrGov {
        require(
            LockedDealAddress != lockedDeal,
            "the address of the Locked Deal has already been changed!"
        );
        LockedDealAddress = lockedDeal;
    }

    function Pause() public onlyOwnerOrGov {
        _pause();
    }

    function Unpause() public onlyOwnerOrGov {
        _unpause();
    }
}
