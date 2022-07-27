// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x85cc6a0c(bytes32 c__0x85cc6a0c) pure {}


import "./LockedControl.sol";

contract LockedPoolzData is LockedControl {
function c_0x14cf97bf(bytes32 c__0x14cf97bf) internal pure {}

    function GetAllMyPoolsId() public view returns (uint256[] memory) {c_0x14cf97bf(0x5d3dc42135c136dfc97f7cb2a4d3b9768211ba834833e34f4175c55b797d3e4b); /* function */ 

c_0x14cf97bf(0xab97b20195811cad1156cd28b9744bf819f1a79da5171db988d8cdb07186e39c); /* line */ 
        c_0x14cf97bf(0xf4ea3d9edaf5ca553f0ea62d46d124b6c796c525df22f259a3bd7eb8afd0256f); /* statement */ 
return MyPoolz[msg.sender];
    }

    // function GetMyPoolzwithBalance
    // reconsider msg.sender
    function GetMyPoolsId() public view returns (uint256[] memory) {c_0x14cf97bf(0x139f7b016d6b3480afca993944e3e7f6007cfa4db6f882f922e2f3f5888d1c62); /* function */ 

c_0x14cf97bf(0x0202b7648be158925365a0cdaa4763167c165780ea83d30e086440819e674c4c); /* line */ 
        c_0x14cf97bf(0x45cc4dbb22bebf13eb0374238511ea8fd0cca64a5d43762a05eab5947e147a19); /* statement */ 
uint256[] storage allIds = MyPoolz[msg.sender];
c_0x14cf97bf(0x578328c29c030edfec93303f35b56f00f0f62af7bf376c3ab31dccddb7b0ddf6); /* line */ 
        c_0x14cf97bf(0x3235861cc811a5e61d723f5cfd83378a14f38df18e9eadbe2a86da7334ec07c2); /* statement */ 
uint256[] memory ids = new uint256[](allIds.length);
c_0x14cf97bf(0xeee5e065d5ec38a6fdc8179cb2975601db085e061f383338c090ddcbd40f7500); /* line */ 
        c_0x14cf97bf(0xa4ebeccd54e23793d583f90a5cf45849a6728b503ef6448166ad31b88f210dae); /* statement */ 
uint256 index;
c_0x14cf97bf(0xa850b5a0ae441a1cc7d2a0e12afd31f9287b8d12df856f9cb7735d64241b4f22); /* line */ 
        c_0x14cf97bf(0x78f4e00e57012a13c890fc1e01934004fdd79be56ce80c0cb5f6923d9f24b469); /* statement */ 
for (uint256 i = 0; i < allIds.length; i++) {
c_0x14cf97bf(0x367b48966c74cf65fcb38011e872701fdeb25edacf7a66676f02738e07ea0e8e); /* line */ 
            c_0x14cf97bf(0x272f8ea9a4c0cd9c0720c587410498f27626cfa481fe912b06ffd5161a4187e2); /* statement */ 
if (
                AllPoolz[allIds[i]].StartAmount >
                AllPoolz[allIds[i]].DebitedAmount
            ) {c_0x14cf97bf(0xee6a498d3a064bdb95a86905cfccebc86f4e908fbc3abb681ade0f30627cb7d2); /* branch */ 

c_0x14cf97bf(0xa17b601a1eef3f303cad769a1b3ef91f60b716d0f3df0363013895520004e85f); /* line */ 
                c_0x14cf97bf(0x59bfc3a7f6c3c6edf08e16b91d6441c43499ec0f363b6a56e299c41ec17cd827); /* statement */ 
ids[index++] = allIds[i];
            }else { c_0x14cf97bf(0xa6bf178dbb5b5e48ca7127dcbb292c6a8b17cbaa02b49c3855aa759ba4ecd9d3); /* branch */ 
}
        }
c_0x14cf97bf(0xbda64f7643545f2ea9df5f9a1d726c04259bdd7c21662b10b6bb6135dfdfdd6e); /* line */ 
        c_0x14cf97bf(0x76b9b3da89dc25a9ec0a0fe98e64d558863f8f04714b43b71c467662a37a8582); /* statement */ 
return Array.KeepNElementsInArray(ids, index);
    }

    function GetPoolsData(uint256[] memory _ids)
        public
        view
        returns (Pool[] memory)
    {c_0x14cf97bf(0x400bcf05e9c1885f7e15a3e056c291e51e76c81851194a35ada7226e271893b6); /* function */ 

c_0x14cf97bf(0xa77e6136bc0da8b1716d9f1472652c66a748f182debfcc180bcd960324456fe6); /* line */ 
        c_0x14cf97bf(0x88bdf2ed2d7e3d8c894478f48777c0897942216a3d49fc82c89a11795c3d8ad7); /* statement */ 
Pool[] memory data = new Pool[](_ids.length);
c_0x14cf97bf(0x4385c7d67c14f4ae53d8bf4b3f36362bc1f898cd38ce8d42bb18471164959cd1); /* line */ 
        c_0x14cf97bf(0xbdcf4c10109d37c88c97cb0f0a850ede0ad0363ee28c49b8765278305432b035); /* statement */ 
for (uint256 i = 0; i < _ids.length; i++) {
c_0x14cf97bf(0x318701a72350e5ab10d4c47b160bab99cc672f23f63b4b084f87599eaf8001ed); /* line */ 
            c_0x14cf97bf(0x9029e9ab65f3a58279ca6a052d29fda7078ece27a90232ea34cbd3167a1f1bc4); /* requirePre */ 
c_0x14cf97bf(0x37d3ce30763d3f41d8552ca5c809c229a6378671fa65e696a1ed15c5d412a84a); /* statement */ 
require(_ids[i] < Index, "Pool does not exist");c_0x14cf97bf(0x444585f7b382f8dca1fe77bcc987b19a4aa165ae73ed7bc1286096f1bcb1edc1); /* requirePost */ 

c_0x14cf97bf(0xf1d644748421bd726521827f5002802d693ff24a23b47f85267f74f3b6102811); /* line */ 
            c_0x14cf97bf(0x97ec8d4d06de08c86ebfe7a4ca10f01ce6f745e1f485b5ed9eb25dd54210e529); /* statement */ 
data[i] = Pool(
                AllPoolz[_ids[i]].StartTime,
                AllPoolz[_ids[i]].FinishTime,
                AllPoolz[_ids[i]].StartAmount,
                AllPoolz[_ids[i]].DebitedAmount,
                AllPoolz[_ids[i]].Owner,
                AllPoolz[_ids[i]].Token
            );
        }
c_0x14cf97bf(0x965a1fbca660e790a84b6d2527fc690cd97eedb7b6ed8ceeb7be921de9c35099); /* line */ 
        c_0x14cf97bf(0x01c7844e04bae0c6320f87c6e0d5f41f6f01391b93a9e20405d9534c0b67851f); /* statement */ 
return data;
    }

    function GetMyPoolsIdByToken(address[] memory _tokens)
        public
        view
        returns (uint256[] memory)
    {c_0x14cf97bf(0x18237f3072560db418fc01bb816ab52257e1e42f8ab7e29119df0ff298ce488e); /* function */ 

c_0x14cf97bf(0x90835ed7c4630ff9ccad18290bf5097396bd548789b29e7d4544b1d5635997d3); /* line */ 
        c_0x14cf97bf(0x1cf0dbb149ade0a88f309d6f53247f19d480cbfaecdcdbd16b590d34e45805d2); /* statement */ 
uint256[] storage allIds = MyPoolz[msg.sender];
c_0x14cf97bf(0x32178f1c7f848731615eb8d6545b5c3c353d80c07e9be3feb7e24351b11215f2); /* line */ 
        c_0x14cf97bf(0x8159b3e58a9453894c9aef6a0a15bd54e293470ce749463acf6f794ebb2bd0c1); /* statement */ 
uint256[] memory ids = new uint256[](allIds.length);
c_0x14cf97bf(0x6ee9903f5a38b2db82ad2ea7ac1e705f24a94e03c425ad5aaf5e62293bd647a3); /* line */ 
        c_0x14cf97bf(0x118285253054976a260c3dc45e1e3f02110086058442102df96b8d11a630efb5); /* statement */ 
uint256 index;
c_0x14cf97bf(0xaee0954411c78ebcaccc110c25649e9af9212e447be2926a554d81ce15f1a12c); /* line */ 
        c_0x14cf97bf(0xf941daf163454063daa42b92bd25962ffbd80e3a8f758aa4cf85f0e4cee77993); /* statement */ 
for (uint256 i = 0; i < allIds.length; i++) {
c_0x14cf97bf(0x3ae5ef3966340c3ea9a0eddcb9c79f9b340a27e0283180b4056cdfebec28a4b5); /* line */ 
            c_0x14cf97bf(0x7f5288cc4eab8ee681d05664ecd6e3828f607c6342e028897e991ea3a0eb8547); /* statement */ 
if (Array.isInArray(_tokens, AllPoolz[allIds[i]].Token)) {c_0x14cf97bf(0x5bed2f63a9f12335bdd0e3a41f80a452e8de798548646230295a7316f3314fae); /* branch */ 

c_0x14cf97bf(0xa07ee58a7c957d150d8cd98f446cfed2d59da5d2b682ce0e8796830bfc4bee58); /* line */ 
                c_0x14cf97bf(0x3b175e2e6c31c91c830d69a8dd18cadec61f064fbace1467054bc5174a332783); /* statement */ 
ids[index++] = allIds[i];
            }else { c_0x14cf97bf(0x207c6e2296943d5b13e12c8f3eb5ff62add6daf9db0a8b8a6fb4f0659aeda50e); /* branch */ 
}
        }
c_0x14cf97bf(0xa4a7f158deaafc901e05ecb4a2654c537b04093f3797d8278776b8135c532d4e); /* line */ 
        c_0x14cf97bf(0x7736e8b55fd838e2297bec2722647883a684d93a1a9707f67011c762093b10ab); /* statement */ 
return Array.KeepNElementsInArray(ids, index);
    }
}
