pragma solidity =0.5.16;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
function c_0x3a4002a7(bytes32 c__0x3a4002a7) internal pure {}

    function add(uint x, uint y) internal pure returns (uint z) {c_0x3a4002a7(0xd75df52dd57ce7acde99b75711663729d369365bf352fe87dfe1c8a6b8d902eb); /* function */ 

c_0x3a4002a7(0x21b9a0126b87ec8aa25d59ae3e8b19f91c8f9a10cd65ab294666724e86110553); /* line */ 
        c_0x3a4002a7(0x0e6ec1b37a1976a769ed68444e21b5ae2f52e1b2d21ec15f0b306c8ed1bb2292); /* requirePre */ 
c_0x3a4002a7(0xb07cea7fddecf521a4265913ab23dd192a4319491f9fde11f7711222376e0214); /* statement */ 
require((z = x + y) >= x, 'ds-math-add-overflow');c_0x3a4002a7(0x4804f30f482b9f6e07c2fa45fbd83a64f63ddb41694e2d3ef67efbf5ad880ade); /* requirePost */ 

    }

    function sub(uint x, uint y) internal pure returns (uint z) {c_0x3a4002a7(0x90e3d813df80017dc21b82106c12467e67529f558c951b14cc0ea396c17f38b4); /* function */ 

c_0x3a4002a7(0x4f6b0bfbc84a29ef2b64f7a2c1cfd9d802af4eabfb56fda8d55fe93f43652212); /* line */ 
        c_0x3a4002a7(0x909cb7ddfe4247fabe4927664fa0c2aa9ee579a26292c7400654886c65b86a6c); /* requirePre */ 
c_0x3a4002a7(0x53dd1743a8d9fc03c7f1077ed3910e214023fbdffb7bc8801280d6a41fee15e8); /* statement */ 
require((z = x - y) <= x, 'ds-math-sub-underflow');c_0x3a4002a7(0x16d2f562cb7a4f1a0a158892c3d0615d25f1686c2dd1bb379f47a56973ee49db); /* requirePost */ 

    }

    function mul(uint x, uint y) internal pure returns (uint z) {c_0x3a4002a7(0xb675a89a61daff80437688a33e97f092006dbc6efde33c794f16c8e3d4c92cb7); /* function */ 

c_0x3a4002a7(0x254c433e2b3d959605a7d6a71afa9ff642fcde440f4c0041a62b34bf7b02020b); /* line */ 
        c_0x3a4002a7(0xc6fc7132608f13f05da03b24cee0dc889184050f901009bd1928146619cd8787); /* requirePre */ 
c_0x3a4002a7(0xefb1b1fd61376f5a8f22462634e6f3e22d1c44188081fded40d12e06190c3507); /* statement */ 
require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');c_0x3a4002a7(0x694d18733f5d098864dcec827ab2699da5037186469a52a522ba632ceb30aa45); /* requirePost */ 

    }
}
