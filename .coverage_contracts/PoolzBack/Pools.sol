// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Manageable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Pools is Manageable {
function c_0x36c080af(bytes32 c__0x36c080af) internal pure {}

    event NewPool(address token, uint256 id);
    event FinishPool(uint256 id);
    event PoolUpdate(uint256 id);

    constructor() public {c_0x36c080af(0xa69b99e589516d856832a91e2a245ba17ee3a18bcf4fa749f7284e85fc84ad38); /* function */ 

        //  poolsCount = 0; //Start with 0
    }

    uint256 public poolsCount; // the ids of the pool
    mapping(uint256 => Pool) pools; //the id of the pool with the data
    mapping(address => uint256[]) poolsMap; //the address and all of the pools id's
    struct Pool {
        PoolBaseData BaseData;
        PoolMoreData MoreData;
    }
    struct PoolBaseData {
        address Token; //the address of the erc20 toke for sale
        address Creator; //the project owner
        uint256 FinishTime; //Until what time the pool is active
        uint256 Rate; //for eth Wei, in token, by the decemal. the cost of 1 token
        uint256 POZRate; //the rate for the until OpenForAll, if the same as Rate , OpenForAll = StartTime .
        address Maincoin; // on adress.zero = ETH
        uint256 StartAmount; //The total amount of the tokens for sale
    }
    struct PoolMoreData {
        uint64 LockedUntil; // true - the investors getting the tokens after the FinishTime. false - intant deal
        uint256 Lefttokens; // the ammount of tokens left for sale
        uint256 StartTime; // the time the pool open //TODO Maybe Delete this?
        uint256 OpenForAll; // The Time that all investors can invest
        uint256 UnlockedTokens; //for locked pools
        uint256 WhiteListId; // 0 is turn off, the Id of the whitelist from the contract.
        bool TookLeftOvers; //The Creator took the left overs after the pool finished
        bool Is21DecimalRate; //If true, the rate will be rate*10^-21
    }

    function isPoolLocked(uint256 _id) public view returns(bool){c_0x36c080af(0x7083411cffe15e60430048ea94679e6e5e19177fa2fe7a8b16570951fff3c3a1); /* function */ 

c_0x36c080af(0x5efc9f0895b23e24b689a7009bd977ddd3c511537ad789970b98b83e1a4dc9d7); /* line */ 
        c_0x36c080af(0xc03e3e19121d6cc6b5571dbd499d439d0d75631252222dd1dddf8ac8ac4017ec); /* statement */ 
return pools[_id].MoreData.LockedUntil > now;
    }

    //create a new pool
    function CreatePool(
        address _Token, //token to sell address
        uint256 _FinishTime, //Until what time the pool will work
        uint256 _Rate, //the rate of the trade
        uint256 _POZRate, //the rate for POZ Holders, how much each token = main coin
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        uint64 _LockedUntil, //False = DSP or True = TLP
        address _MainCoin, // address(0x0) = ETH, address of main token
        bool _Is21Decimal, //focus the for smaller tokens.
        uint256 _Now, //Start Time - can be 0 to not change current flow
        uint256 _WhiteListId // the Id of the Whitelist contract, 0 For turn-off
    ) public payable whenNotPaused {c_0x36c080af(0x91d8c29c8103d800ae62af4ebbf4246517451ab121fa55256b67403490f674ba); /* function */ 

c_0x36c080af(0x217bab221bf11d9461aae97717cdcf2e0c69d30f796448a27933f931896112f9); /* line */ 
        c_0x36c080af(0x644dddaacb08b6d7e0bdf8aaafbb93658bc8e466253057c63135dae48ad71fc8); /* requirePre */ 
c_0x36c080af(0x21f1e0f712f2ff7938af2457505c6af18f974c59e5f5313b16023fb294eb6078); /* statement */ 
require(msg.value >= PoolPrice, "Need to pay for the pool");c_0x36c080af(0x292a66ddb2e69b50f5caab7a90669c60015120cda0793d8730075dea51c1390c); /* requirePost */ 

c_0x36c080af(0x5577a8db30a499f3c19fb2d1b79d5f620502da628b7527105cf58accfbdb7c9c); /* line */ 
        c_0x36c080af(0xee14bfb9f122e6aa8ff10d7730c717a95cea335e6850eb2e62117ea6ce6d367d); /* requirePre */ 
c_0x36c080af(0xa8a3fc17d9215e6f9bf635d7db2060267217dda89dd2e96cf344da3d94857e5f); /* statement */ 
require(IsValidToken(_Token), "Need Valid ERC20 Token");c_0x36c080af(0xb8c51f15c4f9cfb05132b1c8a9ee35a5d96bd4aaff4f755ccfa70f95efd3af7a); /* requirePost */ 
 //check if _Token is ERC20
c_0x36c080af(0x4b88de3eafec0c22b91014b12a092bfe489902c885c368e08d7bdbfa8a3be8f8); /* line */ 
        c_0x36c080af(0xefb3e33e6ebd76e7d50f00033f39baaf2b2ff8c024d9b9d50cfb1325c049f571); /* requirePre */ 
c_0x36c080af(0x8fbec5eb025f772972401c979094eaa112901efc9ebbc57918e8001fb412630e); /* statement */ 
require(
            _MainCoin == address(0x0) || IsERC20Maincoin(_MainCoin),
            "Main coin not in list"
        );c_0x36c080af(0x3cf2ff50fb3909e32980a3aa4a498c4bac23f9f67b6927d5b4184b35ffac1a1a); /* requirePost */ 

c_0x36c080af(0x8769717a9f46edfd631d59ba41e7fc2743b22c83bb4a34f484e0cd1c359c9b8a); /* line */ 
        c_0x36c080af(0x6ebe0231834f40a9c04ecd2ffb7a2a58d38cb66603bc183be915ecaa9db21fa7); /* requirePre */ 
c_0x36c080af(0x828192274d5c858326b0932095fce6d3bc51d0a7177f65759c9e0d7bf596aa3e); /* statement */ 
require(_FinishTime  < SafeMath.add(MaxDuration, now), "Pool duration can't be that long");c_0x36c080af(0x7369c5f7b75fe12310f076ed3a2a9fef6546c7de1dab37676b7f1f71dfe31d6a); /* requirePost */ 

c_0x36c080af(0xc539984ee4f4d0d8ff9d9938c4eec259942ba38b985e231769711364ef32f6cc); /* line */ 
        c_0x36c080af(0x8c70bbce457ea61e5bf1e50bf8e16906bd806e45897828ef72d482f2e7371187); /* requirePre */ 
c_0x36c080af(0xf33388a96e5f0cb92b87a284d5567ef61d7e7f2a40d3a9cba5eb082d4407c294); /* statement */ 
require(_LockedUntil < SafeMath.add(MaxDuration, now) , "Locked value can't be that long");c_0x36c080af(0xbcf2e68e7b01815bfe5c0522a0a4d722e1e3a853c20dd4f8368e7ad4569eb904); /* requirePost */ 

c_0x36c080af(0xd1d7e04dec238cb4ed0471d2f941b68ddc9c7fa9c09eec004917e447e297d9ff); /* line */ 
        c_0x36c080af(0xf02c77ea4d7d398acbc0a00d11b2f3ddab4fcd7f873c2b075749b4fbaeb03864); /* requirePre */ 
c_0x36c080af(0x7f2f8080241d7e4da85c43b32d694551956342f954351c861d6408f261e12a54); /* statement */ 
require(
            _Rate <= _POZRate,
            "POZ holders need to have better price (or the same)"
        );c_0x36c080af(0xff8a3905c4fdd6e09589f08d3c8a39e1be0adc5784906a16140c30627ea2089d); /* requirePost */ 

c_0x36c080af(0x07f7f6f8adebd176b3367bd2dbc2f0ac3afda0c1a42fe813fd4977cc92246778); /* line */ 
        c_0x36c080af(0xe9a836390f53efdf2876c860ac4fc0c64a0340d2525e548ac9b31d6034d128ab); /* requirePre */ 
c_0x36c080af(0x957f03ce8c9a8d8d80012f81c8bda05da63610deca4723fce639dbf28f9b7722); /* statement */ 
require(_POZRate > 0, "It will not work");c_0x36c080af(0xbc1fa5812cdc6be12c397a61ea0e7dfe1e0707eafe8215d669ada33d4ddf501a); /* requirePost */ 

c_0x36c080af(0x2efdddca66047c2a75100b7dfd0164e4c36bc4542cb323ce375848e51c4276ec); /* line */ 
        c_0x36c080af(0x0695e4a91bce6dcb0638cedc4b58cb82ffd2e35018daf11b1f34e4c96511d789); /* statement */ 
if (_Now < now) {c_0x36c080af(0x30f6e5f16a0d6768203f48b3b95ae472b7daffc56df2859c3eb7f78e73a085ee); /* statement */ 
c_0x36c080af(0x9e6986ca759c176dcea95ae5fd605dc35f8e74babd0af1baab3731ca8090b657); /* branch */ 
_Now = now;}else { c_0x36c080af(0x0dbfc5f0b3bbbf10e2f871095114e63f7da2c4e162b754e82c11126ee82c58bb); /* branch */ 
}
c_0x36c080af(0x87b5787574a4e5f1ec3718986c3db26d7d35d909f02e896ddf0ffcaf1fee7f35); /* line */ 
        c_0x36c080af(0xe9aa66596af952cb0a174c45892503c767ffab502cdd31cc802f7de75e454f68); /* requirePre */ 
c_0x36c080af(0xc89e12441d5345f2855b87a40f75819b5f89bbcbc9d8e1d4f4e51462d31dd7d0); /* statement */ 
require(
            SafeMath.add(now, MinDuration) <= _FinishTime,
            "Need more then MinDuration"
        );c_0x36c080af(0x0f9be087027d7eab8d3cef90e9bb68b7001e25902ea4818d7332527580f8cb7b); /* requirePost */ 
 // check if the time is OK
c_0x36c080af(0x70bd890e81e197dba1809c089f54ccc85d1708027001e446d9808128fbec4152); /* line */ 
        c_0x36c080af(0x5581675c855b409a507e2c05a8cd64c3e8b444770f116089fb165c4728730a36); /* statement */ 
TransferInToken(_Token, msg.sender, _StartAmount);
c_0x36c080af(0xaf954cb1a58510db5c20b493f100e47ea85b79cb30a3eda72b648d93c7f97681); /* line */ 
        c_0x36c080af(0xd691ab71d38dfa0d05c2be7c592d41793b5cbdb7e516b566f07983fd7fff1a24); /* statement */ 
uint256 Openforall =
            (_WhiteListId == 0) 
                ? _Now //and this
                : SafeMath.add(
                    SafeMath.div(
                        SafeMath.mul(SafeMath.sub(_FinishTime, _Now), PozTimer),
                        10000
                    ),
                    _Now
                );
        //register the pool
c_0x36c080af(0xff42c7ee6be12a86b51a7a45fb5584bf60d40428d952f895b569c5f87ef07af0); /* line */ 
        c_0x36c080af(0x6c91e7a229b6ec15d6cb5d1b0d9542d44800cc2eea9c13c26f0a3c0ea6dff2ec); /* statement */ 
pools[poolsCount] = Pool(
            PoolBaseData(
                _Token,
                msg.sender,
                _FinishTime,
                _Rate,
                _POZRate,
                _MainCoin,
                _StartAmount
            ),
            PoolMoreData(
                _LockedUntil,
                _StartAmount,
                _Now,
                Openforall,
                0,
                _WhiteListId,
                false,
                _Is21Decimal
            )
        );
c_0x36c080af(0x4d77a82e2e494c2719616930f080760bf423de3cf263a434f2578aed27d550d0); /* line */ 
        c_0x36c080af(0x2a39b2932127ce2e8c1589ac827e6ac2b03bd3879cbb21340c20345bd3f02dd4); /* statement */ 
poolsMap[msg.sender].push(poolsCount);
c_0x36c080af(0x8a14d21b76549b1233d6e7561a34cea7fd3324510a165a1ed95697c5a6358959); /* line */ 
        c_0x36c080af(0x9a1f76b109e41b20b536158839012a45922e9ad050bbf3a729bb4d2ee0679b24); /* statement */ 
emit NewPool(_Token, poolsCount);
c_0x36c080af(0x08204105a4516dae1734c9b6e8557bb83fd5e746d24d8a3ed2e951d8f68a4d62); /* line */ 
        c_0x36c080af(0xf1d10876e0d99a87f2db9bd20cf27a5abb39696c85051f4ba734506c8330aae7); /* statement */ 
poolsCount = SafeMath.add(poolsCount, 1); //joke - overflowfrom 0 on int256 = 1.16E77
    }
}
