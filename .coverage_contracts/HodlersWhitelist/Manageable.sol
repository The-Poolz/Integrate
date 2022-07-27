// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "poolz-helper/contracts/GovManager.sol";

contract Manageable is GovManager {
function c_0xf992b905(bytes32 c__0xf992b905) internal pure {}

    event NewWhiteList(uint _WhitelistId, address _creator, uint _changeUntil);

    modifier OnlyCreator(uint256 _Id) {c_0xf992b905(0xaadd746b96e5f352fcdb13ebab765b32201aedf1214929b316437ca9d09caeae); /* function */ 

c_0xf992b905(0x15a45aa14bc91c6dfe358e48ff4302f8f22fc1fcfdaebfc931aa171a0c8202fa); /* line */ 
        c_0xf992b905(0x005a71aa88f5ced497ee7114192ebb1deb145838987457b6b86039025f19519d); /* requirePre */ 
c_0xf992b905(0xc71845eb8280fed9211b999ef5b5c90ab894a5599eff17013b0fb738172d5860); /* statement */ 
require(
            WhitelistSettings[_Id].Creator == msg.sender,
            "Only creator can access"
        );c_0xf992b905(0xcf4b9e63f5162d3d7984ddd01779003cb91f1d4ddc8aecd871d97056b35d6dca); /* requirePost */ 

c_0xf992b905(0x0841650eaddbcfaf9ddb9274507d669d0f219e95b9c96e805a205b2d64a3aff9); /* line */ 
        _;
    }

    modifier TimeRemaining(uint256 _Id){c_0xf992b905(0x2e16469ed0c30a0fb7543ccf028dc53612b956ebd2b1cd0cd22ee44ceec62012); /* function */ 

c_0xf992b905(0x03930ad60a71a8ee64b2e6b7377a7e19fc22457868a3f5133943dfe618b34498); /* line */ 
        c_0xf992b905(0x0798ff62dea3449b4d38c48e34ff989672f48b2b19316376ac712cc9501c8fec); /* requirePre */ 
c_0xf992b905(0xe7fcd44e335d7901bb7efbf806fbd909bec8f98e88e09797794d40a486f5c380); /* statement */ 
require(
            now < WhitelistSettings[_Id].ChangeUntil,
            "Time for edit is finished"
        );c_0xf992b905(0xbaf72e43802e2cfc0ba5daea63054cfc7af734c07fa853c173fed25f4db60585); /* requirePost */ 

c_0xf992b905(0xb8e2294e0c842f797478cd40b4f9c1d5adb3e4e381524734a0d0b250a8d04d5c); /* line */ 
        _;
    }

    modifier ValidateId(uint256 _Id){c_0xf992b905(0x793452737a52847cd269b016eaed8189c7fa0985dcc08b755e2503d8f7e87393); /* function */ 

c_0xf992b905(0x070ededc4448812d5cd3c8b9c1b1ac91b4164939de3dda08c52c13156c6fbd96); /* line */ 
        c_0xf992b905(0xd9413df11006ceed26ca68f2ffcd932945e49845079a95cb0b09b3b226e77178); /* requirePre */ 
c_0xf992b905(0x437f227595c33bdcaf5784310456f3a95da785562c58eeae9ff687f078ed7bcc); /* statement */ 
require(_Id < WhiteListCount, "Wrong ID");c_0xf992b905(0xf3d94cf02e9a8b782eb00735f5c54b9662b61a439bf3e26d3b6944c9a2023c7e); /* requirePost */ 

c_0xf992b905(0xe2936c74aebed87c3a49a31535ba424488e1831ce8a8a5109b72014b725ac21d); /* line */ 
        _;
    }

    struct WhiteListItem {
        address Creator;
        uint256 ChangeUntil;
        bool isReady; // defualt false | true after first address is added
    }

    mapping(uint256 => mapping(address => bool)) public WhitelistDB;
    mapping(uint256 => WhiteListItem) public WhitelistSettings;
    uint256 public WhiteListCount;
    uint256 public MainWhitelistId;

    function SetMainWhitelistId(uint256 _Id) external onlyOwnerOrGov {c_0xf992b905(0x6b066dd366634c4e396b336f6231b12d97eee3f2993e19c6b285ed65be249c68); /* function */ 

c_0xf992b905(0x3c650d0e0c6cc56566e32a34b6bb5aa95862ac4803273700270585d54251ba25); /* line */ 
        c_0xf992b905(0x3fc9af14833579dadfb5e06e192af48f56bb49b88a340c8a9d6e3f242b0d7ab8); /* statement */ 
MainWhitelistId = _Id;
    }

    function _AddAddress(uint256 _Id, address user) internal {c_0xf992b905(0xa268cf560352fb0cacae0e2e200dbbbe2d6f6ffa4ea2f999d85532f45913599d); /* function */ 

c_0xf992b905(0xed4d5a0f362b767f63758c854cb6e16de8cce67cf4241dfb29696b5ae9edaa68); /* line */ 
        c_0xf992b905(0xb638ef543c85208d672712f84af5285b7ae0a450b9556f8287901b128df39def); /* statement */ 
WhitelistDB[_Id][user] = true;
    }

    function _RemoveAddress(uint256 _Id, address user) internal {c_0xf992b905(0xe5be8050808bc98f756ef84e50523afd1c606d881db8d52e5c3540299612e7df); /* function */ 

c_0xf992b905(0xe128f833f70cf0b48b24bc3d8aaa75ff80563ce00422d3c9dd24e90f6fa5cf8e); /* line */ 
        c_0xf992b905(0xf165bde5fee2b52ca1f62f87c2b70ab65e79c5f5ae42934b843bf58a8b9ba150); /* statement */ 
WhitelistDB[_Id][user] = false;
    }

    function isWhiteListReady(uint256 _Id) external view returns(bool){c_0xf992b905(0xed6186e86cefb755e67a2ea2609933bf77a1d28d287bf8cb3883f86d462c9379); /* function */ 

c_0xf992b905(0x355148cf84baa48de26a99585848edbe56d4d7a161d4b6714a2130c8fcbaa353); /* line */ 
        c_0xf992b905(0xcc7e3db5bca93e92da5e174c24578de78d049ec9b8150b0f410c6a89060c4141); /* statement */ 
return WhitelistSettings[_Id].isReady;
    }

    function IsPOZHolder(address _Sender) external view returns(bool){c_0xf992b905(0x32e3f23ee2e76fd5656a9d89d69a19caacea2011e3f0537db43a33e8c033076d); /* function */ 

c_0xf992b905(0x1f1eca92ec5c7fceb6b6cb2f5afedf0df0fcc4ae8a5f876eae6f113a57a46afe); /* line */ 
        c_0xf992b905(0x1b761f5217dcef25d60453525dbb3c80c497823b0657c30786e8a9073ef4ce10); /* statement */ 
return WhitelistDB[MainWhitelistId][_Sender];
    }
}