// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x826bb63c(bytes32 c__0x826bb63c) pure {}


contract WhiteListHelper{
function c_0xd7a785ff(bytes32 c__0xd7a785ff) internal pure {}

    event NewWhiteList(uint _WhiteListCount, address _creator, address _contract, uint _changeUntil);

    modifier OnlyCreator(uint256 _Id) {c_0xd7a785ff(0x4a2fadc744cc82e2961406ebd99eb7b1577a6c883a1ad57a751a20eff1108b83); /* function */ 

c_0xd7a785ff(0xded586c239407e3750a2988e16784994d06aa6537434ea2348b7037f4a6ebad1); /* line */ 
        c_0xd7a785ff(0x25b97ce949a43f2636a21342e84a14644fcfc3fe0d1058bddbea17cc20af705a); /* requirePre */ 
c_0xd7a785ff(0x1b017c7fe7b5a09d48b825146b3962af42eed151b8623858cdc9a45e3e1e4367); /* statement */ 
require(
            WhitelistSettings[_Id].Creator == msg.sender,
            "Only creator can access"
        );c_0xd7a785ff(0x11699126983d6320880f1d6fe3ca6554c668c75219d58d165c1b4b87106aed51); /* requirePost */ 

c_0xd7a785ff(0xfa419daa15a08e3a9fcbfd6e943ee612e3a5927606505e0ac8afdffe25eb5087); /* line */ 
        _;
    }

    modifier TimeRemaining(uint256 _Id){c_0xd7a785ff(0xae1344eae94a2028a2a73077303bf426a697ec674a243930cd01d5ea7ec95251); /* function */ 

c_0xd7a785ff(0x8fb5b49c9de988e1257f192cda0a5fb4eb5641a207b71edba80edeaa3fea6f43); /* line */ 
        c_0xd7a785ff(0xf934ab2e90b935b149fd82e6a3191c4fd326fc088dd1835b80391c5fece2b031); /* requirePre */ 
c_0xd7a785ff(0xbe81debf8071fa6c80352571233385251867317245a3584c38afc2745a03243c); /* statement */ 
require(
            block.timestamp < WhitelistSettings[_Id].ChangeUntil,
            "Time for edit is finished"
        );c_0xd7a785ff(0x0516d7c455796ba24591ece026064d8d213c139a139ee835d75e69e7234daffe); /* requirePost */ 

c_0xd7a785ff(0x7dea3146e23dc0aa92c020065a2c85f2731a162d79fdfb3fe877a8baa4640601); /* line */ 
        _;
    }

    modifier ValidateId(uint256 _Id){c_0xd7a785ff(0xd25647dfe787cc960f38966595ed6979345c08bee00894fe153338f044bb122a); /* function */ 

c_0xd7a785ff(0xbf12e14b19f92dcbe6929c5caf2dbe3653cc9fdff14b887b23daebd8ec566d56); /* line */ 
        c_0xd7a785ff(0x1c08bda9b7d0bff43a69c782dc3455ae53c9b491713e0d63ee0adc88f7ba8ed7); /* requirePre */ 
c_0xd7a785ff(0xf6224f15444530a2f166a7f16034c21b4054ffc6de619fd61ccd9035b9893c81); /* statement */ 
require(_Id < WhiteListCount, "Wrong ID");c_0xd7a785ff(0x571e6c61247cac7dbf18f36a03f0cbebb3280e55b9575e8c83654330df11ac9f); /* requirePost */ 

c_0xd7a785ff(0xf4cd95bdc35a35c5d669b06ab19bd3fbbec9783cfecb606c92039e1bdbb9bb70); /* line */ 
        _;
    }

    struct WhiteListItem {
        // uint256 Limit;
        address Creator;
        uint256 ChangeUntil;
        //uint256 DrawLimit;
        //uint256 SignUpPrice;
        address Contract;
        // mapping(address => uint256) WhiteListDB;
        bool isReady; // defualt false | true after first address is added
    }

    mapping(uint256 => mapping(address => uint256)) public WhitelistDB;
    mapping(uint256 => WhiteListItem) public WhitelistSettings;
    uint256 public WhiteListCost;
    uint256 public WhiteListCount;

    function _AddAddress(uint256 _Id, address user, uint amount) internal {c_0xd7a785ff(0xe23e40e0a960595ba2a4644b7e5a218364c5468b6aa7ac51b21c7f9eed7fae4e); /* function */ 

c_0xd7a785ff(0x64dd113290d33b984d7c32d546d743fb0fa48c65b8b71e2751fa44d13146ae69); /* line */ 
        c_0xd7a785ff(0xc8c10d7e7e746fc26e94bc998d2ae1108c8798498afa2786440c2f25009b6247); /* statement */ 
WhitelistDB[_Id][user] = amount;
    }

    function _RemoveAddress(uint256 _Id, address user) internal {c_0xd7a785ff(0x19b183a0d4125e8d3f6607e95b03c3015491b1a30410972ac21b7ed02851bacd); /* function */ 

c_0xd7a785ff(0x45b20a29135e3f305332761a1b43669b03ba2f5c9b24b3e79f0ca56ef1b7bd91); /* line */ 
        c_0xd7a785ff(0x10befa94ee7fbf81c1e19cd1b68d2b749fc92d35f0a3712fbf03beb196f156b4); /* statement */ 
WhitelistDB[_Id][user] = 0;
    }

    function isWhiteListReady(uint256 _Id) external view returns(bool){c_0xd7a785ff(0x43e4431550f9d589437282ff407627bf6578b3f9025dab34688a41f13917d16d); /* function */ 

c_0xd7a785ff(0xab2a0aaa0df75136f59affcf2beb817fe6f7d43ad6c5565faf41aacb7f3a3086); /* line */ 
        c_0xd7a785ff(0x02cef7fe29a1301c898702941502b45f90e2e9a85ce40b7fb74cb2fc76aabb46); /* statement */ 
return WhitelistSettings[_Id].isReady;
    }

    //View function to Check if address is whitelisted
    function Check(address _user, uint256 _id) external view returns(uint){c_0xd7a785ff(0x1f899586d4612e4268d3101155b4f42e8b1b65a7ea06c0e0f65c64d497a00a7e); /* function */ 

c_0xd7a785ff(0xd179d3dae2bf4394e78d81b93bbd7a77e7d81f3d16e3356f6d43305065b038d1); /* line */ 
        c_0xd7a785ff(0x6f5194173bde2174e7c97d4e6b45254c445092f273aefc26d0c5f654059a7cbb); /* statement */ 
if (_id == 0) {c_0xd7a785ff(0xd9bb9b67a3a5c85935ef7119e955c2d45eb26220507c37197de6412475062b56); /* statement */ 
c_0xd7a785ff(0xbb25409c1bd824d532d43479b9e7a102b9ff3bca347d88cf4e7598c933ec7c19); /* branch */ 
return type(uint).max;}else { c_0xd7a785ff(0x599836728d7d1b13233e230615359c2b05c5b63d35877a6ecabcaa65c12a7f88); /* branch */ 
}
c_0xd7a785ff(0x0d5153757d3087fe6f79686c662cca5cb0903d6c7f83a7e6696a963b6aec5f5b); /* line */ 
        c_0xd7a785ff(0x8de61e56b1f356fb19bddb287a97fdd8e78825ea5841c89c1d0e0e50170794e4); /* statement */ 
return WhitelistDB[_id][_user];
    }
}