// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "poolz-helper/contracts/ERC20Helper.sol";
import "poolz-helper/contracts/PozBenefit.sol";
import "poolz-helper/contracts/ETHHelper.sol";
// import "poolz-helper/contracts/GovManager.sol";
import "poolz-helper/contracts/IWhiteList.sol";

import "openzeppelin-solidity/contracts/utils/Pausable.sol";

contract Manageable is ETHHelper, ERC20Helper, PozBenefit, Pausable  {
function c_0x9ca5ce18(bytes32 c__0x9ca5ce18) internal pure {}

    constructor() public {c_0x9ca5ce18(0xb3206cf6ec1112e0368d586945cef9dfbbb640ea8ec24063b42bc976766393ac); /* function */ 

c_0x9ca5ce18(0x7181f8366ed32226e4e5cf9f5917303e872db5e66d456a1ef91bd56f8b96717a); /* line */ 
        c_0x9ca5ce18(0x9b7dfb1cbda97bad1370f00d9e80da4ba6f38fa4f645f4f405035d048bdfaeda); /* statement */ 
Fee = 20; // *10000
        //MinDuration = 0; //need to set
        //PoolPrice = 0; // Price for create a pool
c_0x9ca5ce18(0x8a3374914d212340437f9cdee9eddbb56567258364f31d1a9c05eeb88aee68f8); /* line */ 
        c_0x9ca5ce18(0x85970d46279e1c2d1e5f275f33446165568175832b29691b29549732f1f305e9); /* statement */ 
MaxDuration = 60 * 60 * 24 * 30 * 6; // half year
c_0x9ca5ce18(0x7e3cbfb949eadf7baf081b64ee2d48300e6654eb68382619756c8c5579e59b86); /* line */ 
        c_0x9ca5ce18(0xb35b508ece9231b138552709daf1855006796c28369a678a86c8a95f1e7c1d65); /* statement */ 
MinETHInvest = 10000; // for percent calc
c_0x9ca5ce18(0xf6a6189f40dc260d5bbcfb429a3d2d622d23a90a7ae6ec3cb62e5388338fe3bd); /* line */ 
        c_0x9ca5ce18(0x17bfffde501e984b43d40d897ddfd983b7c60375e9cdfa57a20c560524d131ef); /* statement */ 
MaxETHInvest = 100 * 10**18; // 100 eth per wallet
        //WhiteList_Address = address(0x0);
    }

    mapping(address => uint256) FeeMap;
    //@dev for percent use uint16
    uint256 public Fee; //the fee for the pool
    uint256 public MinDuration; //the minimum duration of a pool, in seconds
    uint256 public MaxDuration; //the maximum duration of a pool from the creation, in seconds
    uint256 public PoolPrice;
    uint256 public MinETHInvest;
    uint256 public MaxETHInvest;
    uint256 public MinERC20Invest;
    uint256 public MaxERC20Invest;
    address public WhiteList_Address; //The address of the Whitelist contract
    address public Benefit_Address;

    bool public IsTokenFilterOn;
    uint256 public TokenWhitelistId;
    uint256 public MCWhitelistId; // Main Coin WhiteList ID

    address public LockedDealAddress;
    bool public UseLockedDealForTlp;

    function SwapTokenFilter() public onlyOwner {c_0x9ca5ce18(0x1095b7d6e3113b8d4ffc01aa4b34d32f6609889cfcdce1eb2a0da23c1a4cf21a); /* function */ 

c_0x9ca5ce18(0xc58f2343bfe2498135b12949ab800e2bc151f65f4ee07e94119aeef5bfeb162c); /* line */ 
        c_0x9ca5ce18(0xf8e1ef0133a1ce64b213eb634d7bcb1f03d7ed7a3bbb4c7cede7feff7af7c5c3); /* statement */ 
IsTokenFilterOn = !IsTokenFilterOn;
    }

    function setTokenWhitelistId(uint256 _whiteListId) external onlyOwnerOrGov{c_0x9ca5ce18(0x12c93ddefaf15f567dbf3d7a5962fe7693e41058e689d623c6f07b42de694421); /* function */ 

c_0x9ca5ce18(0x732673ddd5de05b0d91b9f26380084d426e9a57008809d86a935924372b3f6f8); /* line */ 
        c_0x9ca5ce18(0xa3f4342499e977eab96adf9c78d4c8e69efdd7580290c1931f52d38ea38bf554); /* statement */ 
TokenWhitelistId = _whiteListId;
    }

    function setMCWhitelistId(uint256 _whiteListId) external onlyOwnerOrGov{c_0x9ca5ce18(0x5e3b31558686d2b150c3307ddfbb056bb3ed3207f5790d22e3da190c7737e7dd); /* function */ 

c_0x9ca5ce18(0xf840f70bdea921926e2e667ae92976ecf8b425e893e45afd2affd5c943631cbf); /* line */ 
        c_0x9ca5ce18(0xf5b4dd0b3242664b325db1e6916c8e9cf20e3a40310d1d04ba1bbea77d6947c1); /* statement */ 
MCWhitelistId = _whiteListId;
    }

    function IsValidToken(address _address) public view returns (bool) {c_0x9ca5ce18(0xf621272e28893111bbf4140cee14fdaf17c9708d36772b03ec3214a3e75f0e3b); /* function */ 

c_0x9ca5ce18(0xa61bd0bc9598dfe6ef6b664d8030170ee553d52f9940a4d2b52ca0313bc96b29); /* line */ 
        c_0x9ca5ce18(0x36304571292b4fcd60bb08375e16c996067540510cb5a2333f3393245266eba8); /* statement */ 
return !IsTokenFilterOn || (IWhiteList(WhiteList_Address).Check(_address, TokenWhitelistId) > 0);
    }

    function IsERC20Maincoin(address _address) public view returns (bool) {c_0x9ca5ce18(0x57b2d0c6d3370d30e686d54c40941d7c629738694ffbd6d10e85c51a0a943150); /* function */ 

c_0x9ca5ce18(0xcdb4715034132df99c8c219ed9c6c50c8eec4fcec8ce336f455d46e656a86080); /* line */ 
        c_0x9ca5ce18(0x41555f70c112f7ee5bcc5545c6c941aa5fab1297604e9c1c8ee6432eacd6780d); /* statement */ 
return !IsTokenFilterOn || IWhiteList(WhiteList_Address).Check(_address, MCWhitelistId) > 0;
    }
    
    function SetWhiteList_Address(address _WhiteList_Address) public onlyOwnerOrGov {c_0x9ca5ce18(0x19a34ce35c6a56a97f7ac506d3efdf1f82e170fe9f064d1edf33d8c7ca82b2ac); /* function */ 

c_0x9ca5ce18(0xbc2295cf081e0fc94829a2b9bce4a92644ff7970b863ceacc1e55160fcf51462); /* line */ 
        c_0x9ca5ce18(0x0c07665f565e020fc90c107c4a9b4c1becb609a3905bd961fa1bd8e10d3ae18b); /* statement */ 
WhiteList_Address = _WhiteList_Address;
    }

    function SetBenefit_Address(address _benefitAddress) public onlyOwnerOrGov {c_0x9ca5ce18(0x174be4f8a8f5b76e234b4a83cb88f464dfb53f7c12e87c4d134fcbb837c30378); /* function */ 

c_0x9ca5ce18(0xf49a9822251041fc8201f7454ce5abe09c7a4160f9a6ee07898ae3dad33ebaac); /* line */ 
        c_0x9ca5ce18(0x382901ab2be4249ac99c94ca62042ff356ff1056e3ef0d7edfbc32f958e94dc3); /* statement */ 
Benefit_Address = _benefitAddress;
    }

    function SetMinMaxETHInvest(uint256 _MinETHInvest, uint256 _MaxETHInvest)
        public
        onlyOwnerOrGov
    {c_0x9ca5ce18(0x5d25746dbb5824c82d5189cbc86e8fb125b1ddc8a939b68fe7a72b928884fdf1); /* function */ 

c_0x9ca5ce18(0x724e7ef037c2e901148a177210263e532d9d46abd4f3dcf53c7398d3ef8a23bc); /* line */ 
        c_0x9ca5ce18(0x959d501e48f2d74da0125ab71b4cb065b03c20d615454f7aa1f45c6f4126c965); /* statement */ 
MinETHInvest = _MinETHInvest;
c_0x9ca5ce18(0xeed0aa59df15529e0a3806a842aa03c3712d17fc34844bd2cf3a5575fccd9888); /* line */ 
        c_0x9ca5ce18(0x6592f65f39095762ee6bd8947309e71aa7c6fc57086b5d025d6a1946193c5113); /* statement */ 
MaxETHInvest = _MaxETHInvest;
    }
    function SetMinMaxERC20Invest(uint256 _MinERC20Invest, uint256 _MaxERC20Invest)
        public
        onlyOwnerOrGov
    {c_0x9ca5ce18(0x8e39fa67a556717148e26411b54cca2f5181d5ef1597782d3eba9be5d8d147de); /* function */ 

c_0x9ca5ce18(0x5a41b23eb41487307713b61289f83a2a2019c6af3bcd90d0a7aeaec3aedff1e3); /* line */ 
        c_0x9ca5ce18(0x2841f922cda6c08d82caf3066ae02a0e09f5bdace2aea7b6153af1fe82b9da6e); /* statement */ 
MinERC20Invest = _MinERC20Invest;
c_0x9ca5ce18(0xc41bad00f8a5a0436d7f8f5a2adba39e2dbddf1e01eb7e9aa413a9df8f0dcb02); /* line */ 
        c_0x9ca5ce18(0x4b7fcc1876f7cbadd4b7796aed6f52ad7314f3040b2c445e44cd11d6ed72ec63); /* statement */ 
MaxERC20Invest = _MaxERC20Invest;
    }

    function SetMinMaxDuration(uint256 _minDuration, uint256 _maxDuration)
        public
        onlyOwnerOrGov
    {c_0x9ca5ce18(0x0e2379935021f48fb25895969ec5029050312210c5a8547438d0b954f96a6eec); /* function */ 

c_0x9ca5ce18(0x669c2f8ee81279b14062c13fa062b4611343ca1040d7b94bce0c20b0edb2320e); /* line */ 
        c_0x9ca5ce18(0x218dda014f03c1bb80bc3b1ddd60778d2d11b4affa4c101b352a1c9f769e27d4); /* statement */ 
MinDuration = _minDuration;
c_0x9ca5ce18(0x3e1dff4a09b94e8390bfce32c2ac5d8d4b3512773a70384c0a48be1281faa38d); /* line */ 
        c_0x9ca5ce18(0xdee2c7baf86abdd9055af470b71139a02df77df396b5d01befc2cd874767a0f4); /* statement */ 
MaxDuration = _maxDuration;
    }

    function SetPoolPrice(uint256 _PoolPrice) public onlyOwnerOrGov {c_0x9ca5ce18(0xc2b8dd634755718aa56125d617e30e94d979feddeb5931838717d11feee982fc); /* function */ 

c_0x9ca5ce18(0xcaa03a1042948d4ea4de4ecea6948ec53412936bad4f1890af2da0fc8e31036e); /* line */ 
        c_0x9ca5ce18(0xf1a10d42a75f26a530659661f4436318c16abe3d273e42bde5c59d60b8ab0646); /* statement */ 
PoolPrice = _PoolPrice;
    }

    function SetFee(uint256 _fee)
        public
        onlyOwnerOrGov
        PercentCheckOk(_fee)
        LeftIsBigger(_fee, PozFee)
    {c_0x9ca5ce18(0x9df49698b482f2967234690a331c99e3aa33889b1d701c70b06b4b05a72f4562); /* function */ 

c_0x9ca5ce18(0xe90654af2ffc3f460eabebbc82f6cdad1ba4976266b166e03e3e441077bc4e7e); /* line */ 
        c_0x9ca5ce18(0x954787f9fd3f1e2be10d0a4d1733df41eaca795407419bfb301e76b3be04fb84); /* statement */ 
Fee = _fee;
    }

    function SetPOZFee(uint256 _fee)
        public
        onlyOwnerOrGov
        PercentCheckOk(_fee)
        LeftIsBigger(Fee, _fee)
    {c_0x9ca5ce18(0xf43c44411c66ffe1bb258510e76e387d2cc6ca1714d273242e5ec0073201a190); /* function */ 

c_0x9ca5ce18(0x3e1a923954ca7dcfabd9522180cdbb7cf523880b640746afcbb36bf2d366c821); /* line */ 
        c_0x9ca5ce18(0xc79ab7f354135286f22606596a761925fc2b5ba371d6071123cfe23ac7d0079a); /* statement */ 
PozFee = _fee;
    }

    function SetLockedDealAddress(address lockedDeal) public onlyOwnerOrGov {c_0x9ca5ce18(0xacf85242ebc9205d549f4dd05841ec2d83f89979b0df2b669edc7922f68e7cd2); /* function */ 

c_0x9ca5ce18(0x0fe8ec80b0261cdefd489e491358a4effbb659adb86fbd5548bca9452973ce5b); /* line */ 
        c_0x9ca5ce18(0x5cbf6f33ff2d09a829b3fc94fd5549d991c8c0ebc999fd382ff4ab38bf0fa9ce); /* statement */ 
LockedDealAddress = lockedDeal;
    }

    function SwitchLockedDealForTlp() public onlyOwnerOrGov {c_0x9ca5ce18(0x845022c1bb7b57a352590f6ad0611c9e2e98fa494bd12620735930a0dc616504); /* function */ 

c_0x9ca5ce18(0x41e9b8400f90dc5e23d078ca4ee9f3149bddb05b93bc37769e6b348515b8a9b7); /* line */ 
        c_0x9ca5ce18(0x81f9248fb4e7bbf493a819c6fcbb09028b8e8a385a7d6ebed35f5ead763d743f); /* statement */ 
UseLockedDealForTlp = !UseLockedDealForTlp;
    }

    function isUsingLockedDeal() public view returns(bool) {c_0x9ca5ce18(0xc70f80f9d0360fc84884568adfda5cd119bf1782e675d2dbd3058efb367a5a95); /* function */ 

c_0x9ca5ce18(0x269a868e61bbc08384ac861766362b55b80ee64b8daeb6adeb1474b35b2aa1b7); /* line */ 
        c_0x9ca5ce18(0xd6b30a6649d7e2067e35d7440de1513469298bdf936f2ba270834d6f2d3765fc); /* statement */ 
return UseLockedDealForTlp && LockedDealAddress != address(0x0);
    }

    function pause() public onlyOwnerOrGov {c_0x9ca5ce18(0x3bf4c9e346d947143547ab8867bc003a467789581f7fd10a01aa672cb340025e); /* function */ 

c_0x9ca5ce18(0x57d6ea56b922e54bce83a2282a319777d7d0d55f09f05971b84d60ece7b60023); /* line */ 
        c_0x9ca5ce18(0x222f150404d9bb5cbdc948efd4d8e78963af5b63d57a83d9f2b9044d8176c698); /* statement */ 
_pause();
    }

    function unpause() public onlyOwnerOrGov {c_0x9ca5ce18(0x0ee039f2e554f395ecbe4d9e656143af4435e1a53909e7f83a141620d445584a); /* function */ 

c_0x9ca5ce18(0x6de9084851d73a092e3fecd8baeab0fd10d48bd510712c2d8a6b7179a790348c); /* line */ 
        c_0x9ca5ce18(0x06cd6ffbae7c6cac27ab9594f1d77141aaf357a37a34a189df92412b9796cdc6); /* statement */ 
_unpause();
    }
    
}
