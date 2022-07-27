// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./LockedControl.sol";

contract LockedPoolzData is LockedControl {
function c_0xe307ad66(bytes32 c__0xe307ad66) internal pure {}

    function GetMyPoolsId() public view returns (uint256[] memory) {c_0xe307ad66(0xd2f215f8d76093aa6a2db324cc2ad42391cbf8a7b9d35f68d47150e103b30ff0); /* function */ 

c_0xe307ad66(0xc66f2b7c38c941404cdb697ef37e30d3ff6eb78422e807caf997928213978d2f); /* line */ 
        c_0xe307ad66(0x077db7fccc2ca80d784cdc1c3df54aa4f52398d98edac242a4617d84b4f3926e); /* statement */ 
return MyPoolz[msg.sender];
    }

    function GetPoolData(uint256 _id)
        public
        view
        isPoolValid(_id)
        returns (
            uint64,
            uint256,
            address,
            address
        )
    {c_0xe307ad66(0x6e71a5a0a78454aac1466b164bc9596fd64d3ac64bec5ef5b32090144bf2aa67); /* function */ 

c_0xe307ad66(0x9590c9a907b10dc5cd1585ea31e4f23e6f6ee03f939fdf087e4a11ed232c3f2c); /* line */ 
        c_0xe307ad66(0x0a2e6786861cea4737ba146cad4811e9cbd675311d5b40d15ed244e39477b87a); /* statement */ 
Pool storage pool = AllPoolz[_id];
c_0xe307ad66(0x6ed834efb60baed565a711690c7f65328f87d60e4a26e9eb4d969c3f92e31ec1); /* line */ 
        c_0xe307ad66(0xa80857d884ebfea461ed327d3eaa6f832daefafedb724cc8b44decfbea808c85); /* requirePre */ 
c_0xe307ad66(0x87c8a7663309f7f4c9985879d4f87065656ad3d5df7ee9d42ac3ff3f12219ef9); /* statement */ 
require(pool.Owner == msg.sender || pool.Allowance[msg.sender] > 0, "Private Information");c_0xe307ad66(0xb56f0345498effb397f0dbdabc56c523d3f8c3564d3fcb67a47dc899dcb3bb68); /* requirePost */ 

c_0xe307ad66(0xe8d9d17b3e24b2f81ff1c3557baa34ae3438031a2936c3280bdb21868cef37d0); /* line */ 
        c_0xe307ad66(0xb35e9ab39851af0456549da409b7230a1c3f00f8e2b106a9e4b35a14ef3f6092); /* statement */ 
return (
            AllPoolz[_id].UnlockTime,
            AllPoolz[_id].Amount,
            AllPoolz[_id].Owner,
            AllPoolz[_id].Token
        );
    }
}
