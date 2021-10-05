// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Manageable.sol";

contract HodlersWhitelist is Manageable {
    constructor() public {
        MaxUsersLimit = 600;
    }
    
    uint256 public MaxUsersLimit;

    modifier isBelowUserLimit(uint256 _limit) {
        require(_limit <= MaxUsersLimit, "Maximum User Limit exceeded");
        _;
    }

    function setMaxUsersLimit(uint256 _limit) external onlyOwner {
        MaxUsersLimit = _limit;
    }

    function CreateManualWhiteList(uint256 _ChangeUntil) external onlyOwnerOrGov returns (uint256 Id) {
        WhitelistSettings[WhiteListCount] =  WhiteListItem(
            msg.sender,
            _ChangeUntil,
            false
        );
        MainWhitelistId = WhiteListCount;
        WhiteListCount++;
        emit NewWhiteList(MainWhitelistId, msg.sender, _ChangeUntil);
        return MainWhitelistId;
    }

    function ChangeCreator(uint256 _Id, address _NewCreator)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
    {
        WhitelistSettings[_Id].Creator = _NewCreator;
    }

    function AddAddress(uint256 _Id, address[] calldata _Users)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        isBelowUserLimit(_Users.length)
    {
        require(_Users.length > 0,"Need something...");
        if(!WhitelistSettings[_Id].isReady){
            WhitelistSettings[_Id].isReady = true;
        }
        for (uint256 index = 0; index < _Users.length; index++) {
            _AddAddress(_Id, _Users[index]);
        }
    }

    function RemoveAddress(uint256 _Id, address[] calldata _Users)
        external
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        ValidateId(_Id)
        isBelowUserLimit(_Users.length)
    {
        for (uint256 index = 0; index < _Users.length; index++) {
            _RemoveAddress(_Id, _Users[index]);
        }
    }
}