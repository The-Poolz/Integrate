// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Invest.sol";

contract InvestorData is Invest {
function c_0x2741f4cc(bytes32 c__0x2741f4cc) internal pure {}

    
    //Give all the id's of the investment  by sender address
    function GetMyInvestmentIds() public view returns (uint256[] memory) {c_0x2741f4cc(0x03e9d0b13d2d26c30f461f607fc57e96ed79130ae2f798e813909fc86d959e72); /* function */ 

c_0x2741f4cc(0x46be76e4d85e7186723a6c6d8ea825e4c38e80a86ef591f3fc43ea7f1cea160e); /* line */ 
        c_0x2741f4cc(0x8c0c9db78afbe56c97f0776ed418abeb6fe534fc1edd894810a005e8e5d9c5c2); /* statement */ 
return InvestorsMap[msg.sender];
    }

    function GetInvestmentData(uint256 _id)
        public
        view
        returns (
            uint256,
            address,
            uint256,
            uint256
        )
    {c_0x2741f4cc(0xdaa8ebd4194bf23653f63fa780e3aa2c8c27ece2a1bab230b6cd27254ad762a1); /* function */ 

c_0x2741f4cc(0xb4aaf7b4405b7ee9f8c5ac8512b951b9c1d4c5236d18fd7f09579025fe1f57d1); /* line */ 
        c_0x2741f4cc(0x99e59596bfb2abdf2454de147b151321b6e817d8f9b66d2a6a195db06b134014); /* statement */ 
return (
            Investors[_id].Poolid,
            Investors[_id].InvestorAddress,
            Investors[_id].MainCoin,
            Investors[_id].InvestTime
        );
    }
}
