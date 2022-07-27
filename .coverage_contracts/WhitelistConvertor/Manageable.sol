// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.7.0;

import "poolz-helper/contracts/GovManager.sol";

contract Manageable is GovManager {
function c_0xd05aa118(bytes32 c__0xd05aa118) internal pure {}

    event NewPrice(uint256 Id, uint256 Price, bool Operation, address Contract);

    struct PriceConvert {
        uint256 Price;
        bool Operation; // false - devide || true - multiply
        address Contract;
    }

    address public WhiteListAddress;
    mapping(uint256 => PriceConvert) public Identifiers; // Pools

    modifier zeroAmount(uint256 amount) {c_0xd05aa118(0x537d9c20b43c6227794315e65ab7e0536b99e05aba16ea7a4781e5153f742290); /* function */ 

c_0xd05aa118(0x55584f9b97f5a54fb556483083fbd10ca1f908ad8088ad67483b25fa1beabb97); /* line */ 
        c_0xd05aa118(0x2e0aa87161f9af358d78d19ddbe76f7bb764d147d869678659b5c41fe7aa5838); /* requirePre */ 
c_0xd05aa118(0x0cd6402b53e7fac5d42e47424c3d74c0f932eda60e5c4a04aae93cea08d6e3e5); /* statement */ 
require(amount > 0, "Should be greater than zero");c_0xd05aa118(0x49ab3cd2e2ac729282e25546feecdfc37d33744b32ca8ad004b88b95693b6c7e); /* requirePost */ 

c_0xd05aa118(0x434193c28c38ed40a44594292390db609f3e1cc134010cd64db91ecce6d767fa); /* line */ 
        _;
    }

    function SetPrice(
        uint256 _Id,
        uint256 _NewPrice,
        bool _Operation,
        address _Contract
    ) external onlyOwnerOrGov zeroAmount(_NewPrice) {c_0xd05aa118(0xbc9dccb31a184a7c933bf9932236c119047e561e3d00e3c7068ab7223f5fd0bf); /* function */ 

c_0xd05aa118(0x6c037d303740340b63471c3010d256d3f04e15e814612371a89b311367e5d9bd); /* line */ 
        c_0xd05aa118(0x0827cdacf881031e5bbcfc2afa3007ed1b4593bc56cdea72c9d1ec87bde251c0); /* statement */ 
Identifiers[_Id].Price = _NewPrice;
c_0xd05aa118(0xee259e9a3cc09967b493a849c83320d2227368ab14e0c996659018469f20eea7); /* line */ 
        c_0xd05aa118(0x88eac47afbed24600f3708a8efa8ba28616f1364abf5250fe2dbbeeac3db70a2); /* statement */ 
Identifiers[_Id].Operation = _Operation;
c_0xd05aa118(0x228c2c7a6b70e375004418b01f98e3c9f7dd66c5e79b97bc99eda25b4fdd5e35); /* line */ 
        c_0xd05aa118(0x3ebc83209f5311b7ba7d7f1e2f238d948c26fd71a21ad81baaf43bf32eae24a0); /* statement */ 
Identifiers[_Id].Contract = _Contract;
c_0xd05aa118(0x6e6004c2ff5d9aea258d54bdd7d5227dcda33b21b2a76eb08943c10b3840f56a); /* line */ 
        c_0xd05aa118(0xa9e8306cd9a386feb9ab8993583d68ff1ade3fd258c9b1d964e385c049dd686e); /* statement */ 
emit NewPrice(_Id, _NewPrice, _Operation, _Contract);
    }

    function SetWhiteListAddress(address _NewAddress) public onlyOwnerOrGov {c_0xd05aa118(0x6755700939c57bbe0730740d2055c87e3494cc2593563f1c07f982e60f3a440e); /* function */ 

c_0xd05aa118(0xcc0923a368723c07f4b1b622edf2bab408ddc86d27e90017d97ace38ceb595c6); /* line */ 
        c_0xd05aa118(0x14a69a30c548d63204146cc0f39030d8a1cde0edcbed0d7d3940df38870db253); /* requirePre */ 
c_0xd05aa118(0xeb31db7c39938715eff9b356bc53e8729dd5afa55d57498002b33938ad111e9f); /* statement */ 
require(_NewAddress != WhiteListAddress, "Should use new address");c_0xd05aa118(0x1829c9cc248c267f71b5bdc6df283f9c5b86a817b05ce8efb6ec6dd6a1ccd914); /* requirePost */ 

c_0xd05aa118(0x868b03544cea3ddf889fa199ec3dc09c5de78009fd9f721c682f5146a394e5c8); /* line */ 
        c_0xd05aa118(0x20bf2d2689294b867c0b401578bf4292cb0eefe0dc8ae4f1d9e5b59565cdde84); /* statement */ 
WhiteListAddress = _NewAddress;
    }
}
