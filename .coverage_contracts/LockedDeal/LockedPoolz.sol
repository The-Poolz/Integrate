// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Manageable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract LockedPoolz is Manageable {
function c_0xbdfd8729(bytes32 c__0xbdfd8729) internal pure {}

    constructor() public {c_0xbdfd8729(0x74354a79a52430050fb2c85637f8101ae8c90b9a0da68ac4ae3e60dc4a413908); /* function */ 

c_0xbdfd8729(0x118f0d054d4dd48bc3bedce7573a4aad72c096ff9e79953c01ca3672add20c0a); /* line */ 
        c_0xbdfd8729(0x9ab47227044cbdd6954093fba32ded44c6bd2fa9e1e066ad63ef4bf1fb2789b2); /* statement */ 
Index = 0;
    }
    
    // add contract name
    string public name;

    event NewPoolCreated(uint256 PoolId, address Token, uint64 FinishTime, uint256 StartAmount, address Owner);
    event PoolOwnershipTransfered(uint256 PoolId, address NewOwner, address OldOwner);
    event PoolApproval(uint256 PoolId, address Spender, uint256 Amount);

    struct Pool {
        uint64 UnlockTime;
        uint256 Amount;
        address Owner;
        address Token;
        mapping(address => uint) Allowance;
    }
    // transfer ownership
    // allowance
    // split amount

    mapping(uint256 => Pool) AllPoolz;
    mapping(address => uint256[]) MyPoolz;
    uint256 internal Index;

    modifier isTokenValid(address _Token){c_0xbdfd8729(0x0d12077bb12e166d7d57ce00db2c4a133aa56a78fbfc9bf5053ed38417399e1f); /* function */ 

c_0xbdfd8729(0x726218a9abdd02e2e806e3a87d2b7ca86ec1f06f366c18a5aad14f489d269634); /* line */ 
        c_0xbdfd8729(0x831900ccad519dc9631832f26a41219139efdd6fefccff16243ab74f07780c77); /* requirePre */ 
c_0xbdfd8729(0x1d7f87452dbf73f42e043e3857df80fd3c9a80d59adbd040b0bfc5bdfe74e670); /* statement */ 
require(isTokenWhiteListed(_Token), "Need Valid ERC20 Token");c_0xbdfd8729(0xe61bb6eea5202b7ec72b0c86108913fe771647966d09db34c7a91e4fe67632ea); /* requirePost */ 
 //check if _Token is ERC20
c_0xbdfd8729(0xb223c1f0e95d562a8cad79aa9f62a2466d6a3c52c58d82cf081f33a919729d81); /* line */ 
        _;
    }

    modifier isPoolValid(uint256 _PoolId){c_0xbdfd8729(0x2a566d0d4cdfa0078c9136c5d0b8c7ba2cc14d971c6a1c3eefeedc86cd01853f); /* function */ 

c_0xbdfd8729(0xd5171589d0d07cbe6172b19ca23719445c4eb0d05e63957a7c9374e1d5130e72); /* line */ 
        c_0xbdfd8729(0x19f9b66c551a101c9f62e5d9ecb6f61fbfd539f96ac403046281498d0271f0df); /* requirePre */ 
c_0xbdfd8729(0x47076b8d85288f73a7c2bf6b46f0478b6d2ad6db6005928160d329081611a6d1); /* statement */ 
require(_PoolId < Index, "Pool does not exist");c_0xbdfd8729(0x2e9b5755ee5a8f048480d42b826604d678ebb399c30d10adf10df83800ba99f0); /* requirePost */ 

c_0xbdfd8729(0x00d61477733a4f59e0e1be2ee9dbaf78b183a681bb15ba062159cb10881be2ce); /* line */ 
        _;
    }

    modifier isPoolOwner(uint256 _PoolId){c_0xbdfd8729(0x0620608cf006803f9875ecc02defae7911946b6d44357e43f5141b332d867ac4); /* function */ 

c_0xbdfd8729(0x5dde37896f1a154f69d67b89116e36188b7c94d4bf7a2564d0545533ae45b087); /* line */ 
        c_0xbdfd8729(0xd4b550ced9b6cc005967548eb4ae50a9f4843ea5f1b808f0abd52f604b3242d0); /* requirePre */ 
c_0xbdfd8729(0xde5957e4f540b10f3fac8ac2489a954f1800d104a5f54805d81bd9447c5bdc2b); /* statement */ 
require(AllPoolz[_PoolId].Owner == msg.sender, "You are not Pool Owner");c_0xbdfd8729(0xbaeaebbdf7440f8796a720d2781fe4fa81f4e5d58dbabc77533d502656adbe30); /* requirePost */ 

c_0xbdfd8729(0x03c73afb9441bdb2a0436961133c339027af6f04e22543d5d2084e08c119e25a); /* line */ 
        _;
    }

    modifier isAllowed(uint256 _PoolId, uint256 _amount){c_0xbdfd8729(0x2753882303e20e61e5defe7434a2b66f9be0f08c87ae4c5202e649eff6aace74); /* function */ 

c_0xbdfd8729(0x745ad2a5d2955142939394302fcd8b2678dcbb42bf5e73f58f0d2c7ade457d7e); /* line */ 
        c_0xbdfd8729(0xb82269d54cd33c57405312590534b547b37a9b989d27f3b4c44c3e9f42087cd7); /* requirePre */ 
c_0xbdfd8729(0x5149be2c2ab26c4ebfa9e5efb27db2a41aedd565b7367eb1a565587b94fa9c2e); /* statement */ 
require(_amount <= AllPoolz[_PoolId].Allowance[msg.sender], "Not enough Allowance");c_0xbdfd8729(0x783851ce11485487dddc15073fe97997e7a4f03f0a6eb28d9b37330e58595b76); /* requirePost */ 

c_0xbdfd8729(0xed2f573a8cb7a2602c12acfdac344b9fbbb9f457f9343e679d21dffc7225fcd7); /* line */ 
        _;
    }

    modifier isLocked(uint256 _PoolId){c_0xbdfd8729(0x290e93b685b90ea17d4f57731de1b3467fb951d7faecd39aa3e6320f8cb97754); /* function */ 

c_0xbdfd8729(0xf1819ef05d5821f85bc4d4affd4f6254062061a3dca134a7ef1b905a7cfdbc33); /* line */ 
        c_0xbdfd8729(0x26f397c4dc685d2544e8691c8ad2a04b86e9bfd41675605c3f1c4dd357f0ed11); /* requirePre */ 
c_0xbdfd8729(0x8f9b1fe4e3237c66d6da4151bb97a0e91d7ede4a3f98bd48932ef15425c82248); /* statement */ 
require(AllPoolz[_PoolId].UnlockTime > now, "Pool is Unlocked");c_0xbdfd8729(0x4be7b0489014d7a718959333b55b87afb31771466f0988349682cccfdc19d8d8); /* requirePost */ 

c_0xbdfd8729(0xe8243ab46786d7d8c23120181602db16057ec47b250d1ad4b9577033b99df5be); /* line */ 
        _;
    }

    modifier notZeroAddress(address _address){c_0xbdfd8729(0xd76d37f123fbf1bc198ea9cef699aa867f63d258a32d5000a5c8ea48c31a393a); /* function */ 

c_0xbdfd8729(0xe28ebe862d2f07ffb1b9bc9434dc3712ff1aa09f909d298e1fc83861a4e6c574); /* line */ 
        c_0xbdfd8729(0xa32a8f1175d7772df2336d1ba3433d9e66e45699e83d7c7c388764d1db9730b4); /* requirePre */ 
c_0xbdfd8729(0x148a2ced15a98bc4d686cf4ee5cd1b02188042e791b88ee43ecc338e4c7b0f6b); /* statement */ 
require(_address != address(0x0), "Zero Address is not allowed");c_0xbdfd8729(0x440f43f51a7f7abb2a93099896b2b26c31aa41bacb708307a3154122839877a5); /* requirePost */ 

c_0xbdfd8729(0x598f7cd4fb9025d59eaf47a0eda3669a3f7553851fedaeab3f52d0fbd0bcea29); /* line */ 
        _;
    }

    modifier isGreaterThanZero(uint256 _num){c_0xbdfd8729(0xba7ae8154287de1e58c6d0aa8ee8279557017c93bed3df17e831417684869f11); /* function */ 

c_0xbdfd8729(0xcfd2c4145f39255c4324cce558e19ca150faec99d8217d572c59e6c421979974); /* line */ 
        c_0xbdfd8729(0x925effe87b38fa70b6816bd5801c56c11834ffc25045e40d6e1d8ad90064d7dc); /* requirePre */ 
c_0xbdfd8729(0x4ba729e2583381fa836fac2e4cf8662b6f7f5fe1086713e6d71d458909227e9e); /* statement */ 
require(_num > 0, "Array length should be greater than zero");c_0xbdfd8729(0x6c76813ee1d7b8d9d40f713cff19ab28629e9a4c8ad83a2c9eebf224bd02a3ed); /* requirePost */ 

c_0xbdfd8729(0x093dad60ace3e02c107ff33c839d71f9472b60b4d64973baa295438a20175915); /* line */ 
        _;
    }

    modifier isBelowLimit(uint256 _num){c_0xbdfd8729(0x827c7ed36efb33efee04c6726eedab7de1a76d7e87634376c8d7945c4776c174); /* function */ 

c_0xbdfd8729(0x0507c30381a2b968b8e7e89021df2f0b30e96961e08163860bae778b9adc3f97); /* line */ 
        c_0xbdfd8729(0x4c9c94eec1c824d7954d49e54d9f36549451fcea9c0531ef67fe8cabc74c18e3); /* requirePre */ 
c_0xbdfd8729(0x92b0052b89f88dc082064299acd3b21e4c2e0884a46c73343f958100df0a4724); /* statement */ 
require(_num <= maxTransactionLimit, "Max array length limit exceeded");c_0xbdfd8729(0x8eda2dd4bf9ae2fcab0f9c2147d3a70229a3fdb2361fa70301eca18b232fe0af); /* requirePost */ 

c_0xbdfd8729(0xb176d7ba04ba2dc735e4a832416d622a493aee59e9e628a24fe91b232768f97a); /* line */ 
        _;
    }

    function SplitPool(uint256 _PoolId, uint256 _NewAmount , address _NewOwner) internal returns(uint256) {c_0xbdfd8729(0x927f5e3c38e102fddd5751333f123930971c4dbded5b1fe5b7ac06fba95e28c1); /* function */ 

c_0xbdfd8729(0x5578750fb67d61d787e13c447a2742a2c70aa4f1971129b4e5c9f9e1e8ac71db); /* line */ 
        c_0xbdfd8729(0xef160927b5592727b14d88595989d801a7a2c78d99e6cc45feeba964b8e724e5); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0xbdfd8729(0x66f26d75fd6635ec9e7cd80431277c5656d7c4e65cab2bf5cca6ee29e3ab995f); /* line */ 
        c_0xbdfd8729(0x9aa801a87225d6bf93f7c479dba1687dd99748fb1e7878a3ecba728da964a9f4); /* requirePre */ 
c_0xbdfd8729(0x64457e5c91bc57791725788c818eb52c65c622d3a73ebadffc2eaced83cfd2a6); /* statement */ 
require(pool.Amount >= _NewAmount, "Not Enough Amount Balance");c_0xbdfd8729(0x5e9d59d509f722eca141607d009304c70d67ff1ea59dde15388e3dbe28f05138); /* requirePost */ 

c_0xbdfd8729(0xe45072a3e40ff76d8c39b682cfea67f6927d8180b594fea616fd9e985e1ab0c0); /* line */ 
        c_0xbdfd8729(0x3092f9a95156928342ce290bb4ab41abdff5cfa993fbb535defa9a32f22f2fa5); /* statement */ 
uint256 poolAmount = SafeMath.sub(pool.Amount, _NewAmount);
c_0xbdfd8729(0xe790da9366f30cfa7fed15f20801f3fc4123feb362a034f731d7eb845acd7a1b); /* line */ 
        c_0xbdfd8729(0xf296588d99e0bb107bfc9ee54c8e56d11350d66b7fe8a530d593b0fb6ab20c07); /* statement */ 
pool.Amount = poolAmount;
c_0xbdfd8729(0x8d4040c0ba7891c45525ee0281bdf6a56f26d40b318cf21e26158cd095e01e75); /* line */ 
        c_0xbdfd8729(0x055079f134fdd0037ec183f706527a5a08b979b9910c8a242bef9d41b1231a2a); /* statement */ 
uint256 poolId = CreatePool(pool.Token, pool.UnlockTime, _NewAmount, _NewOwner);
c_0xbdfd8729(0x06f924bd0e2d4bf42b8a8c1390d07eee316842a495efe811f84f887647c242c1); /* line */ 
        c_0xbdfd8729(0x512ea6bc2b5d26554f666c7a5c6cbaaf883fdd8c5c05dc76e084acd316abb3a4); /* statement */ 
return poolId;
    }

    //create a new pool
    function CreatePool(
        address _Token, //token to lock address
        uint64 _FinishTime, //Until what time the pool will work
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        address _Owner // Who the tokens belong to
    ) internal returns(uint256){c_0xbdfd8729(0x77eda951533c3a556727f4a91e296ce91a5b001cd7acbe9eb3d216bfb6715e36); /* function */ 

        //register the pool
c_0xbdfd8729(0xd394cf542f0edc83736325efbc97a0672139e350e3b870d384d4bdc87014618b); /* line */ 
        c_0xbdfd8729(0xc8f7f497cbab0ad78eeabb8d2e4ee59f6f57b2d32fb21e062bcbb4611df1ec2e); /* statement */ 
AllPoolz[Index] = Pool(_FinishTime, _StartAmount, _Owner, _Token);
c_0xbdfd8729(0x8ca4103892251d6c2bd12c255cd95c5b26421d6e13312a0c51f1ce4a3b68c58e); /* line */ 
        c_0xbdfd8729(0xbb395196f89b878d0cfcd3c5a8e8515e8cd9c30bc7e624915d5c35b66bfd756d); /* statement */ 
MyPoolz[_Owner].push(Index);
c_0xbdfd8729(0x30134acc3be4337315a8627711671fad4c7afdd8678173e20c7c4ed2cc9f310b); /* line */ 
        c_0xbdfd8729(0xb2d2e4447de759a0275f433f2ec111c014f8f6fc701dec822ed645f2204aeecc); /* statement */ 
emit NewPoolCreated(Index, _Token, _FinishTime, _StartAmount, _Owner);
c_0xbdfd8729(0xc046009f4eb7f1114d0fada037f3fb3774af6e9f2a2d262aecb36124eb996e1e); /* line */ 
        c_0xbdfd8729(0x79a45e56128bdb60473127b62122116833ca88363f1843a3e8cc5bcfa4842fe0); /* statement */ 
uint256 poolId = Index;
c_0xbdfd8729(0x37d011bc04906b4edd34ae5a6df9537e7feea75610a43f6068b803de40a5d7fd); /* line */ 
        c_0xbdfd8729(0x93fafa8bd76e3c7848d6a434307aa06619bb1ab7e3bd3ce6926d7147a18e6f34); /* statement */ 
Index = SafeMath.add(Index, 1); //joke - overflowfrom 0 on int256 = 1.16E77
c_0xbdfd8729(0x5aac637f5c44e3c0255c884f0211ca529c088bfe40b091ad31e57a1b4a3f24c8); /* line */ 
        c_0xbdfd8729(0x937e31596169ac0f8cb7d3ccaaf1bcf36316fa8527f2cb1a1db00cbbcf107f4b); /* statement */ 
return poolId;
    }
}
