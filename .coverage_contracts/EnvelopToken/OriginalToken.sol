// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";

/**
* @title TestToken is a basic ERC20 Token
*/
contract OriginalToken is ERC20, Ownable{
function c_0x82c74c1c(bytes32 c__0x82c74c1c) internal pure {}


    /**
    * @dev assign totalSupply to account creating this contract
    */
    
    constructor(string memory _TokenName, string memory _TokenSymbol) ERC20(_TokenName, _TokenSymbol) public {c_0x82c74c1c(0x2f3f0ad967f591aa8c59b5225b7f4a4ec7683a5fdaa8c6c2afa5e1a66fbb8ce7); /* function */ 

c_0x82c74c1c(0xe594b9f8586496ec780cad3b4c8912be62e00be67f42e5063c4fdee9a9f6a24a); /* line */ 
        c_0x82c74c1c(0xf4815133760622ebca44d1a12a4d01746b4477b0ffe246fdf213fd93a041a777); /* statement */ 
_setupDecimals(18);
c_0x82c74c1c(0xac31e18ae367188289a9c9e40d5af6e700d7d025ac03694abc85b48d831130e2); /* line */ 
        c_0x82c74c1c(0xc779a3828874395f78447e7c1014385f328d1ed41a9276f8f2cd04c27c6b1e01); /* statement */ 
_mint(msg.sender, 10000 * 10**18);

    }
    
    function FreeTest () public {c_0x82c74c1c(0x15c6c701dabad8ccd770cc364abd8db888ff97166825e981e30d2cc2d933879d); /* function */ 

c_0x82c74c1c(0x6f2b437b3232f3932d3e76c6f5f517b4573e2f32a894fffcfc66344c5046d91c); /* line */ 
        c_0x82c74c1c(0x5875d9896b8cc4e755f6035deb67cd8d4cae4507db5fe5637981c8aae8742962); /* statement */ 
_mint(msg.sender, 10000 * 10**18);
    }
}
