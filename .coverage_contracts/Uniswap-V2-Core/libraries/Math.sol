pragma solidity =0.5.16;

// a library for performing various math operations

library Math {
function c_0x0455e946(bytes32 c__0x0455e946) internal pure {}

    function min(uint x, uint y) internal pure returns (uint z) {c_0x0455e946(0x88919ed19e52188f4f6fcef93667538f5ce1950cd17f9a5ead95ce538c2e96e7); /* function */ 

c_0x0455e946(0x1b00ae5bb9c325540ee169d57ef5b4aefa20a908ffa10c4abb7372c51c2e8376); /* line */ 
        c_0x0455e946(0xe92c44494297267411ef4e720eb538c554ffc917461eab45618b34dc1f17ccc9); /* statement */ 
z = x < y ? x : y;
    }

    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint y) internal pure returns (uint z) {c_0x0455e946(0xf602b4a334f253613fa4150b382d74f9c6845a13596e990050c8fee4d8daf80e); /* function */ 

c_0x0455e946(0x39d036cd5675b3b6b7b5c84bfa9fa768e74e6c01139eccfa084a20a3be79c1c9); /* line */ 
        c_0x0455e946(0xc3088142ba0259761e9182f45be2c994637c8f15ae66bac199b05571076ce62c); /* statement */ 
if (y > 3) {c_0x0455e946(0x8b0804bcb29fea5e0d1f31618906c7acfeadfa9021ee43de0767a2dd1170f1c3); /* branch */ 

c_0x0455e946(0x1a46588c85e33b90f1ecce75eead2eb9cbbc5d049ccedf8760b557e3e013adbe); /* line */ 
            c_0x0455e946(0xd95760da08d7b24bc77e0ad933fa2b438d9160d347681cffed3e5698d13af333); /* statement */ 
z = y;
c_0x0455e946(0x0de3304f347865b8a47d1bb8ac53f00b9046c16c9a5a137563ddffb2eb633929); /* line */ 
            c_0x0455e946(0x2cf3097b398ca47e2c34eaf8ca9bf82bc87249794d6aa8df90d917ced24f9084); /* statement */ 
uint x = y / 2 + 1;
c_0x0455e946(0xacb44027954b9a4b336071337d19f663f42e2afd76e6b8c339b02419c4c68882); /* line */ 
            c_0x0455e946(0x86ef11c8993bd4abdf1ed220f593a3f94d0f29ff1766f29762340b17dedb1adb); /* statement */ 
while (x < z) {
c_0x0455e946(0x4d1329bcb59f257a849e49202a7bfec28d85b80653fc13ab5fb04175d046d34b); /* line */ 
                c_0x0455e946(0x472533cbe2f09aef800bcc87f7aedc651d68506cc9a8dd819aebf8928aa9bdac); /* statement */ 
z = x;
c_0x0455e946(0xa511213e1481ea1fc854db49db0fff5fb1c606d47d0590d56ec9c4e269489688); /* line */ 
                c_0x0455e946(0xb312f9d32b4f3964933b7a33a209bd649853dad45f04bb331c97bcaa13c42d36); /* statement */ 
x = (y / x + x) / 2;
            }
        } else {c_0x0455e946(0x756a59d76fb1ff681c503661681284281c2633e8be3ef3cb28d3229da514dd8f); /* statement */ 
c_0x0455e946(0x0aaa0c97205a657865d9645cef507ab30e619a5195431958968dc9df973c1a01); /* branch */ 
if (y != 0) {c_0x0455e946(0xa0fa0a7c8cb727e8444fa819720399623b5d47ff63fc1ea456d158d23718a94b); /* branch */ 

c_0x0455e946(0x256c036a8c1332453b4a94a35d56dbc14a2ae625384193dbb19977b5a9468295); /* line */ 
            c_0x0455e946(0xa14d1d0f319f9f40e267b4fbcf7e2ca03f506284da16da183451b8057f405e7f); /* statement */ 
z = 1;
        }else { c_0x0455e946(0x468be7ac6df0c2609e65a5a5a2a4a5cf19e22c76067ad4f8ecaf8e68dfdb0343); /* branch */ 
}}
    }
}
