// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x0d848cab(bytes32 c__0x0d848cab) pure {}


import "poolz-helper-v2/contracts/ERC20Helper.sol";
import "poolz-helper-v2/contracts/ETHHelper.sol";
import "poolz-helper-v2/contracts/GovManager.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// FlexStakingManageable - contains all Admin settings
contract FlexStakingManageable is GovManager, ETHHelper, ERC20Helper, Pausable {
function c_0x12c089a6(bytes32 c__0x12c089a6) internal pure {}

    modifier notNullAddress(address _contract) {c_0x12c089a6(0xeeb125cb2a62accd5b6b7a492b22e9bfe951b5c7a2b6dad28707910955fcf15c); /* function */ 

c_0x12c089a6(0x78bbccde477c2889dddde4425b466ea8deb2acf285fa0a9dda8cadcaac373abc); /* line */ 
        c_0x12c089a6(0x274523e11395966ac3cdb38da5b0be28d811ef3754bdc1eea093e40db6729145); /* requirePre */ 
c_0x12c089a6(0x2a12c72a3afb8142ad6d1017664b25e87bbb0465f691d58df9a6e0318c4345f9); /* statement */ 
require(_contract != address(0), "Invalid contract address!");c_0x12c089a6(0x31f31abe1a2df8d81343c04f9d9c7b033153bc9316c8533f2298032164a884d9); /* requirePost */ 

c_0x12c089a6(0x0caf0caa8603b78cb7fb9ee8b287cadbbc76d05b9fdc48fb3d2de0f23335f3f0); /* line */ 
        _;
    }

    constructor() {c_0x12c089a6(0xcb38fb85750530bd0482c34ebc3fc8b339ea82da081bbec02e677f6c8eff72a6); /* function */ 
}

    address public LockedDealAddress;

    function SetLockedDealAddress(address lockedDeal) public onlyOwnerOrGov {c_0x12c089a6(0x22a456f8ef7d1a2c9818951b0da3bb6dbc5751088031435020058354badd63f9); /* function */ 

c_0x12c089a6(0x2e7ce31dc77377c0f3f2b39d47326922215653b2fa4444f3c9d82c096d6641de); /* line */ 
        c_0x12c089a6(0xeda4407de88eeee406a34c3796f173bc100feccfb84d30bce89871e81530fa03); /* requirePre */ 
c_0x12c089a6(0xdbed2688cac62fbe958051c9a87836b2efb67955cf1215e23338336931157c18); /* statement */ 
require(
            LockedDealAddress != lockedDeal,
            "the address of the Locked Deal has already been changed!"
        );c_0x12c089a6(0x20abd65f6f52cfd0d888964dac17220a68ea802f4a72cf68ae9279f3fc22d59f); /* requirePost */ 

c_0x12c089a6(0x123334c85e0b52e03395de26cd0a5550dc008919631c49f73b9a1073297db0b3); /* line */ 
        c_0x12c089a6(0x38b4f63806356499f2e039b24837ef0f285dbaee28db966cab690a11d5a68a6c); /* statement */ 
LockedDealAddress = lockedDeal;
    }

    function Pause() public onlyOwnerOrGov {c_0x12c089a6(0x4d06600208cd5a2f75a1d20ef46a182a8703065db0960252ee3c00df993411d2); /* function */ 

c_0x12c089a6(0xebbad81dcf23348b2554d6ea293357c7c7bb706b03c3b17de1e5cb3f5da4ec63); /* line */ 
        c_0x12c089a6(0x70f61b09917e5fba59f4efa906451955077e74bef7c09961b4f6d2219ba6c845); /* statement */ 
_pause();
    }

    function Unpause() public onlyOwnerOrGov {c_0x12c089a6(0x0fa04beaad454688f3206adfed22c946906e1277dbdc153946a68a30f7594ba7); /* function */ 

c_0x12c089a6(0x9f55271390e5fe33e7b08736d5577e2390eea61fb3c4b7003208e5ec63eeef47); /* line */ 
        c_0x12c089a6(0x3955c0e98f61ad065c4e42e5a0a43777e36924880ee30cc571432f22e27a0db8); /* statement */ 
_unpause();
    }
}
