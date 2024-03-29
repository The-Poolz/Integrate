// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhiteListHelper {
    event NewWhiteList(
        uint256 _WhiteListCount,
        address _creator,
        address _contract,
        uint256 _changeUntil
    );

    modifier OnlyCreator(uint256 _Id) {
        require(
            WhitelistSettings[_Id].Creator == msg.sender,
            "Only creator can access"
        );
        _;
    }

    modifier TimeRemaining(uint256 _Id) {
        require(
            block.timestamp < WhitelistSettings[_Id].ChangeUntil,
            "Time for edit is finished"
        );
        _;
    }

    modifier ValidateId(uint256 _Id) {
        require(_Id < WhiteListCount, "Wrong ID");
        _;
    }

    struct WhiteListItem {
        // uint256 Limit;
        address Creator;
        uint256 ChangeUntil;
        //uint256 DrawLimit;
        //uint256 SignUpPrice;
        address Contract;
        // mapping(address => uint256) WhiteListDB;
        bool isReady; // defualt false | true after first address is added
    }

    mapping(uint256 => mapping(address => uint256)) public WhitelistDB;
    mapping(uint256 => WhiteListItem) public WhitelistSettings;
    uint256 public WhiteListCost;
    uint256 public WhiteListCount;

    function _AddAddress(uint256 _Id, address user, uint256 amount) internal {
        WhitelistDB[_Id][user] = amount;
    }

    function _RemoveAddress(uint256 _Id, address user) internal {
        WhitelistDB[_Id][user] = 0;
    }

    function isWhiteListReady(uint256 _Id) external view returns (bool) {
        return WhitelistSettings[_Id].isReady;
    }

    //View function to Check if address is whitelisted
    function Check(address _user, uint256 _id) external view returns (uint256) {
        if (_id == 0) return type(uint256).max;
        return WhitelistDB[_id][_user];
    }
}
