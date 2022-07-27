// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "poolz-helper/contracts/ERC20Helper.sol";
import "poolz-helper/contracts/PozBenefit.sol";
import "poolz-helper/contracts/ETHHelper.sol";
import "poolz-helper/contracts/IWhiteList.sol";

contract Manageable is ETHHelper, ERC20Helper, PozBenefit {
function c_0x91c97668(bytes32 c__0x91c97668) internal pure {}

    constructor() public {c_0x91c97668(0x76b184d76f83ad40bf8e4d6c02ae258f814ccc83cf2d1dfb02a6ea155c1275a1); /* function */ 

c_0x91c97668(0xaf00f2911dadcac7599327682a63c1b332dd7015fe31455af63ba59797d13008); /* line */ 
        c_0x91c97668(0xc9a57437164878826857b403a5662a5b76ead3cc6b81ced894d25db5bb38f60b); /* statement */ 
Fee = 20; // *10000
c_0x91c97668(0x398bd1b6bd8d92b42d51f96a0433f6e66ff382a17b124c4685c54a608f03a8e8); /* line */ 
        c_0x91c97668(0xcd459039755762fa78ae99724b916fbf929f9a2be4aa150d2b06cba73ecf9429); /* statement */ 
MinDuration = 0; //need to set
c_0x91c97668(0xedf1b4ea8d17f52b38c51c6d7d3968261b6a5304e0d46e93173ebc83cd5f14ce); /* line */ 
        c_0x91c97668(0x2b54c422f068b8a4b6f0cddee8d3ecc3e299b14bbb2e31dec6e7a754caaf7d94); /* statement */ 
maxTransactionLimit = 400;
    }
    mapping (address => uint256) FeeMap;
    //@dev for percent use uint16
    uint16 internal Fee; //the fee for the pool
    uint16 internal MinDuration; //the minimum duration of a pool, in seconds

    address public WhiteList_Address;
    bool public isTokenFilterOn;
    uint public WhiteListId;
    uint256 public maxTransactionLimit;
    
    function setWhiteListAddress(address _address) external onlyOwner{c_0x91c97668(0x85d5ebdb736c6a6db2fef8d8d7c053c3082e6b6a87dba61e372db61d5560f231); /* function */ 

c_0x91c97668(0xe18a577ce8493f4eca078090b7de5783031a5a0e769f376ef6aac65578a53ae8); /* line */ 
        c_0x91c97668(0xa59c35263ae711268b450184a59b7b80fc0fd48070fc5a77420a0574e1b88c56); /* statement */ 
WhiteList_Address = _address;
    }

    function setWhiteListId(uint256 _id) external onlyOwner{c_0x91c97668(0xe9b5eb3b3fc3bc2bda205bbe126fa531003844b561d5702b024347a30cad6c92); /* function */ 

c_0x91c97668(0xe95d31e4e0ec5497ab682c18718c186134fb2c591905d436259de11e8d65472a); /* line */ 
        c_0x91c97668(0xcf101b697a01cd8d1b94478cce2a8ea5677caac502aba4b8375857c45f5304ca); /* statement */ 
WhiteListId= _id;
    }

    function swapTokenFilter() external onlyOwner{c_0x91c97668(0x911377f0bbd707cd9cf4b4e8fb70b5bfe5dd88fe556fdecd23470b69083985ad); /* function */ 

c_0x91c97668(0xa84bb346d373c5b7810851cecd03ae01009fb25797683531edb6e21c7a681b15); /* line */ 
        c_0x91c97668(0x06f8b39ee41963ee1d82ae411d37db7d62e0dab6a2d1e067e9a9151e2c305c6d); /* statement */ 
isTokenFilterOn = !isTokenFilterOn;
    }

    function isTokenWhiteListed(address _tokenAddress) public view returns(bool) {c_0x91c97668(0xd6d7e020948dff3291bbb3b34eb477e04fea126a1d0d5f69c91c1272bda3ad55); /* function */ 

c_0x91c97668(0xafcf800faafd2ee51e3e6c0c7218c5ceb880d480278fe18b74b00922176b44af); /* line */ 
        c_0x91c97668(0x7b09b9390de40c0cea827533cb135ab67e0e76906cd23e0d9ba2ae254a5c1331); /* statement */ 
return !isTokenFilterOn || IWhiteList(WhiteList_Address).Check(_tokenAddress, WhiteListId) > 0;
    }

    function setMaxTransactionLimit(uint256 _newLimit) external onlyOwner{c_0x91c97668(0xb1985c5c098caa71ba97a00ae8f183a3467782d0c0e4f909559fb13e8235c185); /* function */ 

c_0x91c97668(0xf477c32269e0567f81405611e7bb00bb1b023fa25b9287e5b3381e6c46118617); /* line */ 
        c_0x91c97668(0x67a1f59b33f6b66aec69cc73a088ccca6efb9bd8bb6813eaebd5424c37948821); /* statement */ 
maxTransactionLimit = _newLimit;
    }

    function GetMinDuration() public view returns (uint16) {c_0x91c97668(0x402f673e2a8d95ce552c08f86c017663c0e2809dabb5c2af083fb53a4011f2b0); /* function */ 

c_0x91c97668(0x1ccd5986ac814234b484e43c50c2fec976e26bd04eb09a87b45b435933703193); /* line */ 
        c_0x91c97668(0x104f2486c967458d9386ce2abffca2dbe18c167e00a73eda1db41fd05f2eae2f); /* statement */ 
return MinDuration;
    }

    function SetMinDuration(uint16 _minDuration) public onlyOwner {c_0x91c97668(0x85a63af153159962987f37bc49100ccaad8f0e9736aa3446fdc60983a414def7); /* function */ 

c_0x91c97668(0x567e01e72423dd3b304ce6d46c433f427a1febe3fca9084e324f411e3480ac6a); /* line */ 
        c_0x91c97668(0xdf4b0968f2912df6e807f9fc43e5534675096ca4d997c853bae4879050c6bb50); /* statement */ 
MinDuration = _minDuration;
    }

    function GetFee() public view returns (uint16) {c_0x91c97668(0x1839fe69392b653141d02b6c5a8aa05f02f27deb67beda3edfe34619d4bf7832); /* function */ 

c_0x91c97668(0x47c5cc70922fd01cdb0486a74d7eb504243da2fc2584a894bc7dd8a6e8d4f749); /* line */ 
        c_0x91c97668(0xee69eedfcc44e589feac7dd44179260ea69cd9db9e2a7a8513828dc8338cf359); /* statement */ 
return Fee;
    }

    function SetFee(uint16 _fee) public onlyOwner
        PercentCheckOk(_fee)
        LeftIsBigger( _fee, PozFee) {c_0x91c97668(0x2aea9ca02544f32840d8b8840c09cd56103bd3e2480dec699faad23fd0b8fec9); /* function */ 

c_0x91c97668(0x2219ae0445d6e93465de5f123d8c2321525888e43e967f74e73fb4474003094d); /* line */ 
        c_0x91c97668(0x55530060a4c070b15504e788a596e4a5bf9d87e688ca512c91f9bc998746f80b); /* statement */ 
Fee = _fee;
    }

    function SetPOZFee(uint16 _fee)
        public
        onlyOwner
        PercentCheckOk(_fee)
        LeftIsBigger( Fee,_fee)
    {c_0x91c97668(0x026b43b8b2f721879b640514b2b832c37355de4bd581ef049184ea3852dacd6a); /* function */ 

c_0x91c97668(0x9fd35017d1eedf7dfae74c56ef56371ef5258daf161ea4fdaaf43ffe6c378d84); /* line */ 
        c_0x91c97668(0x9467fab0fbb26f5802209794b1437d02fa4bedff23b608136d19964e8336121a); /* statement */ 
PozFee = _fee;
    }

    function WithdrawETHFee(address payable _to) public onlyOwner {c_0x91c97668(0xfcfdd8db0d96a79aa57c6960ec1e632df4834972e97cd8c9483d57917dfe5b9e); /* function */ 

c_0x91c97668(0xaa3a91c3a538762cbbbed4aa5dd13a7d61581fa2b2d325a07b5d1571d2687162); /* line */ 
        c_0x91c97668(0x11b6467ae4659c8aaef0bc8dd1987d468e6900ed8476a44fbee4b8923acbf9f2); /* statement */ 
_to.transfer(address(this).balance); // keeps only fee eth on contract //To Do need to take 16% to burn!!!
    }

    function WithdrawERC20Fee(address _Token, address _to) public onlyOwner {c_0x91c97668(0xf28d3ed6717c770361a8226503ec5a741c3567c392554c68e7a8d1048d5e00c3); /* function */ 
    
c_0x91c97668(0x95cafb2bc9ac7198a784b1b116f983e4d1ce64cb5cf2f1aea3a8adc04f7eec4a); /* line */ 
        c_0x91c97668(0xca1dd8c7ab4638c8c033754235751c52d03fb6e51ba5a41167492e5bb36843c1); /* statement */ 
ERC20(_Token).transfer(_to, FeeMap[_Token]);
c_0x91c97668(0x313d41f037eaa1338e3e5721833fa0998863620d5dc1d36f4a97ed6190e845c1); /* line */ 
        c_0x91c97668(0xf3008307666453198b539ea7a44a8406b3c9182a793051352a429fb24b7a15f2); /* statement */ 
FeeMap[_Token] = 0 ;
    }
}
