// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Manageable.sol";

contract HodlersWhitelist is Manageable {
function c_0x73a14298(bytes32 c__0x73a14298) internal pure {}

    constructor() public {c_0x73a14298(0x6c4e47af36c61dc21f27f8336c92e8429ce76f08dcfd6b460e51db3f5f42f3a6); /* function */ 

c_0x73a14298(0x0f75a51efe6337cc32805b093c4ade76a1ba8c65f87695cc443d996cec851bd1); /* line */ 
        c_0x73a14298(0xfcd8df07e8a4c99005afb94554788fc714a4f937d856d388db3cf902e9b29679); /* statement */ 
MaxUsersLimit = 600;
    }
    
    uint256 public MaxUsersLimit;

    modifier isBelowUserLimit(uint256 _limit) {c_0x73a14298(0x03fc4e95cd23e01dcb554246610255e4fd38b2c98da0b41e74fcab04d9868d11); /* function */ 

c_0x73a14298(0x3485bec7f77069809cad8fc71c4f86863a26adb919f5f69cd402b8c58dc0f942); /* line */ 
        c_0x73a14298(0x8ee26335d3d9b5e7f4ef8a52f2b6d93cde7b09e85cc06c0bc8f6d72d0d2f5435); /* requirePre */ 
c_0x73a14298(0x2b926d9e45963e6f3c7a95f25b092a5cf3c30a275fb42f4f0029455f7d06619f); /* statement */ 
require(_limit <= MaxUsersLimit, "Maximum User Limit exceeded");c_0x73a14298(0x0de93e8ff41d13bf54ceb174ace9e42bb657b0685ade98b106b4a6d9020b02a4); /* requirePost */ 

c_0x73a14298(0xa20e486cfd3ed43d0d67b39f9d1e0ca27bd0d346d1414baa2211883a0de1617f); /* line */ 
        _;
    }

    function setMaxUsersLimit(uint256 _limit) external onlyOwner {c_0x73a14298(0xf10a29df684bb4e7a7399eb9eb8040daf2bfc6fda2ae4eba562d722b53f56e5a); /* function */ 

c_0x73a14298(0x72606f966546ff140bc1fc8b09bd01d44e62ac226f34a09bf4aff82124cab956); /* line */ 
        c_0x73a14298(0x2ba355b7e90a302a2312664fcff248890460483897a99e7f5d0b7fb596150b54); /* statement */ 
MaxUsersLimit = _limit;
    }

    function CreateManualWhiteList(uint256 _ChangeUntil) external onlyOwnerOrGov returns (uint256 Id) {c_0x73a14298(0x323a8ac87f15535923a104a69ece9d442a1269656af208e50b0cdcf9ee16a1d8); /* function */ 

c_0x73a14298(0x0b15f7a7ff4fc9af4838dfda35a2cbad3c79a48d3763cffaea9d211528642681); /* line */ 
        c_0x73a14298(0xe913953130ac166578969ff6e01a1d73d68ad2e701e0f31f12e5526ff893872c); /* statement */ 
WhitelistSettings[WhiteListCount] =  WhiteListItem(
            msg.sender,
            _ChangeUntil,
            false
        );
c_0x73a14298(0xcccb8aacd1dea666b24ba32221bb8f8ad8ca292327038e2bd0f58e5047dfbd38); /* line */ 
        c_0x73a14298(0x9e8de60447b24badba0d16a94e120415e19ea4df69320930a32801af7696bfaa); /* statement */ 
MainWhitelistId = WhiteListCount;
c_0x73a14298(0xacc2625ea6368f8f379aa5d3f2c542902de2869da98ce61e4cea4a36d10e32f9); /* line */ 
        WhiteListCount++;
c_0x73a14298(0x185adc82c6d7681da50cc010ad18f4021a11fcdb8bee4ce77a34ff913db6dc15); /* line */ 
        c_0x73a14298(0x7210662debe7ca6117aa4aa261112672b53bcbf4e1e7362e05290c1c4ae09209); /* statement */ 
emit NewWhiteList(MainWhitelistId, msg.sender, _ChangeUntil);
c_0x73a14298(0x70db863db3874178456263093004c2e918441bd9be6abb8ed7da4fedb1a48b97); /* line */ 
        c_0x73a14298(0x000bf7c90a73fec942c0d2119937419cf28ae5b0c5bc0d53b0112f764f6dabfb); /* statement */ 
return MainWhitelistId;
    }

    function ChangeCreator(uint256 _Id, address _NewCreator)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
    {c_0x73a14298(0xc0442f1939755c35ab5b2e3747a7596924a42404bea819d90fa6916b6690c8ea); /* function */ 

c_0x73a14298(0x7fdfec52d6fa9823792afc6a8562da78f12470c7936743e836582d078e466abe); /* line */ 
        c_0x73a14298(0x9f91645a0acf3afe2ff8b4f42a02e503202b5ddbc5d8531005fb313d911f87ea); /* statement */ 
WhitelistSettings[_Id].Creator = _NewCreator;
    }

    function AddAddress(uint256 _Id, address[] calldata _Users)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        isBelowUserLimit(_Users.length)
    {c_0x73a14298(0xe69b9f1ea78789121f039c4fbf3669eb3b9fc60fe4548dd94f47c8e27c864d47); /* function */ 

c_0x73a14298(0xee0454e17bcb362fe238a7e382b399ea15d3def5c1e962c18b0bf864b6981f2d); /* line */ 
        c_0x73a14298(0x68462e4a9f643926ce864f68513479fe9927559b3a223cae67673b471ec377bf); /* requirePre */ 
c_0x73a14298(0xae8c323492994234218bb40919c1da990cf47e2563e894064fc58d7de47a8ae3); /* statement */ 
require(_Users.length > 0,"Need something...");c_0x73a14298(0xf6f7fa1074b0d01bcf6edeb9bf99ff0d579b57e59b4ad98f3ad5b02111bff5bc); /* requirePost */ 

c_0x73a14298(0x6231aa45413d667fd3226f41eb03b5802456d321682202aa6ba290da6659b831); /* line */ 
        c_0x73a14298(0xc84b79388a17107bd76ee7e3f7fa74eb111d907993b329ff94585dd7c16bfc6d); /* statement */ 
if(!WhitelistSettings[_Id].isReady){c_0x73a14298(0xcd299ee76868c04707b3c0cd2136fd23a1a44ea29c8e25273c32c93c41c012ce); /* branch */ 

c_0x73a14298(0x1e57efe88fccb771418cb00159f1c82367dc5e2de90c0a01933f6241a8c4192f); /* line */ 
            c_0x73a14298(0x2a5560acbe5e05254bdb1f092e901db1b9e268f08de8b253a30cdc90e04c0f8f); /* statement */ 
WhitelistSettings[_Id].isReady = true;
        }else { c_0x73a14298(0x4b10528029bad0dd35b03feaa053fdf4b8c2543579dfbce95e1f5e3f26c3bbc9); /* branch */ 
}
c_0x73a14298(0x971b415c0385f92793b50e38f31b8f2d73d296354dacedb0d7424d6b553852df); /* line */ 
        c_0x73a14298(0x9aa1161b1e7e78b8825c6fad183942493046e9a8526f5a2da35c437044f939ba); /* statement */ 
for (uint256 index = 0; index < _Users.length; index++) {
c_0x73a14298(0x6b21e0afc2a9e601ddfa2d351b7e58b5f6a37b915398bc7f8194b02413828da4); /* line */ 
            c_0x73a14298(0x62383952ca3fc49df4293d941195be12f07e092f94cf1848cb472002bf97c272); /* statement */ 
_AddAddress(_Id, _Users[index]);
        }
    }

    function RemoveAddress(uint256 _Id, address[] calldata _Users)
        external
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        ValidateId(_Id)
        isBelowUserLimit(_Users.length)
    {c_0x73a14298(0x120e21235d141bbdad8831fedea48b840c79afdd41273007b624c2379257b459); /* function */ 

c_0x73a14298(0x9b0dc20c5634e702587420de9c2be48c8d9f48318b666b57ef0e35a87a504432); /* line */ 
        c_0x73a14298(0xfcb6dce7c6201ff7b6056aea0f9b8a7d4910abe1012ec7e9dd9a20c487ba28e3); /* statement */ 
for (uint256 index = 0; index < _Users.length; index++) {
c_0x73a14298(0x5f53fdbfa8ca5707ff9a138f9a6580a8e434932ceeb7bb9b6057ad22bb395c3f); /* line */ 
            c_0x73a14298(0xe18bf0edef8daaa0887e7401a3d2276abdbfda3a8333ef4302b87d21d59b9fba); /* statement */ 
_RemoveAddress(_Id, _Users[index]);
        }
    }
}