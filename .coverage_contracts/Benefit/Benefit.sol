// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./IPozBenefit.sol";
import "./IStaking.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Benefit is IPOZBenefit, Ownable {
function c_0x99d3798a(bytes32 c__0x99d3798a) internal pure {}

    constructor() public {c_0x99d3798a(0x1d3ae129a7fb05be0cdbd7e5e24d4e806763bd8e950c54b3f6e6f935bd05ac12); /* function */ 

c_0x99d3798a(0xdcce5964f96e26a1faa71e5793c16bca43fc1219127298e73b175997b3a15b46); /* line */ 
        c_0x99d3798a(0x34ae33df930bedf15a9d2029953da2c2587cfc5177b00010b0e2fa8af3d15deb); /* statement */ 
MinHold = 1;
c_0x99d3798a(0xafd601452862b7ab720998e4a9d9265893b47960c99531b17ee7ca07094cf49a); /* line */ 
        c_0x99d3798a(0x52fea28b750d972f12e003c269ff27032901058a5b08db905405831791230069); /* statement */ 
ChecksCount = 0;
    }

    struct BalanceCheckData {
        bool IsToken; //token or staking contract address
        address ContractAddress; // the address of the token or the staking
        address LpContract; // check the current Token Holdin in Lp
    }

    uint256 public MinHold; //minimum total holding to be POOLZ Holder
    mapping(uint256 => BalanceCheckData) CheckList; //All the contracts to get the sum
    uint256 public ChecksCount; //Total Checks to make

    function SetMinHold(uint256 _MinHold) public onlyOwner {c_0x99d3798a(0x5ee88138b82ecc32c89e1cba40f422108fd84b8a9ac428aaacdf8bbdd888f145); /* function */ 

c_0x99d3798a(0xcfdbd871203ba866a4585c3a47d6dd930ecf3228ba8cc589feadeb9036c8b7dc); /* line */ 
        c_0x99d3798a(0x7dd4834a6adebdc1caaf1dc7a03e7f8bb031874362165d8cea1a1e47732aa9f6); /* requirePre */ 
c_0x99d3798a(0x48566f9a793075364a53139f62c131a47c097ace0120271b2dc442e7c36363ef); /* statement */ 
require(_MinHold > 0, "Must be more then 0");c_0x99d3798a(0x8113428c2d56dc96fc609368d401ab0aebd0aece63a35d3c31a6d0ca60a592c8); /* requirePost */ 

c_0x99d3798a(0xce0c7ea175c09d3b24e3ff4e6a5dfa5a60237ace3746e10092dbaf7dc468ef74); /* line */ 
        c_0x99d3798a(0x37c1281a6095db232bad363cc668d67453dc9dfe1d028e356435a4ed99b1e8d8); /* statement */ 
MinHold = _MinHold;
    }

    function AddNewLpCheck(address _Token, address _LpContract)
        public
        onlyOwner
    {c_0x99d3798a(0x1047668bd851e71faf25acbab74782f7831dd2f491d2201d10a4f526c5559944); /* function */ 

c_0x99d3798a(0x7fc79a22a285a37b115884bbda8074c562074dba5df9edc3bd4e10f50bba761c); /* line */ 
        c_0x99d3798a(0x596c2a548fb8e8efca97a6952c473512db6b9c58f3e260cc258266ba7d2f19b5); /* statement */ 
CheckList[ChecksCount] = BalanceCheckData(false, _Token, _LpContract);
c_0x99d3798a(0x5d6f8e95b134685e06ac94668171eb934c1bc2f45754b7329f40edafd13db80f); /* line */ 
        ChecksCount++;
    }

    function AddNewToken(address _ContractAddress) public onlyOwner {c_0x99d3798a(0x5c897e67edd8d88f34f031c50385d59dd82567aae1d51f9d7e3ea21e794c80ab); /* function */ 

c_0x99d3798a(0x6d422be51637dca1aa6faaa7a49f0542ab78047853194679be503d0a3dac3ddc); /* line */ 
        c_0x99d3798a(0x6e2c0d121574b002ee8685130e0fbb4ec2d8774e0ed7550d1e2eb2429c749fed); /* statement */ 
CheckList[ChecksCount] = BalanceCheckData(
            true,
            _ContractAddress,
            address(0x0)
        );
c_0x99d3798a(0x08ee1882b3281be372820a4aa96bf03328790cea6eab948f60f78150a2a04a44); /* line */ 
        ChecksCount++;
    }

    function AddNewStaking(address _ContractAddress) public onlyOwner {c_0x99d3798a(0x1854acad504d9eac019ad35e07adaf92e37060bba51cf2daf10f3309b17e993b); /* function */ 

c_0x99d3798a(0xd28161b6eb0412e47cb4e996775471fd269aab588f017e955cfcd4504676752b); /* line */ 
        c_0x99d3798a(0xd75eabeb478ef9fb878ed29a4fd87f18775f4648fbb443d38ec87bce6c53dfdd); /* statement */ 
CheckList[ChecksCount] = BalanceCheckData(
            false,
            _ContractAddress,
            address(0x0)
        );
c_0x99d3798a(0x231bddd5b0d33217ad7ffcde7a87f43678c887564848823c9d8e6a565fbbf565); /* line */ 
        ChecksCount++;
    }

    function RemoveLastBalanceCheckData() public onlyOwner {c_0x99d3798a(0x9d37a0f49c6f4f42ab2d60f44ca6f4f4ad6c6e6c8370341343ae365ebf2d08ce); /* function */ 

c_0x99d3798a(0x1350f4614d30864f2aab0692714bf55d61ca831049c72210179def6114e90611); /* line */ 
        c_0x99d3798a(0x4d1a3ceda0d4b4e6b2daec044c76c70d9a43392036f5aaa3558121eb690c24a4); /* requirePre */ 
c_0x99d3798a(0x99ca5719b7e57da356614266c4d013a4021d8a080b5cd1c1434d827c809ba5a0); /* statement */ 
require(ChecksCount > 0, "Can't remove from none");c_0x99d3798a(0x5d027affc6dd15d748492664744841b1ac6dcc00f0c85d76d7abc745eccc9e5e); /* requirePost */ 

c_0x99d3798a(0xab6c456b691e9c46540e47210119f0b567b40d0d53423811cb1fed5ace084ef6); /* line */ 
        ChecksCount--;
    }

    function RemoveAll() public onlyOwner {c_0x99d3798a(0x8f656b08d4a5ddaea1794b68eb98d9b74aeb5ef7a8e9c72af5ef9b8359b3f587); /* function */ 

c_0x99d3798a(0x232885a45a469e871f5a4aa7c32b919b2f08f43547ca5b0b8c37a1bdf59757af); /* line */ 
        c_0x99d3798a(0xbfdc294b0d9ea737510a4dc8daaf90c50336280adc3adfaf8c93920290c0ab03); /* statement */ 
ChecksCount = 0;
    }

    function CheckBalance(address _Token, address _Subject)
        internal
        view
        returns (uint256)
    {c_0x99d3798a(0x05526a0d8001761cef8a965e4c106a1876d9ea624af6ecbbc702172e3be77dc5); /* function */ 

c_0x99d3798a(0x02a9416ffaec95cbc27f368bc1f8fe8db3a7a07faa7424cbf673cc9a55a0a4e2); /* line */ 
        c_0x99d3798a(0xaca500ddb80fda7851785b2216bb1a953bd090c2b533618dd070228bf3b99f2f); /* statement */ 
return ERC20(_Token).balanceOf(_Subject);
    }

    function CheckStaking(address _Contract, address _Subject)
        internal
        view
        returns (uint256)
    {c_0x99d3798a(0x6aad1b599f8b86f0bc8de2f9667e113bb24f064cacc43a65ae909986659d61fd); /* function */ 

c_0x99d3798a(0x373c3c8dd64de748250aff9da14132c761e0b72cb462f459aa0e1aa2264e32c0); /* line */ 
        c_0x99d3798a(0xf449974c54977e3fcd3c91a79b97a674d5e68d2fc097f65cac355b7dc5094dcc); /* statement */ 
return IStaking(_Contract).stakeOf(_Subject);
    }

    function IsPOZHolder(address _Subject) override external view returns (bool) {c_0x99d3798a(0xc33cad1f08b61d31f2e19e20b2ea7382d6b347d48498a08533e71862602caa99); /* function */ 

c_0x99d3798a(0x99ab94ae5c94fd04b9a4cca23917d71097f5dfe5fcb672373870396daf128ae0); /* line */ 
        c_0x99d3798a(0xaf34c58fd81354f7e3599c5047c07daf19788670a4dfaa29d494137000ee355f); /* statement */ 
return CalcTotal(_Subject) >= MinHold;
    }

    function CalcTotal(address _Subject) public view returns (uint256) {c_0x99d3798a(0xfc2dcc717fa01d7d51793936d6b09dccad739f624577b9b04969372714412f32); /* function */ 

c_0x99d3798a(0x2718b1b501383d02fc3fb6f3f95164f13a3b7e303cca026415c38a6e4a03e3a6); /* line */ 
        c_0x99d3798a(0x8d14e00dd07b4be1c1fdda8194f3be421b0a7c303830b6e883133cb7d9336e33); /* statement */ 
uint256 Total = 0;
c_0x99d3798a(0x0ff35c89341e794243c89a4c1579ae067b729e1b2a4685b0f37d7596d2ce5c55); /* line */ 
        c_0x99d3798a(0x290afc439cabcddf6dc4f59f85c699703daf8bc2f1e05b285b2e019ee4c4dd41); /* statement */ 
for (uint256 index = 0; index < ChecksCount; index++) {
c_0x99d3798a(0xc997401b36352dee119e84deebedb4cf3303ead0cca2e85c62ce0779f446b64d); /* line */ 
            c_0x99d3798a(0xefacccfb763913c7b5eff1da5cf84ca1a4186bd1cb9c9caf4073685a12785765); /* statement */ 
if (CheckList[index].LpContract == address(0x0)) {c_0x99d3798a(0xf6f62240c656b8be98f45f14749f69167d3188ae3fac047b718d60e097d6a2ba); /* branch */ 

c_0x99d3798a(0xfb3bdbee0423f2393bc788b54978f3f0f47261279e34b516085ed0993ac28d0c); /* line */ 
                c_0x99d3798a(0x0e6f01343e97025076821ebca63c801d2f9900ccd456cd2ab2b40374959ff162); /* statement */ 
Total =
                    Total +
                    (
                        CheckList[index].IsToken
                            ? CheckBalance(
                                CheckList[index].ContractAddress,
                                _Subject
                            )
                            : CheckStaking(
                                CheckList[index].ContractAddress,
                                _Subject
                            )
                    );
            } else {c_0x99d3798a(0x09ae5e4543f03b50e101aac20e6614b7b9b4e189fa54c2c5d9a03a0b1ce817d2); /* branch */ 

c_0x99d3798a(0x5e063f554eee186e1b511f8a0d6c9e45af0c3b7e24adea2fa0cc4783674ede93); /* line */ 
                c_0x99d3798a(0x4f72064809469e542ba11c224d87d100146135c65322199232a3f25fa5a3ed84); /* statement */ 
Total =
                    Total +
                    _CalcLP(
                        CheckList[index].LpContract,
                        CheckList[index].ContractAddress,
                        _Subject
                    );
            }
        }
c_0x99d3798a(0x337e0781326b221eda3045051f92a0b162a548e703e17f466a8049859a72530b); /* line */ 
        c_0x99d3798a(0xf2750221b811e89f48bf0c31081a63d09d4d9de74a37791579e2367158bff12a); /* statement */ 
return Total;
    }

    function _CalcLP(
        address _Contract,
        address _Token,
        address _Subject
    ) internal view returns (uint256) {c_0x99d3798a(0xb4f26b513c51ebde160b5b4600cb98e30e320a9df42c18fef1ec627f5d14cf5b); /* function */ 

c_0x99d3798a(0x4a25eaf3b105bf49e70536ec9329ea21aa54f1573ad977c0a4eb87446ed55137); /* line */ 
        c_0x99d3798a(0x71f645edc31401f24053d185beeca4de00189cf5a6fd9d37de6ac27d3ed7937b); /* statement */ 
uint256 TotalLp = ERC20(_Contract).totalSupply();
c_0x99d3798a(0x9dbbcd074b1c3b52a878f0f83ea15e46b7537bae81e23f4dfa2cd5fe941635bf); /* line */ 
        c_0x99d3798a(0xb208916b501c97e21d3fcc5ea200d400bab9f48030ec455e370bedfc30b37529); /* statement */ 
uint256 SubjectLp = ERC20(_Contract).balanceOf(_Subject);
c_0x99d3798a(0xab33b80dcd3e4738e3fab59d07282bf07fca81ca33ae70e936e0d7884cedefad); /* line */ 
        c_0x99d3798a(0x5251696162e6544ee7dab5af02b25db3ee63637102b30ff18107ec09ff8e28f9); /* statement */ 
uint256 TotalTokensOnLp = ERC20(_Token).balanceOf(_Contract);
        //SubjectLp * TotalTokensOnLp / TotalLp
c_0x99d3798a(0x7bf567435f130fed5523c60b28227eb8de0b574aa4a69a107d066fce5d72208e); /* line */ 
        c_0x99d3798a(0x6f87c6bb309da8e58c797713d5a5a039ff60a2bd2440eda6f0bf1570e8c75180); /* statement */ 
return SafeMath.div(SafeMath.mul(SubjectLp, TotalTokensOnLp), TotalLp);
    }
}
