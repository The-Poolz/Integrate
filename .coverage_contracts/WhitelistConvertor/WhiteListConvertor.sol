// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.7.0;

import "./Manageable.sol";
import "poolz-helper/contracts/IWhiteList.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WhiteListConvertor is Manageable {
function c_0x472f97af(bytes32 c__0x472f97af) internal pure {}

    using SafeMath for uint256;

    constructor(address _WhiteListAddress) public {c_0x472f97af(0xe9f274e8a26a77a8b5822365799a2f220791db1211645c122c7414afdc088736); /* function */ 

c_0x472f97af(0xb0b687f0612f5aeaf792b984e104af123694e448531d77f826d2e40aff48b641); /* line */ 
        c_0x472f97af(0xe0d644253bfd701ad3e289afd8dd2ba2c03afc90f51af9d0ecf4608d587b278a); /* statement */ 
WhiteListAddress = _WhiteListAddress;
    }

    function Register(
        address _Subject,
        uint256 _Id,
        uint256 _Amount
    ) external {c_0x472f97af(0x12efc1ac37bac7748442f9902fc6f4b0123da31bb1c28ff0a80aa723cee4cb20); /* function */ 

c_0x472f97af(0xbcfbaac4763be907027d43c13d83ebfe1a080537bea71501a7d63c15baf52b61); /* line */ 
        c_0x472f97af(0xb7796d65e6014dcdc05d6f48142ae562a73d09a31b1818ff3580362afdd3f4a1); /* requirePre */ 
c_0x472f97af(0x084fe97e5b70a61061453c5cb22237cc5c9ff0456977c8200c15f1bdb0fc7e0c); /* statement */ 
require(
            msg.sender == Identifiers[_Id].Contract,
            "Only the Contract can call this"
        );c_0x472f97af(0x25d8caba5eab7a3ba974b0bc135c6b9b3fb6d8e59b2225aa730d9f2d8a2f8301); /* requirePost */ 

c_0x472f97af(0x3e3286ac5d9b8b8768a595afe3a2498c77162aa0e46efd2445e0dcb5f75d2153); /* line */ 
        c_0x472f97af(0x17ddc2d0ef302ba4ac5329b1cd7dad36021ef91666547aec0b1792aa3c3e0f19); /* statement */ 
IWhiteList(WhiteListAddress).Register(
            _Subject,
            _Id,
            Convert(_Amount, _Id, !Identifiers[_Id].Operation)
        );
    }

    function LastRoundRegister(address _Subject, uint256 _Id) external {c_0x472f97af(0xf7deb9f2ef39806f4374cda1ba4f05195f9e41f3c82e6e9ef22dd6efb516d0ad); /* function */ 

c_0x472f97af(0xd2755bc2dcda1877b048e26a40f97c258572d83ac2d61aa31b62e01f19013630); /* line */ 
        c_0x472f97af(0x9f9e852a376dd8a030867999fa476e7b9b0caba1dac6d8a67a014e4e803f92e6); /* requirePre */ 
c_0x472f97af(0x901abfba4d6b2d91d006ccd106eca31b6d3e8f5f20ccee1bc94840df437bc824); /* statement */ 
require(
            msg.sender == Identifiers[_Id].Contract,
            "Only the Contract can call this"
        );c_0x472f97af(0xe11e838f57b39708f59ed6534852a7cbe8fd7813a213c264c83d289986357397); /* requirePost */ 

c_0x472f97af(0x7049048830691062ef0593a19e1d6e5b6bf1b29eca5140b29590e306167274c3); /* line */ 
        c_0x472f97af(0x1f2b8c7101915e033b041d88a4fa6edebfccd52adfc85903a6738817f270cd24); /* statement */ 
IWhiteList(WhiteListAddress).LastRoundRegister(_Subject, _Id);
    }

    function Check(address _Subject, uint256 _Id)
        external
        view
        returns (uint256)
    {c_0x472f97af(0x6f44ddfced2586af776eeda022c5275c847bec29ce595440659df4f350b44050); /* function */ 

c_0x472f97af(0x400fa09f90151afcf287fc5d8b88b0834e5391815eab387f99b5c0fe1c1115e4); /* line */ 
        c_0x472f97af(0x4af8491d25e921e9acc213c9544f34516e3e20b11306871a403733351fb08bd3); /* statement */ 
uint256 convertAmount = IWhiteList(WhiteListAddress).Check(
            _Subject,
            _Id
        );
c_0x472f97af(0xcb2c33422991bcd1aaef55dd5e28f0564659102db77c5e93ba59094c82122fd5); /* line */ 
        c_0x472f97af(0xc3a47060433244430701fec307fca78c937e32f4d56e206f41ad4d5280459ee3); /* statement */ 
return Convert(convertAmount, _Id, Identifiers[_Id].Operation);
    }

    function Convert(
        uint256 _AmountToConvert,
        uint256 _Id,
        bool _Operation
    ) internal view zeroAmount(Identifiers[_Id].Price) returns (uint256) {c_0x472f97af(0xb22ccb1a23a42d12d0deedca4faa378e81982b28dc880037e676ca0f9b86c319); /* function */ 

c_0x472f97af(0xb4ba12400e778e0ca5fee6430934674ec4995d04ba2f67a3c28353795b69c204); /* line */ 
        c_0x472f97af(0x6ceadeae276dac88d51de8289975998c9e2e216a03eec0f0ed813583143a829f); /* statement */ 
uint256 amount = _AmountToConvert;
c_0x472f97af(0x349a46db782ad5afb3abd6e0a1a7b7ebf7919d018e8429e81db63cecfd8bb267); /* line */ 
        c_0x472f97af(0x19e604734528fcf12251b63e774851f7974edda7c32063bd228faa95884973b6); /* statement */ 
bool operation = _Operation;
c_0x472f97af(0x7de952b041bc64735cf64fe4312a457b5dc375dc90afe14f5de363a0dc156cba); /* line */ 
        c_0x472f97af(0x3a16102674a335d92b873785f09516e75acf316074640033d78fe4c8e22837b8); /* statement */ 
uint256 price = Identifiers[_Id].Price;
c_0x472f97af(0x7709884056a4b2eb27aea5906c708ef1418f916a826013e7b2a0af5c12c5e753); /* line */ 
        c_0x472f97af(0xf74c3022a28a3231973225e45fa761ceedceb184a736b09b406b1c31a69c9649); /* statement */ 
return operation ? amount.mul(price) : amount.div(price);
    }
}
