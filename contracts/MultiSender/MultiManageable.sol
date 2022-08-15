// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "poolz-helper-v2/contracts/FeeBaseHelper.sol";
import "poolz-helper-v2/contracts/interfaces/IWhiteList.sol";

/// @title all admin settings
contract MultiManageable is FeeBaseHelper, Pausable {
    uint256 public UserLimit;
    address public WhiteListAddress;
    uint256 public WhiteListId;

    function setUserLimit(uint256 _userLimit) public onlyOwnerOrGov {
        UserLimit = _userLimit;
    }

    function setWhiteListAddress(address _whiteListAddr) public onlyOwnerOrGov {
        WhiteListAddress = _whiteListAddr;
    }

    function setWhiteListId(uint256 _id) public onlyOwnerOrGov {
        WhiteListId = _id;
    }

    function Pause() public onlyOwnerOrGov {
        _pause();
    }

    function Unpause() public onlyOwnerOrGov {
        _unpause();
    }
}
