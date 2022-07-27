// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./LockedPoolzData.sol";

contract LockedDeal is LockedPoolzData {
function c_0xca9407f7(bytes32 c__0xca9407f7) internal pure {}

    constructor() public {c_0xca9407f7(0x57945978b3ed9bfcf198e6af5b4a48f3a33d9e49d8db2540dc95a7317d586efd); /* function */ 

c_0xca9407f7(0xa28d0f2f518b6093e2efb8205ef9b58d32cd59fd48744c1bdcfdb94563d18a2b); /* line */ 
        c_0xca9407f7(0x308e0b35f0a6d820f0df0eece2934246235dbbbc1fda5ce70767827e204e8f5f); /* statement */ 
StartIndex = 0;
    }

    uint256 internal StartIndex;

    //@dev no use of revert to make sure the loop will work
    function WithdrawToken(uint256 _PoolId) public returns (bool) {c_0xca9407f7(0xc63d2d27f51a8bf3ca1540ff33e272e71708aa3272496887afac3a4c339e6b6a); /* function */ 

        //pool is finished + got left overs + did not took them
c_0xca9407f7(0x6504d6005dbe22a3cb7441dbf8e6b830dfa34ab38bd62342349b5ef0369b5756); /* line */ 
        c_0xca9407f7(0x3abff6f98c599f949d9344cfbdbe8d4ccba14e81a1d45a4880378c72dd806993); /* statement */ 
if (
            _PoolId < Index &&
            AllPoolz[_PoolId].UnlockTime <= now &&
            AllPoolz[_PoolId].Amount > 0
        ) {c_0xca9407f7(0x5a184ecc17ab47b337d93dfc69703cfd6c773d2867fecf47dd9544d12df81ca1); /* branch */ 

c_0xca9407f7(0x9250c9dd09121360a2273f5b8f183fbaec03c029a71980e572b9815d36545bea); /* line */ 
            c_0xca9407f7(0x6e985f1edfa6b2ebbd48d5f528083b3bf2279156721c9b1572e2eec139aa09b3); /* statement */ 
TransferToken(
                AllPoolz[_PoolId].Token,
                AllPoolz[_PoolId].Owner,
                AllPoolz[_PoolId].Amount
            );
c_0xca9407f7(0x193d4c0d57d460d16e779091e3237b4c5d26b3fd95ddb537a88e17bf9080720b); /* line */ 
            c_0xca9407f7(0x5cd38cbdc6b5662eaa030f3dc00cd71881caea5f6a3afbb89159e216239537e5); /* statement */ 
AllPoolz[_PoolId].Amount = 0;
c_0xca9407f7(0x8ba9e3749f967a36b18b98f1f8e134dbfc5b0afc566e451b2223c952cd34fcf9); /* line */ 
            c_0xca9407f7(0xa208dd67fdaa941be4129ecbdf34a9ca28d69501273dc50ae709535a86bd0690); /* statement */ 
return true;
        }else { c_0xca9407f7(0x46a151ba22e36c794a02567ba3552afe44170747ea4f4328916874cd02a17017); /* branch */ 
}
c_0xca9407f7(0x638423e4ad53c33038d604a99aeb7d07f6b4145ea86602f96d3b3b8fdb32422b); /* line */ 
        c_0xca9407f7(0x6089dfae9e3a696ae80b2f07a0c60d1e4820a0dbb6a135344e538f9069dc404d); /* statement */ 
return false;
    }
}
