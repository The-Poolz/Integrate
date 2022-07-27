pragma solidity =0.5.16;

// a library for handling binary fixed point numbers (https://en.wikipedia.org/wiki/Q_(number_format))

// range: [0, 2**112 - 1]
// resolution: 1 / 2**112

library UQ112x112 {
function c_0x2680c98c(bytes32 c__0x2680c98c) internal pure {}

    uint224 constant Q112 = 2**112;

    // encode a uint112 as a UQ112x112
    function encode(uint112 y) internal pure returns (uint224 z) {c_0x2680c98c(0xc30e3d550603935d371742a6110b370c064416a6a213d1e34f0a385e905533a0); /* function */ 

c_0x2680c98c(0x7902a35c0945f2b8a4460d5569db9d6b02f65d9e6dffa08bd43ed783085911c5); /* line */ 
        c_0x2680c98c(0x346ec26aa84b9658fb86fe4978a59723d33deac1ccb579ba6acafae22369bb5b); /* statement */ 
z = uint224(y) * Q112; // never overflows
    }

    // divide a UQ112x112 by a uint112, returning a UQ112x112
    function uqdiv(uint224 x, uint112 y) internal pure returns (uint224 z) {c_0x2680c98c(0xad32ea9827b79cffa21853c75c70c8a0f65829f69d2727cb4c10ead6c13c0f03); /* function */ 

c_0x2680c98c(0x3ac402570f5ff3fbb13f99f70e5494252bcdcc735ef578e8e211278a91b46e3e); /* line */ 
        c_0x2680c98c(0x9424134c7bc8989b3fdab1eb9731b251699a3e1564d7ff0c214d2121baf65e4b); /* statement */ 
z = x / uint224(y);
    }
}
