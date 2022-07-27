// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x3d91de83(bytes32 c__0x3d91de83) pure {}


import "poolz-helper-v2/contracts/interfaces/IWhiteList.sol";
import "poolz-helper-v2/contracts/FeeBaseHelper.sol";
import "./LockedDealEvents.sol";
import "./LockedDealModifiers.sol";

contract LockedManageable is FeeBaseHelper, LockedDealEvents, LockedDealModifiers {
function c_0xaf4bc561(bytes32 c__0xaf4bc561) internal pure {}

    constructor() {c_0xaf4bc561(0xcccebf86da4eccfd7c9692a5fe15bdabad02b2facd2d83e1a39a0f3e46c8bd04); /* function */ 

c_0xaf4bc561(0x267985053ebbce783f1d5d7bf32ac0a2bd0752500e07dd86625aa1a736137ba9); /* line */ 
        c_0xaf4bc561(0xb237ddcee2924e85679baab19adfb368d8b2148bc3ec27935b9aec99f5bc648a); /* statement */ 
maxTransactionLimit = 400;
c_0xaf4bc561(0x76d7adde700d43e5ab2cc0ecde094fa3f31194c704530a34cd5843debbcb7bae); /* line */ 
        c_0xaf4bc561(0x549cbcb3faea4fbb5846bdd1a254c911b59077f6fd19df0e62017c17fbfa0998); /* statement */ 
isTokenFilterOn = false; // disable token filter whitelist
    }

    function setWhiteListAddress(address _address) external onlyOwner {c_0xaf4bc561(0x4b0e56f53742f65760b0307f60e17b704d4c036af8b38aa3b48ad3fb9e53ee0f); /* function */ 

c_0xaf4bc561(0x742f2ed1da979b5d59006fdfa4d777c413ef2c178bf8be552e37a9ce724fce9c); /* line */ 
        c_0xaf4bc561(0xa543a3d12030072e4c90bfbc533bf1619d184423e00e1ce15bcae991422bf4d0); /* statement */ 
WhiteList_Address = _address;
    }

    function setTokenFeeWhiteListId(uint256 _id) external onlyOwner {c_0xaf4bc561(0xbbb9271c948e9fb04a66882f018d0bbb6442ffa59da28a04eae7e7963e6d7cfb); /* function */ 

c_0xaf4bc561(0x8202db3ce7a0ddc4373393a26cfa76f1c300b07555e20136613f11b59b434792); /* line */ 
        c_0xaf4bc561(0xf54fda3eac3663e05b0af7724436c577d509267ce49e30a4bed615a37f911d80); /* statement */ 
TokenFeeWhiteListId = _id;
    }

    function setTokenFilterWhiteListId(uint256 _id) external onlyOwner {c_0xaf4bc561(0xc08563585b6f4cf666d42c5ea22ebbbe14ad31c5f0bda8f3e7fb117aed881790); /* function */ 

c_0xaf4bc561(0xe62887a5878b942e52d8f10c2316f98105a8a2303c45495d547cfa9b531ebf21); /* line */ 
        c_0xaf4bc561(0xdeaac630caa54649a909cc923c1283d6a0f5b904f173d4a1475ad39fb1b3ae8b); /* statement */ 
TokenFilterWhiteListId = _id;
    }

    function setUserWhiteListId(uint256 _id) external onlyOwner {c_0xaf4bc561(0x05b03f46b7ac3c6b5df8c002abfb5710037eea2baa8ed967044d225fc4c74dbe); /* function */ 

c_0xaf4bc561(0xe6f6b06586722536511364c2c413c58ee552938c0e3ca2017541df0eb4e35313); /* line */ 
        c_0xaf4bc561(0xd3ecfe596520466d626c2fe4d62acee63a372de2ca9e57f3d86a1eecc54b0ab8); /* statement */ 
UserWhiteListId = _id;
    }

    function swapTokenFilter() external onlyOwner {c_0xaf4bc561(0x01dc21777c0ab7330beedbbc12d3e8b49afcfb6c4fd8ba4f7302bc31e341a9f6); /* function */ 

c_0xaf4bc561(0x4e255779620753149f59feda44d47b3a7ab70d77575d4a83c109d317f511d08a); /* line */ 
        c_0xaf4bc561(0x841c08ba028cc136ff46f14d742c8df9c6e1e14d5e1c8a8ae3a14db2829e1376); /* statement */ 
isTokenFilterOn = !isTokenFilterOn;
    }

    function isTokenWithoutFee(address _tokenAddress) notZeroAddress(WhiteList_Address) public view returns(bool) {c_0xaf4bc561(0x43d53595dbff22e5887cd11fbff087a93339f46cd5c54420cb9a241cb03ca2be); /* function */ 

c_0xaf4bc561(0xaeed2531db02de503f5fbea621da10b2fea8f95cd80b9eb4d3b4697c1c70a935); /* line */ 
        c_0xaf4bc561(0x9e884925adba5e978fc0d28811c11ddbe8c120f306960a92a81959c2ed94d558); /* statement */ 
return IWhiteList(WhiteList_Address).Check(_tokenAddress, TokenFeeWhiteListId) > 0;
    }

    function isTokenWhiteListed(address _tokenAddress) public view returns(bool) {c_0xaf4bc561(0xe668229ff86b8b0ddbf0998762885e5aabb1c6976da526be0c2885238a97fb9c); /* function */ 

c_0xaf4bc561(0x0f7b09fead9c1112aefb17af3fdeab2eca26a1d167c1e4492942700dd6742939); /* line */ 
        c_0xaf4bc561(0xf5e253b67a4ce8727d4c45c85e72ebe8c10fe93ecd7d3540c49436902dfdd8d8); /* statement */ 
return !isTokenFilterOn || IWhiteList(WhiteList_Address).Check(_tokenAddress, TokenFilterWhiteListId) > 0;
    }

    function isUserWithoutFee(address _UserAddress) notZeroAddress(WhiteList_Address) public view returns(bool) {c_0xaf4bc561(0xacd1aa7f42bf0bff8d999cb525e602abb00143983342e0c6422bec0586c45884); /* function */ 

c_0xaf4bc561(0x9e4932d055512a275ab511e5a22a2cd0745a95ad746ae8980984ce8339080e8d); /* line */ 
        c_0xaf4bc561(0xc71418912d909e9c09cd0bdb03826243a36f05f972bb2f2c74b85306fb73441b); /* statement */ 
return IWhiteList(WhiteList_Address).Check(_UserAddress, UserWhiteListId) > 0;
    }

    function setMaxTransactionLimit(uint256 _newLimit) external onlyOwner{c_0xaf4bc561(0x5dd6853b08b5dff963ec6dea902cf494f49d439d3d3893e35ca195b0600e3833); /* function */ 

c_0xaf4bc561(0x79c1b47eaae6e1546530e9976682efa143c024ef731d67b1adbd089fa68c647e); /* line */ 
        c_0xaf4bc561(0xa35e732229085554da6cca571d00dcf89e4bf874bc6f654f134701139d566b5d); /* statement */ 
maxTransactionLimit = _newLimit;
    }
}
