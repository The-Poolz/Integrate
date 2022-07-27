// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "poolz-helper/contracts/ERC20Helper.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "poolz-helper/contracts/GovManager.sol";
import "poolz-helper/contracts/IWhiteList.sol";

contract Manageable is ERC20Helper, GovManager{
function c_0xb5231aa3(bytes32 c__0xb5231aa3) internal pure {}


    event LockingDetails(address TokenAddress, uint256 Amount, uint8 TotalUnlocks, uint256 FinishTime);

    address public OriginalTokenAddress;
    address public LockedDealAddress;

    address public WhitelistAddress;
    uint256 public WhitelistId;

    uint256 public FinishTime;

    struct lockDetails {
        uint64 unlockTime;
        uint ratio;
    }

    mapping(uint8 => lockDetails) public LockDetails;

    uint8 public totalUnlocks;
    uint public totalOfRatios;

    modifier tokenReady(bool status) {c_0xb5231aa3(0xf20a5b3dd6131deb6a801ef5077239ea33bff37548ca0f30dbe7b4651e70608e); /* function */ 

c_0xb5231aa3(0xe32cabbdd7f86f966951c3e0ec5cda74581f482678e7599f662ee09d5397d9a1); /* line */ 
        c_0xb5231aa3(0xe114d745722ce8df0c3cb78339a5e77ec1eef12f8b743a1bcf842f61d834152a); /* requirePre */ 
c_0xb5231aa3(0x0685bcfddfcfa66a6c8b1f76c197fc2eab4017e987a9cb617bea11a8b4dd36ad); /* statement */ 
require(status ? totalUnlocks != 0 : totalUnlocks == 0, "Unlock Data status error");c_0xb5231aa3(0x0b956b2e06e14a818e8dbb7561729ac0afa8837beaa3d61b6df6270284963c1b); /* requirePost */ 

c_0xb5231aa3(0xf2ed2ea733a8e773076026337fc3f9a59eba5d7261bf8edb4e6d0c40eef325e8); /* line */ 
        _;
    }

    function _SetLockingDetails(
        address _tokenAddress,
        uint256 _amount,
        uint64[] memory _unlockTimes,
        uint8[] memory _ratios,
        uint256 _finishTime
    ) internal tokenReady(false) {c_0xb5231aa3(0xcc02c4fb8282302b48bd2138dc00621d35d0255839f9ab710c268b2cabd81969); /* function */ 

c_0xb5231aa3(0x142e7b53a7fa1aed85577a03ac674d60034ab7715bf0f1cef7a1b6591554f000); /* line */ 
        c_0xb5231aa3(0xcba42fc3ca8232058d2390d0beaaed44195fe1206c768fd21016a45834edc2d1); /* requirePre */ 
c_0xb5231aa3(0x4c8fe4830e0e52ea4f45e83d7730141532370bdd518d58b4cfb2ed6faa7aac6f); /* statement */ 
require(_unlockTimes.length == _ratios.length, "Both arrays should have same length.");c_0xb5231aa3(0x499393e2029b416ccddbd6bffdc4e0d0f0a0c5065c4a843ed71a31efcd1b0c98); /* requirePost */ 

c_0xb5231aa3(0xa956867ad096300918df7c707010acecd0227fb440b4780ef6de61deb5dc0967); /* line */ 
        c_0xb5231aa3(0x4a6cc99d8f9a59c86eb90a604aac81c9fc7815a1fc7b3bb3dd2e277c7c4f949c); /* requirePre */ 
c_0xb5231aa3(0xde7db68011c73659badd21c438f4dd57817973d575b53ac148c3524f805a62a6); /* statement */ 
require(_unlockTimes.length > 0, "Array length should be greater than 0");c_0xb5231aa3(0x29dc474e7f9330882a1bdf4eec0cdda9407ef38a846af4db2cc7392b1774da46); /* requirePost */ 

c_0xb5231aa3(0xf2b723c1dd3f73fc2ebe51292fe72c2262d98666a2fac7b4203fa276e0c7cf42); /* line */ 
        c_0xb5231aa3(0x5e4c4d0dee999e773addbeb06c18877ebe1e43f40886a79c448fc23f3f1bb015); /* statement */ 
OriginalTokenAddress = _tokenAddress;
c_0xb5231aa3(0x71ad29f927026e3cdbbcfa90a3626ee35c96f4ef11b25bf03e1365eaae7bbfb5); /* line */ 
        c_0xb5231aa3(0x3d90591782c56e683a329ed8706b18e8ba1ce1f41b314e89b68e6bf3251dbdcd); /* statement */ 
TransferInToken(_tokenAddress, msg.sender, _amount);
c_0xb5231aa3(0x5672877cea2eb48d2ef4b35a43c1628e0eaecc9fa984d7617bc4569d8cd0fd54); /* line */ 
        c_0xb5231aa3(0xa86b262a68aad1c06533f7487b512b4afa6287f2a9fcb5d4a7dbde00debb8087); /* statement */ 
for(uint8 i=0; i<_unlockTimes.length ; i++){
c_0xb5231aa3(0xb8ea4f163f464cd4b86d577cf730176c2281e851cfc129e920abda055c635d81); /* line */ 
            c_0xb5231aa3(0x430688ac0b0bfaf456f81fbd1487891c4edc06b8a8b32913dbdd0f8e11314397); /* statement */ 
LockDetails[i] = lockDetails(_unlockTimes[i], _ratios[i]);
c_0xb5231aa3(0x10afd2a0eae23dbefdb7c6a532bd21d91f16fac41d2baecc07be18aae361fcf6); /* line */ 
            c_0xb5231aa3(0x800c590bc0af4e9ba124586e06f2eaf2d4c903bf932f564d8d1ec59b34e10f3b); /* statement */ 
totalOfRatios = SafeMath.add(totalOfRatios, _ratios[i]);
        }
c_0xb5231aa3(0xc229c00e6dc22a6384e0761bbc8a4a73fdff7d159840c8e2a2a919f446f61e73); /* line */ 
        c_0xb5231aa3(0x94e9d8aeb7929d996977a206731de2973e07247ca38b4f9f91cd1123bf55bd8a); /* statement */ 
totalUnlocks = uint8(_unlockTimes.length);
c_0xb5231aa3(0xbeaf8199d767c178866ebc6f41a78b9cf8bf1bb80dc832a923cd14fecc51eac8); /* line */ 
        c_0xb5231aa3(0x33f55754f01770d6f57177df4f332f2c4304d46be381f8aede8a32fc787afed5); /* statement */ 
FinishTime = _finishTime;
c_0xb5231aa3(0x166fb1f29d73018f7411ef03444cc45d617b2ddf758fe7b8423c97eecdad829b); /* line */ 
        c_0xb5231aa3(0x5cec6dc0c977b88facb37254bb004ec67df06687e6264402a74826bab2130aec); /* statement */ 
emit LockingDetails(_tokenAddress, _amount, totalUnlocks, _finishTime);
    }

    function _SetLockedDealAddress(address lockedDeal) internal onlyOwnerOrGov {c_0xb5231aa3(0xfc02b9216406aec7cf1f891e0cba0cf79fae6ba01ee5880d99e27ec4f082a3ad); /* function */ 

c_0xb5231aa3(0xb2e7e669d194b0cb12183bef7d9622db067f362c9d05f8ff55f794e28a74e0c6); /* line */ 
        c_0xb5231aa3(0x90fdbb5a0f3da55ddbf8939a4b07e3a29c66fe0587b770d85d3bdffc492efceb); /* statement */ 
LockedDealAddress = lockedDeal;
    }

    function _SetupWhitelist(address _whitelistAddress, uint256 _whitelistId) internal onlyOwnerOrGov {c_0xb5231aa3(0xe4721f1cda92f19da708d0c49a124698ba9f6728244441a89a41d72f0d3f0e6e); /* function */ 

c_0xb5231aa3(0xc7ebe7c901664c160296176ddf8e84a878ea300c44b4e9a11082cc78ba84fe98); /* line */ 
        c_0xb5231aa3(0x56179aed1be2b5b88d417861259105b9d7034429981410a00c0aeee52157cbdf); /* statement */ 
WhitelistAddress = _whitelistAddress;
c_0xb5231aa3(0xae5634f81b9506f1dbe709cec1f9f68b59c81b8b4bfef4ced93cab7bf59bfb14); /* line */ 
        c_0xb5231aa3(0xf7f827d72e02517699b8a4e5969190bcaa13622874bedfd81781f9450fac2272); /* statement */ 
WhitelistId = _whitelistId;
    }

    function registerWhitelist(address _address, uint256 _amount) internal returns(bool) {c_0xb5231aa3(0xfc6938ad8f370d19bb4b0473902c0e77b1acef2f6c0625c04402e74c67b75f03); /* function */ 

c_0xb5231aa3(0x41226916bab9cc954a7f0dcee849b92c6ff712328a23d6cf0e8be99b99699bb6); /* line */ 
        c_0xb5231aa3(0x4b00c51a6687ae81856b94a34b919ba0ad5fc4cbdde73a637bc042e6d10f57f9); /* statement */ 
if (WhitelistId == 0) {c_0xb5231aa3(0x06e2947c04d24c63d18e30a88a68cc73e132fcf888b82e47120276df48596b3c); /* statement */ 
c_0xb5231aa3(0x4a0578098d562d3fabb91ca3babf897e8e7da1214fca602c4a76cdaaf68105a1); /* branch */ 
return true;}else { c_0xb5231aa3(0xd88ccfcdfd1327298328b7e5dc78698fec766f037daa5830ffc32dd5f9c6172f); /* branch */ 
} //turn-off
c_0xb5231aa3(0x50c1bd9914e4e2a732b9aef8ddcaabe404df5431539d8f2a8011a16f4e07a20d); /* line */ 
        c_0xb5231aa3(0x230c8f7c5e031232667c5219f4602e8bcc289035657187ca8ccada653bd8fe05); /* statement */ 
IWhiteList(WhitelistAddress).Register(_address, WhitelistId, _amount);
c_0xb5231aa3(0xa604b30e50d82519ee1b1443eb44c622e7f776af20af45633f5ff9276c49f317); /* line */ 
        c_0xb5231aa3(0x7a557792f0597faeb7d405034ffcce203c8b145420fa7d781f9b28a71c98477f); /* statement */ 
return true;
    }

}