// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./InvestorData.sol";

contract ThePoolz is InvestorData {
function c_0x5b95a608(bytes32 c__0x5b95a608) internal pure {}

    constructor() public {c_0x5b95a608(0xa698b1d79a7b6e767d18faa55ad06cf652f151fb4036da888055a4dbf5cd595e); /* function */ 
    }

    function WithdrawETHFee(address payable _to) public onlyOwner {c_0x5b95a608(0x9159fdc0b05d670e440f7e8aba37553e6d79011d7813be1079e6cd0de8ee63b4); /* function */ 

c_0x5b95a608(0x309c59fb5da2a65a57767c438b0258470f1ab6380e9178ceda8c6c1c9ebdd745); /* line */ 
        c_0x5b95a608(0x2870c8620fe8708c833e7301affb82e6c34e48d777ceb6d59191506ac8ea7b39); /* statement */ 
_to.transfer(address(this).balance); // keeps only fee eth on contract //To Do need to take 16% to burn!!!
    }

    function WithdrawERC20Fee(address _Token, address _to) public onlyOwner {c_0x5b95a608(0xe08a8c00d19488ef01c2f9f7a928b57d26a2cbe9e5de37259368715490573640); /* function */ 

c_0x5b95a608(0x22db5b1347a9e3c7fd8276d1315b1dc03028b6855c51ca06c8b4d4d732ebaa9c); /* line */ 
        c_0x5b95a608(0x42f1afc776104791d63e4f1b8e1279099ec37bf11a83ad7abd55e5cfb2f98b0f); /* statement */ 
uint256 temp = FeeMap[_Token];
c_0x5b95a608(0xb917c20bf16894240f4f441f42df5cff87f6ee601f962241c4b3ffbfbcaaa533); /* line */ 
        c_0x5b95a608(0xb85c6a335650d8fbe1f9864e04c9f047ccd67cdf3623446fc43980977224477e); /* statement */ 
FeeMap[_Token] = 0;
c_0x5b95a608(0x5c99c15f1d404e729d0b93e959864e64ff4d5dde0150b9712e52767d0c11002e); /* line */ 
        c_0x5b95a608(0xdef23a551d3621ba495fc3127413d8f4597415e8bdc5beeeb6eb0dd662e5c368); /* statement */ 
TransferToken(_Token, _to, temp);
    }
    
}