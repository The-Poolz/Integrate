// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x66c2b183(bytes32 c__0x66c2b183) pure {}


import "./LockedManageable.sol";

contract LockedPoolz is LockedManageable {
function c_0xc3ee74ab(bytes32 c__0xc3ee74ab) internal pure {}

    constructor() {c_0xc3ee74ab(0xd95a69bbbc446ac7a243f375ac5f99f166dfeec7dcad591df742a7a9a03389de); /* function */ 

c_0xc3ee74ab(0xef90977275986165fe477f5dcab1ccbdc04b26a8a69d9e72cecb10772689a208); /* line */ 
        c_0xc3ee74ab(0x212cd411d8ba3797279cb0bb0b0f9fe1eb1a0add38f92ea1548c234cdece7765); /* statement */ 
Index = 0;
    }

    modifier isTokenValid(address _Token) {c_0xc3ee74ab(0x88c5c197cc9a8ef1245aa1334230d0fa5a1dd77f6db205a0a1fae350df8fd7a8); /* function */ 

c_0xc3ee74ab(0x038b0fa378f04c967c3d5049fb8fb23f3f7e00db16c9eb01f2faa797cb36453d); /* line */ 
        c_0xc3ee74ab(0x2d720f5cd4ab3448a233cb3829ac23d674415147dfea8b150a3dddccc5432d6a); /* requirePre */ 
c_0xc3ee74ab(0xac5acbb084fce0f177386bde2016a93063cae4c8d4a7f2bc4e5a93b6aef14162); /* statement */ 
require(isTokenWhiteListed(_Token), "Need Valid ERC20 Token");c_0xc3ee74ab(0xf6bef9343c781678785291d7da5d50ba28127dfd79ad91c752525d3ac3dfae90); /* requirePost */ 
 //check if _Token is ERC20
c_0xc3ee74ab(0x285ac73251fab6387462bb21a5b3adf96e2f81ba67c6c138b1ae1dfb78534266); /* line */ 
        _;
    }

    function SplitPool(
        uint256 _PoolId,
        uint256 _NewAmount,
        address _NewOwner
    ) internal returns (uint256) {c_0xc3ee74ab(0x887b7cf8a95200c9228ce6a53f0dbc0bf99401b98845a14ed1f11d52e6d2623f); /* function */ 

c_0xc3ee74ab(0xea0957ff9f7c6eceacf49366a7c232d3c7c49aa93bd798f1b1b7ed0a9644f9bd); /* line */ 
        c_0xc3ee74ab(0x81d942b36bc171108e7e0bdbda9ee91b1bd36f94cb9f5b2b8f2398c945d701d3); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0xc3ee74ab(0x91f42ad71d4e20119c3f486f5bc5eb94a486047054471c1193638229b2129f86); /* line */ 
        c_0xc3ee74ab(0x8fc106ea4b04c17c070dc7fa977159c1c5435aa51f20c60924ce4ba92511b181); /* requirePre */ 
c_0xc3ee74ab(0xdafef939f9ac9eeb9c1ec73f36b28156b4df51fb0d650de19f63f77ae8b85533); /* statement */ 
require(pool.StartAmount >= _NewAmount, "Not Enough Amount Balance");c_0xc3ee74ab(0xbc96bc93467905c14160996d32347d7986076731e7de31eb7295fd95053cc5c6); /* requirePost */ 

c_0xc3ee74ab(0x8939ab01c95e8478a873bd2f9bd571dae34f9dceb5a1bb449e623e53b23f4be3); /* line */ 
        c_0xc3ee74ab(0x3db4d085f5e010a7c7e1ca9875475bbe39f42bb9923e6b78a01b7602061392d5); /* statement */ 
uint256 poolAmount = pool.StartAmount - _NewAmount;
c_0xc3ee74ab(0xa704579ebec567e55c5c1db83b4ab8208256d30fd41cb122e6ea6b2994112486); /* line */ 
        c_0xc3ee74ab(0x5f45d94173bd55b2d5d3374c43100a3b1d8e5880419f6304131e2eede0ae18eb); /* statement */ 
pool.StartAmount = poolAmount;
c_0xc3ee74ab(0xfab2b1cbe1b886ab7ac962cdf0674bb8821a5fa2a3913e03f620b7c0e07eb1db); /* line */ 
        c_0xc3ee74ab(0x0b55375d9648d988e2ab43ed52cc52cb67241ed8eea0993fc33b59553f2617b8); /* statement */ 
uint256 poolId = CreatePool(
            pool.Token,
            pool.StartTime,
            pool.FinishTime,
            _NewAmount,
            _NewOwner
        );
c_0xc3ee74ab(0x973a4eb7ca565e75b35c84d889cc6fe785fb1bc453743e39ba6688a011af7f71); /* line */ 
        c_0xc3ee74ab(0x3b0f4aebd0714f4153c3d39182d5fa90d736f53cef1e9d4deb560a729f6430af); /* statement */ 
emit PoolSplit(_PoolId, poolId, _NewAmount, _NewOwner);
c_0xc3ee74ab(0x8aa02348a4425102e6340e388e8117f72b24e5794e4a3b0d18f64f29363e10f0); /* line */ 
        c_0xc3ee74ab(0xe6a0b430f968a06fadf6aeaadc24db7cb8f9f96bc2ff6a6d0720e912936e07d5); /* statement */ 
return poolId;
    }

    //create a new pool
    function CreatePool(
        address _Token, // token to lock address
        uint256 _StartTime, // Until what time the pool will Start
        uint256 _FinishTime, // Until what time the pool will end
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        address _Owner // Who the tokens belong to
    ) internal isTokenValid(_Token) returns (uint256) {c_0xc3ee74ab(0x768bc78df9e98aad2d0016b8749865a3a321831c20d951f3d0b2ef06cfe5023b); /* function */ 

c_0xc3ee74ab(0xeb2b63c9ea662166bb66adf2956e23e14ff56d67c4dc64b4d8e65f65660f8d53); /* line */ 
        c_0xc3ee74ab(0x7114df6244dcf4583ae2d660d1637462d4ed44f87f8b3452c9503b50b7d212e9); /* requirePre */ 
c_0xc3ee74ab(0x545fa99b5fbff43c30b478686382934582a43afca37e7d6237393aa581f20530); /* statement */ 
require(
            _StartTime <= _FinishTime,
            "StartTime is greater than FinishTime"
        );c_0xc3ee74ab(0xf1c2c112d59bfae6178966a163c27c223ffb58c7cd7f3b976c9512ea56cd4c5a); /* requirePost */ 

        //register the pool
c_0xc3ee74ab(0xb130d02afbaec6332f70f9515db0b8f166b36e8439cde8be3ccde00b8433d6d4); /* line */ 
        c_0xc3ee74ab(0x98f21fbe18a51a8f1f0bbe89ee2636d75a441f76059d3e39cfe71c5778634b6c); /* statement */ 
AllPoolz[Index] = Pool(_StartTime, _FinishTime, _StartAmount, 0, _Owner, _Token);
c_0xc3ee74ab(0x83e99d9fe8de32f70cd86fb18fec69f99e417ea4ff05c68fb52b51f761f49f1e); /* line */ 
        c_0xc3ee74ab(0x89cbf058711be2707b37dd63e39a860631f32dc58b9cd82afb9114bf1637c6da); /* statement */ 
MyPoolz[_Owner].push(Index);
c_0xc3ee74ab(0x70480b41149ceb183ac5019b6544ed0d358cc3fbb78e2ffff4a98f5a7c7702e5); /* line */ 
        c_0xc3ee74ab(0xfeeb4f229c38528e8ae34a1f328399a4173162ff66de880f34487c9e408d2692); /* statement */ 
emit NewPoolCreated(
            Index,
            _Token,
            _StartTime,
            _FinishTime,
            _StartAmount,
            _Owner
        );
c_0xc3ee74ab(0xb0000d94976b07034c0703bd8383cd72670af164b4c1176d240ab0d2984f35e0); /* line */ 
        c_0xc3ee74ab(0x889d42f3dcaae68942b51f4bde0314a91da0518f1fa34c09bf70c46c79d8c30b); /* statement */ 
uint256 poolId = Index;
c_0xc3ee74ab(0x94d684e3d4b8c9d29bcf6ffc1baf5717feb2b9ed3bd06cff5b2d6af74f8d2831); /* line */ 
        Index++;
c_0xc3ee74ab(0xeaee86d8f8ff1a45fbaed6ea54ab53609ba2c1131cfb12b1aa1dedda18f3b714); /* line */ 
        c_0xc3ee74ab(0x465eb413e5c7633e515d396b65b9f55fa2a4e5dd47fb64e54c94de43fc5e1845); /* statement */ 
return poolId;
    }
}
