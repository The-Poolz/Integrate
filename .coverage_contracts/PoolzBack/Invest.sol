// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./PoolsData.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "poolz-helper/contracts/IPozBenefit.sol";
import "poolz-helper/contracts/ILockedDeal.sol";

contract Invest is PoolsData {
function c_0xcfb16360(bytes32 c__0xcfb16360) internal pure {}

    event NewInvestorEvent(uint256 Investor_ID, address Investor_Address, uint256 LockedDeal_ID);

    modifier CheckTime(uint256 _Time) {c_0xcfb16360(0xa89804a1053b3cba2df4e4796ab28b2c0f30e39e6104300784fcba2edf8f653a); /* function */ 

c_0xcfb16360(0xa4f53d650f7a35c4248bbd1e5129892013e7ce4f8ba2e209f8a385927192b71e); /* line */ 
        c_0xcfb16360(0x900dc750f30e566a070b545eee1e0138e2994c33de06e6fd5d45a93810f3e02d); /* requirePre */ 
c_0xcfb16360(0xfdb7e13b33064e34484a5de6907a79f8c6d42ba152df2eb75e44a85e8cbdb5cc); /* statement */ 
require(now >= _Time, "Pool not open yet");c_0xcfb16360(0x48af7ac0073007af4c7ccdcd5f9c1df69dd7a662650bc38e556348c9e7794e18); /* requirePost */ 

c_0xcfb16360(0xe81bf95052f31341528360d2237558ca3bfc2a24d353e8eb7acbf06de0e053ff); /* line */ 
        _;
    }

    modifier validateSender(){c_0xcfb16360(0x0d121be7852e0a0602569882e60f17d918df1f43771b03d1767a10c40a143dd1); /* function */ 

c_0xcfb16360(0x124e02e07ddd96a2b0d13abe883f7d0e3139c70791d2b255e69933da955acb08); /* line */ 
        c_0xcfb16360(0xe1bc5a6fac81a831bcfbba6abe5fc15d3618826e7ae955119dd8397dd10e4c9f); /* requirePre */ 
c_0xcfb16360(0x8ea85f2d5aa55bbb33fe170a667c7d895be0f12d8ee653e59ee41afeb9cfb232); /* statement */ 
require(
            msg.sender == tx.origin && !isContract(msg.sender),
            "Some thing wrong with the msgSender"
        );c_0xcfb16360(0xb3623bcec4eb8c5e7fb8f4a6592672421fb40c937a0478c8900b2c15c2b51f1f); /* requirePost */ 

c_0xcfb16360(0xaaefe2be4a1f91ec96cbeea76bde15c746b914d3b0f25c5faa70181ee65f82bf); /* line */ 
        _;
    }

    //using SafeMath for uint256;
    constructor() public {c_0xcfb16360(0xb70a30e664a17d2b2db943baef6f3b3f055b97a7fd1dd74e2ed56f0c866b21f9); /* function */ 

        //TotalInvestors = 0;
    }

    //Investorsr Data
    uint256 internal TotalInvestors;
    mapping(uint256 => Investor) Investors;
    mapping(address => uint256[]) InvestorsMap;
    struct Investor {
        uint256 Poolid; //the id of the pool, he got the rate info and the token, check if looked pool
        address InvestorAddress; //
        uint256 MainCoin; //the amount of the main coin invested (eth/dai), calc with rate
        uint256 InvestTime; //the time that investment made
    }

    function getTotalInvestor() external view returns(uint256){c_0xcfb16360(0x3f5589ca3d5abb32e0f7090a3e2ce2bb4bddb81136b7461c9f7bf963a9ccf131); /* function */ 

c_0xcfb16360(0xb89e1196a7b18df42f96623b224a1d8f3c93236034bb1cbbbab131f6276eaf3a); /* line */ 
        c_0xcfb16360(0x4f665f985fa7f5f9c64e864a5ec4312a4f443a77c16e812fbe2c790b8a1eb9f2); /* statement */ 
return TotalInvestors;
    }
    
    //@dev Send in wei
    function InvestETH(uint256 _PoolId)
        external
        payable
        ReceivETH(msg.value, msg.sender, MinETHInvest)
        whenNotPaused
        CheckTime(pools[_PoolId].MoreData.StartTime)
        isPoolId(_PoolId)
        validateSender()
    {c_0xcfb16360(0x509973e272b606e5de4cd321df8036977766479e578d3bf3540d88da462cf8ac); /* function */ 

c_0xcfb16360(0xc6830d53184ba8efb3e4aa414f5567ab07c04607dd5568f27eec49b2f8afb1b9); /* line */ 
        c_0xcfb16360(0x210a8fa1798502110d0a0f8fa30ad95e69fcd50964ff883ff8182e69dc144965); /* requirePre */ 
c_0xcfb16360(0x9be81f315432657323d6d72480ecf3bbbebfee5e8b52eb732de68b8c938c688f); /* statement */ 
require(pools[_PoolId].BaseData.Maincoin == address(0x0), "Pool is only for ETH");c_0xcfb16360(0x9b1f86df86f635446ef8e8e774c453decf50469addeea86de2788f1f97a7b543); /* requirePost */ 

c_0xcfb16360(0x15b01ee97e83de3ae6705a24cb412ec51b61bb548b974993990ca3cdcabe1b97); /* line */ 
        c_0xcfb16360(0x7b9c3dc33b6fc8cacca0613fe168a1c977230447efe241adfe23b26f438c0d4c); /* statement */ 
uint256 ThisInvestor = NewInvestor(msg.sender, msg.value, _PoolId);
c_0xcfb16360(0x25842494630480557592510a0b345a0e5a65d3aa43235c48f8a0e39b1fdb1b64); /* line */ 
        c_0xcfb16360(0x0cbb2b7a25ef5674e7d014832a2446b36272bdb0cde940e3519ece4e1ae91216); /* statement */ 
uint256 Tokens = CalcTokens(_PoolId, msg.value, msg.sender);
        
c_0xcfb16360(0xbd406a34248b1d1b6b13c25fc64a1c9ea3672198b17fb521d242ef8ae0f665af); /* line */ 
        c_0xcfb16360(0x053a376fc57845779845f9e1c9cc35b7666b03ed90973480889b95b42cf9fe7b); /* statement */ 
TokenAllocate(_PoolId, ThisInvestor, Tokens);

c_0xcfb16360(0xae22fa4613b10b9adcb81fdac9b46caa0198835f4ef1720a6f65e345ca632b1c); /* line */ 
        c_0xcfb16360(0x27e535d3e2e80c426f1a9120b23d5d8307a16bb5df2371f1991d64ef238d7ca0); /* statement */ 
uint256 EthMinusFee =
            SafeMath.div(
                SafeMath.mul(msg.value, SafeMath.sub(10000, CalcFee(_PoolId))),
                10000
            );
        // send money to project owner - the fee stays on contract
c_0xcfb16360(0x26a4dcdf594acc7c04b99661cc21c43f971dcf36af7a9a077f9761c7efa00268); /* line */ 
        c_0xcfb16360(0x8ece326cf6927454b45772adf4a3674315d1381ee2c69c65e7bce0277a7c2e22); /* statement */ 
TransferETH(payable(pools[_PoolId].BaseData.Creator), EthMinusFee); 
c_0xcfb16360(0x3c9614003bcbbb4b06a72db959ad60126cde7e11035c5ea834bfc2550368a6d5); /* line */ 
        c_0xcfb16360(0x8f79c507e109b76099dc7b0d39ebf1334e03ee7e85dd3e6a1a84c3fa63db21dd); /* statement */ 
RegisterInvest(_PoolId, Tokens);
    }

    function InvestERC20(uint256 _PoolId, uint256 _Amount)
        external
        whenNotPaused
        CheckTime(pools[_PoolId].MoreData.StartTime)
        isPoolId(_PoolId)
        validateSender()
    {c_0xcfb16360(0x63290fb01822fe37e8673fcb5d965a1deab5704756f49bf1b267434c215a595e); /* function */ 

c_0xcfb16360(0xd6887c1f1aee69d1c8732535119a0dc94584ebe8fe18df0a2542ebe5cc541f4b); /* line */ 
        c_0xcfb16360(0xe5a76d56e853e148a75eb7da976baaa6b6589f0b75b99a7b5e4a09b56dcb45b5); /* requirePre */ 
c_0xcfb16360(0x26523b7ecac8e618a70920526f422f5950879ea0089294820467860b8987965c); /* statement */ 
require(
            pools[_PoolId].BaseData.Maincoin != address(0x0),
            "Pool is for ETH, use InvestETH"
        );c_0xcfb16360(0x2da7efd008433f06f9960acfc15db8b5392d39913b91f033361048734de37922); /* requirePost */ 

c_0xcfb16360(0x6be05071ba366ea87aeb261233f34ea6757df79bb2580c88c02af96eb22a9bf2); /* line */ 
        c_0xcfb16360(0x93c6500d4150d92695df8831a894499290da45ba118a062bbf7c88d289af8900); /* statement */ 
TransferInToken(pools[_PoolId].BaseData.Maincoin, msg.sender, _Amount);
c_0xcfb16360(0xd699036a5647da2f7ce31fd0ede7d7860bd15dbef2880c02f8a98501251f3259); /* line */ 
        c_0xcfb16360(0x451d35e21171b409fba0bd2afecd551ffb395040306cb5c9af8c36c36e580a32); /* statement */ 
uint256 ThisInvestor = NewInvestor(msg.sender, _Amount, _PoolId);
c_0xcfb16360(0xdaa4d0ed8b0531a39adc4fdefc22224cec17342f0acbfcf0c757679f86fd6eab); /* line */ 
        c_0xcfb16360(0x2c551146020831a9846a4b1386163bf42fd202cecc6015883aaaa68aea558083); /* statement */ 
uint256 Tokens = CalcTokens(_PoolId, _Amount, msg.sender);

c_0xcfb16360(0x075aeb9b99ba72c08f79c84bff13fbafb33d47f354bede1421fdc81c0aa7b967); /* line */ 
        c_0xcfb16360(0x776e40223e7ad8dcfc66d935a15a1148424e7d3bf1e18c5b1ef7ba133539b49d); /* statement */ 
TokenAllocate(_PoolId, ThisInvestor, Tokens);

c_0xcfb16360(0x0b02abe74821fe7001e1f90acff7c62ee8c3f652f913bf247f4190d2fdf1e7fd); /* line */ 
        c_0xcfb16360(0x0bd339ad1700e6a99f9bc762abb8af45edb1ee848480125ff4d336baa10a7a00); /* statement */ 
uint256 RegularFeePay =
            SafeMath.div(SafeMath.mul(_Amount, CalcFee(_PoolId)), 10000);

c_0xcfb16360(0x95a598aa6c3770fa92dbbafa1fa09c637cb214b3dd4affa1bb9083b77a53c349); /* line */ 
        c_0xcfb16360(0xfdeba1504e0eacb37e5f0542d583ad7b1b47a403bb0546a646e1a8314874b3c7); /* statement */ 
uint256 RegularPaymentMinusFee = SafeMath.sub(_Amount, RegularFeePay);
c_0xcfb16360(0x1c77a2f2400560b72cb3d717a54889c57f66239d86153f6ee23d1fff671b7fa8); /* line */ 
        c_0xcfb16360(0x6981254fbb7306cbb8a874a8ed5f36839e188ca59e39bb3852c3b83f58a87f05); /* statement */ 
FeeMap[pools[_PoolId].BaseData.Maincoin] = SafeMath.add(
            FeeMap[pools[_PoolId].BaseData.Maincoin],
            RegularFeePay
        );
c_0xcfb16360(0x8e523f273ae566db1b26f4cfd470b0cabc8f826c62863fcf3887d7f8e39a34e3); /* line */ 
        c_0xcfb16360(0xe092d6f94cce12b38443f7f7f2d64208b06d861f9911a74e3df5b5bffa771976); /* statement */ 
TransferToken(
            pools[_PoolId].BaseData.Maincoin,
            pools[_PoolId].BaseData.Creator,
            RegularPaymentMinusFee
        ); // send money to project owner - the fee stays on contract
c_0xcfb16360(0x030b3aa5b2ef96e58d9d2101c0442b5834d7926fb9ce6ac1215588b4248c1c8a); /* line */ 
        c_0xcfb16360(0x91e470b86aa914236b920b38aea7f6cd175ddc88a6b0e4eeb583528c1ad15257); /* statement */ 
RegisterInvest(_PoolId, Tokens);
    }

    function TokenAllocate(uint256 _PoolId, uint256 _ThisInvestor, uint256 _Tokens) internal {c_0xcfb16360(0x4ca86cf3c5224ac658d66ea8f75a56ae9136072c7d745d1ee882711c400288ed); /* function */ 

c_0xcfb16360(0x0f2d3d8d69161e4cafc3b19d8e5ce07788eee11a3944694284000f74e44ed52c); /* line */ 
        c_0xcfb16360(0x9445395379e76c24f375db37f2308aef903b26c5e88d2b8fdd2711470b9666bd); /* statement */ 
uint256 lockedDealId;
c_0xcfb16360(0x2d10c5e2599674f72466741406859e2d87a61f2577bd0b8986b56873878069c2); /* line */ 
        c_0xcfb16360(0x7fcf0c2775d41934ced94515d308a76b52231b28ef29f0775e686171b29a99b6); /* statement */ 
if (isPoolLocked(_PoolId)) {c_0xcfb16360(0xfb3b359aa2181f532038cd8f8e8136c848a3ea14c155f0a910f0e72eb809afc2); /* branch */ 

c_0xcfb16360(0x0bd157227b01a3fb3b827a25467c952b8e34c4a4eaa9b208c5a9ebeabe477f5d); /* line */ 
            c_0xcfb16360(0xc767e59f44f53f6d3e4e52bf3df593439318ea0ce7c89128c647f89cf94b9bb2); /* requirePre */ 
c_0xcfb16360(0x1c32f14e6cd24acdcf420aa300f5f2179d7b0991ae6b9f903dcd399a6cb573a9); /* statement */ 
require(isUsingLockedDeal(), "Cannot invest in TLP without LockedDeal");c_0xcfb16360(0x128b168fcc885edf118fb2c991c2dd6b7334b26a7f807a115d1c3d701dace213); /* requirePost */ 

c_0xcfb16360(0xf5f440d842d051a680814edc3ef709ed25ac763d49ee3471d5e87352fbbcda42); /* line */ 
            c_0xcfb16360(0x0a0a6ecb3b99daa200ed9e32216ecaa1764b2089106f64f6bb89912cc6489cf7); /* statement */ 
(address tokenAddress,,,,,) = GetPoolBaseData(_PoolId);
c_0xcfb16360(0x9bfc7ebe033d3d8f0e3e4fed96edb2fdcdd634f8bacf099179c84961333c6210); /* line */ 
            c_0xcfb16360(0x7c69e198e8801ebc4f63fc5034dcf3acd03dbcd9c41d7009a757ae305b5d5843); /* statement */ 
(uint64 lockedUntil,,,,,) = GetPoolMoreData(_PoolId);
c_0xcfb16360(0x00623928fd228773bc21f9ded793a54534f64bcf67930f0f2af55db09f404c53); /* line */ 
            c_0xcfb16360(0x5b14955e72b4c2214674b974e51a42ccc1a87542afdf928fa28206892514c106); /* statement */ 
ApproveAllowanceERC20(tokenAddress, LockedDealAddress, _Tokens);
c_0xcfb16360(0x3bcf02ee77e6d0229c67744246e859d5be449973735ea4c101d190f046bc8f05); /* line */ 
            c_0xcfb16360(0xcc2ef70fbb2e2a3c166138362b3b40db291b45380f65b7c41204018cf8a9d9c9); /* statement */ 
lockedDealId = ILockedDeal(LockedDealAddress).CreateNewPool(tokenAddress, lockedUntil, _Tokens, msg.sender);
        } else {c_0xcfb16360(0x66ee79bb84c02da6417996536077540dc90e4dd4f4ede3c04511fd8fd80b6841); /* branch */ 

            // not locked, will transfer the tokens
c_0xcfb16360(0xfb5a6b80d583b84694378ad1adadf33bd70c185e313164850ee362a00d37e1fb); /* line */ 
            c_0xcfb16360(0x19e6b407567b1747906c83ac88b7edb17ed8d4832a5fa789e192343a28c0fc4b); /* statement */ 
TransferToken(pools[_PoolId].BaseData.Token, Investors[_ThisInvestor].InvestorAddress, _Tokens);
        }
c_0xcfb16360(0x0d84278f95ef752895d1947bca7d6b5e02bb31312aa1d65dce71ee8a1c6e4438); /* line */ 
        c_0xcfb16360(0x34fe58b3b41787c2be8ed92138535c1bd769a197a202b43838267e0e7fda3c42); /* statement */ 
emit NewInvestorEvent(_ThisInvestor, Investors[_ThisInvestor].InvestorAddress, lockedDealId);
    }

    function RegisterInvest(uint256 _PoolId, uint256 _Tokens) internal {c_0xcfb16360(0x5fd09ff68a58b9b40e8d8f3f068d83c1d4523c77f98de458ba086d76e6ac7e35); /* function */ 

c_0xcfb16360(0x739d1e38237ef867baa5be3191e1de89e837d524648df90a5534ce45197182ff); /* line */ 
        c_0xcfb16360(0x0ad77d80daaf6ccbad95f04dddb85b9fbc0a78444b88c283940cb7c6d327ed04); /* statement */ 
pools[_PoolId].MoreData.Lefttokens = SafeMath.sub(
            pools[_PoolId].MoreData.Lefttokens,
            _Tokens
        );
c_0xcfb16360(0xfd8477d7ae03210508ed2613d06d6c5626804e271b92d3abd02dc5b870ed9ed4); /* line */ 
        c_0xcfb16360(0xbaff60f9533589c93bc21e6aa876a27705b050c602e6e5ac2dc829df9a326c70); /* statement */ 
if (pools[_PoolId].MoreData.Lefttokens == 0) {c_0xcfb16360(0x615c8135e1dbbb680b206347d5d39567a7b5866cb0699591a454162d237006c6); /* statement */ 
c_0xcfb16360(0x831f6b3cd998ada3c4c76e57a65e7a3aa8e3ea4c8ae4d2ba12add1a8a49f14f8); /* branch */ 
emit FinishPool(_PoolId);}
        else {c_0xcfb16360(0x2996ce5fd2eed0cd64f630157aa74f53410c9e5b1b7ba18e4ed9942e8173e42d); /* statement */ 
c_0xcfb16360(0xa02b8397e2cd9dd2d306f699ce92cb1d7a521304c8b78d6dfefc3cd3c844545a); /* branch */ 
emit PoolUpdate(_PoolId);}
    }

    function NewInvestor(
        address _Sender,
        uint256 _Amount,
        uint256 _Pid
    ) internal returns (uint256) {c_0xcfb16360(0xebfa48ff09d991430808dc18a6d65a5bee43b681f8f43e297641cd7a67f570d6); /* function */ 

c_0xcfb16360(0x2257519181ce3d7e69e5fa497b4f2e3152c8a7c18f4dbe157eb24a850d465e7e); /* line */ 
        c_0xcfb16360(0x771e1e6d988a1af588463f67b88dc4d635538da6d50e3caa9aedf772e0707e48); /* statement */ 
Investors[TotalInvestors] = Investor(
            _Pid,
            _Sender,
            _Amount,
            block.timestamp
        );
c_0xcfb16360(0x2d6dfe9c8aca805b212eae9366af194f677037287d75f5c41165b0c91c19f172); /* line */ 
        c_0xcfb16360(0xb132c326a7d4f9939a2b0db5a7563d5c793d9b45d9176e93c9e72d6fb832281e); /* statement */ 
InvestorsMap[msg.sender].push(TotalInvestors);
c_0xcfb16360(0x4ad3fbedceb10fb52c953f57dd330e1f6da3a0e5ac820a82250856d916909331); /* line */ 
        c_0xcfb16360(0xfeaa1d56433b0f9b9186ed0f53443baed61110febeafabc547af8956cece5f9f); /* statement */ 
TotalInvestors = SafeMath.add(TotalInvestors, 1);
c_0xcfb16360(0x92d1d22b16bfa606271297de3e057c9ae863df1939d8cdd94c4cbb23ad42f6ac); /* line */ 
        c_0xcfb16360(0x424f749adaf23c4795162a62f9af98e5fd4f7eb4667fa8ec9eaba1db2c888554); /* statement */ 
return SafeMath.sub(TotalInvestors, 1);
    }

    function CalcTokens(
        uint256 _Pid,
        uint256 _Amount,
        address _Sender
    ) internal returns (uint256) {c_0xcfb16360(0x4239286ee84de5717e1579c76f9c4348228c61860b5a60cd353bbde226357a02); /* function */ 

c_0xcfb16360(0xb52a555fd4baecf719350dbacbebaa25654ade19700ae7f28a67c65f13cc9d8a); /* line */ 
        c_0xcfb16360(0x8b3538e91373dc9b2df36a13b5b544777a9e21268423fa10878613fb586327b6); /* statement */ 
uint256 msgValue = _Amount;
c_0xcfb16360(0xe722c0ad2403f32bf8b01f5c772a5d3dfb6f4a09788ef0b695a964816d85a321); /* line */ 
        c_0xcfb16360(0xb94ba44c2c122af1eaedafe82c46105f2de0534989cd41671741cea1853ea572); /* statement */ 
uint256 result = 0;
c_0xcfb16360(0x9dac8b2cd203243411aff1ed2e2df6a44c2d557f9545d60565026f6a1a47e91d); /* line */ 
        c_0xcfb16360(0xe704da522ad7ed32d40f1dc3e59db89c54d1555521e20d68fb1a14ba868ca89d); /* statement */ 
if (GetPoolStatus(_Pid) == PoolStatus.Created) {c_0xcfb16360(0xe421992315916c750452745cb12674d6e53dc06366791def1f0aef14c4ab72ff); /* branch */ 

c_0xcfb16360(0x790997d217127966f48ea6f614d895f9612c8fb6e3a9bafef5c273dd3f819125); /* line */ 
            c_0xcfb16360(0xe2ade14446d3b824e96842d12e84ca89128dbf084b75b8bee8e639a1db6ba72a); /* statement */ 
IsWhiteList(_Sender, pools[_Pid].MoreData.WhiteListId, _Amount);
c_0xcfb16360(0xe69f72f4d65a2e44e9a177e385b1ca89b6dfaffe1c859f4acc585e3045247d05); /* line */ 
            c_0xcfb16360(0x99205d3b32366a582fa33801f2e9f50329116bb7ca32329033fb538dec8f9fe2); /* statement */ 
result = SafeMath.mul(msgValue, pools[_Pid].BaseData.POZRate);
        }else { c_0xcfb16360(0x7a3a7a708d3fea93f358840c2acc6211560b0162c22ac263488a52b2af565d4d); /* branch */ 
}
c_0xcfb16360(0x8b50eb16851aaed98bde9e907c5c90ba7348c2ff60dc9aa8fa968b3881991a5d); /* line */ 
        c_0xcfb16360(0x9a163a45aff35a9d6d7ccb8239f08680ab6e7b2561355fdefd190103f6ac3339); /* statement */ 
if (GetPoolStatus(_Pid) == PoolStatus.Open) {c_0xcfb16360(0x84e936fe9b44b21364deb460658c60bf82d1892b391b968881eaae311b532bfd); /* branch */ 

c_0xcfb16360(0x749c98deedbff07e905241433c9773e12d98437bc5eda8908fccc683da0e374c); /* line */ 
            c_0xcfb16360(0xf60281e0b584c711023122a71b6995a7eebcdfb24afa514d569b99c22ccb284d); /* statement */ 
(,,address _mainCoin) = GetPoolExtraData(_Pid);
c_0xcfb16360(0x59822efdb3933f6cc906cc9c561ff8c803457996c57df31543400b90d8d4b768); /* line */ 
            c_0xcfb16360(0x3d64eada253a7d1d489cd7ea86aa9e1a247cd860cb3d706c1bebe7c5954abe34); /* statement */ 
if(_mainCoin == address(0x0)){c_0xcfb16360(0x613c41a8c2cdd504770135040ba0365aa1a6251ea82db592bf72aaf05158bfa3); /* branch */ 

c_0xcfb16360(0x9db9a4f391ab1315df38689198589d40daa8a0c5a1084a84f5b35d3cba866443); /* line */ 
                c_0xcfb16360(0x1d627f331dec62818ba5379ef06d587ca9e68f2cfa15f66950f5a20e5ba20a94); /* requirePre */ 
c_0xcfb16360(0x7e06a57282a182382d24a5d3490cff978eeaacc59dd2068df1481c495a7491fb); /* statement */ 
require(
                    msgValue >= MinETHInvest && msgValue <= MaxETHInvest,
                    "Investment amount not valid"
                );c_0xcfb16360(0x8fff8e2999c1a4533f903f0debf6ebc7afc7c73bc71414d46f90e75fcf8ba64a); /* requirePost */ 

            } else {c_0xcfb16360(0x7a0d815f57a32cc36da260fe9a163eb714a1b84bf2d3efe3b4b550c54f4b21e1); /* branch */ 

c_0xcfb16360(0x37c131acf0f15580730f6f1bd7f1d67122264e4159d23e4a2531d930916b23ca); /* line */ 
                c_0xcfb16360(0x1bd60ca45f45bf3b1e7385e2a8842a064151a00831765082ff9ee72c469f1447); /* requirePre */ 
c_0xcfb16360(0xf56d32b6eee5789c1878551a5855bc3d8c8121e598f388a00e744bf16c23fd55); /* statement */ 
require(
                    msgValue >= MinERC20Invest && msgValue <= MaxERC20Invest,
                    "Investment amount not valid"
                );c_0xcfb16360(0x80d6219ab3701ad9dc1c4b70646d3cd72e9688754af05cb1dde9b6d30f98e71b); /* requirePost */ 

            }
c_0xcfb16360(0xcd5570f9e3e7311b1a9df3f01ef88f605ebb6df1fc50dc3f559f494d9186e8c8); /* line */ 
            c_0xcfb16360(0xa5aa2f7d437775ff1e006e54d02599fb08280bfb687fdb591f59e490fab7ded1); /* requirePre */ 
c_0xcfb16360(0x032200bbd446dcffdf5c54d72513d5bfc7f158b2e24018ebed77b8865d670b9e); /* statement */ 
require(VerifyPozHolding(_Sender), "Only POZ holder can invest");c_0xcfb16360(0xea680875327057c271ea1fa0aa3da52abea89b61894be8034b5902ff23f4af2c); /* requirePost */ 

c_0xcfb16360(0xe44e095c984ff47b3454b787b540be86d5e5e7c2dfdf4d8cfcff7540209d36a8); /* line */ 
            c_0xcfb16360(0x55fc90eb81a82bfa8361dd345a36b55bcb63a58059b86c1eb783a34dea817050); /* statement */ 
LastRegisterWhitelist(_Sender, pools[_Pid].MoreData.WhiteListId);
c_0xcfb16360(0xd7b21c2ac2e5d1d741b32a4179ec1da99a9cf962fd8a548577687a73c12f0fd6); /* line */ 
            c_0xcfb16360(0xb4eb3878b4d703fc648000e3ac50f77ca1c27b9cb28711d067a0d09d616b48ce); /* statement */ 
result = SafeMath.mul(msgValue, pools[_Pid].BaseData.Rate);
        }else { c_0xcfb16360(0x5515a68e6e320c298d85d3b944cd0524679528eb3928b7b90b7dd4fc46a110e3); /* branch */ 
}
c_0xcfb16360(0xf65839d0a42b7e73ba479e6ad10f63b5f44eb92f840bda54c595331efdeaae9e); /* line */ 
        c_0xcfb16360(0x3c1141f2cf587cb613d245c918f080263b49d829e29fca612c700d7ffcfc8567); /* statement */ 
if (result >= 10**21) {c_0xcfb16360(0x75450e448832e5086cd4d65e75768c86f600c9198b84d59fbeb5a94ad240d861); /* branch */ 

c_0xcfb16360(0x6bf68c219734d33f2a01a07a6e394417e6f55ee646f05a71afc71cce5cdd6fb0); /* line */ 
            c_0xcfb16360(0xa66e76835205991d1f992f05f3cb9a50f914f9396af8c67e542d70f160b2b02c); /* statement */ 
if (pools[_Pid].MoreData.Is21DecimalRate) {c_0xcfb16360(0x9028b0a9448f86d2cc1b75fd73341c28991afa2178bdd19b1713af55527688e5); /* branch */ 

c_0xcfb16360(0x27d5de9db52394d7166e922981adaa3b7eecd98825b9ebedf7bd4f5eb3bcd280); /* line */ 
                c_0xcfb16360(0xf309d9565249cdd339e66bd4eaaa7f7abd7cf1f3a887fe7996b86c054e013c4f); /* statement */ 
result = SafeMath.div(result, 10**21);
            }else { c_0xcfb16360(0x45a437de604151833f9d4c10064ff7149c163899389ec2acc2db40fa499dc0e8); /* branch */ 
}
c_0xcfb16360(0xf3dcb10ec52b6bda8b536172e0abca5b57de66491c4dca709ddf500754f84694); /* line */ 
            c_0xcfb16360(0xfeaad2d19751fe4096ce324d9a4e4460e20ee42f2fecbc3ff0a230fd08e5132a); /* requirePre */ 
c_0xcfb16360(0x79fcf2c4bac5dbf5ef4defecf2997fd15fc66bd86fb0487d26a67426ff1e8251); /* statement */ 
require(
                result <= pools[_Pid].MoreData.Lefttokens,
                "Not enough tokens in the pool"
            );c_0xcfb16360(0x37c01069c4f1ca210d0363a0b6bad0e18efffb06f68eb971da0ef78aa7217df3); /* requirePost */ 

c_0xcfb16360(0x442504f26ce5da2988c47668870a7e0b65720712afd0ad7c47ddca6891e390a5); /* line */ 
            c_0xcfb16360(0x01fbde8301b63f908372b01fff4661b7c2e532c8225ec0791e2e95872b0c75b5); /* statement */ 
return result;
        }else { c_0xcfb16360(0x3a27391707861495e3135a6d07a9895f1429dede3c2f144673b71c4ebf13afec); /* branch */ 
}
c_0xcfb16360(0x4339d4d985c827e3508be3adc6bcfe97cc26b5fda820d9ef8da4073fb7baf42a); /* line */ 
        c_0xcfb16360(0xb8f58e39ccfd9ed0f8f7e2205d5373718baf065baf437bb55f9bd99823d7032a); /* statement */ 
revert("Wrong pool status to CalcTokens");
    }

    function VerifyPozHolding(address _Sender) internal view returns(bool){c_0xcfb16360(0xa82c8aa788c87c33a3d4140e678fadfe97b5bd6ce14e06bb6897e57bef1400a7); /* function */ 

c_0xcfb16360(0xb9d00f3d450e6a5fea41e1a3448e879e398986bc5fbbeb6ff0304fe82948da68); /* line */ 
        c_0xcfb16360(0xab7a44a3c86b6c9e8f30095824b2de0065926751277484c2cbce9ca21a26b8e4); /* statement */ 
if(Benefit_Address == address(0)) {c_0xcfb16360(0x4540fb63e1cf040849bd49b0875f6f12559987d11c968bd1a4dcfc952bb6b458); /* statement */ 
c_0xcfb16360(0xd88433fbb3b72088ee1b2d850eec439c710c480b584ce3805606e2bf45b9d50d); /* branch */ 
return true;}else { c_0xcfb16360(0x4f6ad809f71ed2e8965d382e0c37b537466fab1f9b95c9e3b65728e5b3ec1c31); /* branch */ 
}
c_0xcfb16360(0x2871af7a175492c83c2498f6a2fc3a1e9e3d18ba39a6e99e3a4bbd3622ee36b8); /* line */ 
        c_0xcfb16360(0x1eeebaa9cbf31fa53961966a654a14b01e09e8a3603e383484992fda916581da); /* statement */ 
return IPOZBenefit(Benefit_Address).IsPOZHolder(_Sender);
    }

    function LastRegisterWhitelist(address _Sender,uint256 _Id) internal returns(bool) {c_0xcfb16360(0x6a4bf91d3b543c5caaf992ea8d8efea5eab3ea9f2bdc2ab32a522ad59779bb56); /* function */ 

c_0xcfb16360(0xf8e6f921222563162ee6a5d6992135763b48ebfc3ac9c7c43dca84cab6e33b46); /* line */ 
        c_0xcfb16360(0xa6171fdf34d27199f84c4257d49e669ffcb85d4a8db5f82eb4ab0f6e3c117e9e); /* statement */ 
if (_Id == 0) {c_0xcfb16360(0x417cad3f6784cb7103cc863a17d7eb71447668bf5f0757d222e7fad00c2c9366); /* statement */ 
c_0xcfb16360(0x2b482d0a9221109ecaf7033a06b6fb3a5307d959b5f023646cd807b4cbb21ad5); /* branch */ 
return true;}else { c_0xcfb16360(0xae9fd5e5009454505db03c7114118c43cdcba0bfc5989fc5cb377bbfa6a3bdef); /* branch */ 
} //turn-off
c_0xcfb16360(0xe481593fc94fd9473fb07c4b51ec4df5e9f0988675e343619d667b2d525ccd3b); /* line */ 
        c_0xcfb16360(0xc61d0eedb1241434c3eff170d9e7696db065c59a2ccaa7c7704b1a55f233b9c3); /* statement */ 
IWhiteList(WhiteList_Address).LastRoundRegister(_Sender, _Id);
c_0xcfb16360(0x4c04743ac396c6229ac161407ccd16491f320a5000878e5365f79a2d9e33a444); /* line */ 
        c_0xcfb16360(0x8b0495228aa01c37f396b728b083701fe792acc3ffaf033aaeb62505c72857d8); /* statement */ 
return true;
    }

    function CalcFee(uint256 _Pid) internal view returns (uint256) {c_0xcfb16360(0xb3a79cb8405482343cedfdcad87d93dce9800a321a10d57af814978c87dda34e); /* function */ 

c_0xcfb16360(0xcc0813e32991b5615a3013821e34b5449528f452094a0075f3270401b30369e1); /* line */ 
        c_0xcfb16360(0x57c5342cd1e33ac541c6842fab5bfefb18a9312ccf4aeb30b0d7347fc5fc92dc); /* statement */ 
if (GetPoolStatus(_Pid) == PoolStatus.Created) {c_0xcfb16360(0x0e8a9f7fad156eaaf97ce413db08909dd2d0186f97333dd716d6ff174775f0bf); /* branch */ 

c_0xcfb16360(0x6e3b84680d4d686fd89df61df9825136d316d04de828644b296733802bba19bf); /* line */ 
            c_0xcfb16360(0x27634bc53d6d22218bfd61b774b4bfb98c0340a56bf5bd94c0c52db58d078cbf); /* statement */ 
return PozFee;
        }else { c_0xcfb16360(0x2ddb0a4320d9dc3cdf41d89182e2bea624261c6a535227e7b36efb22eb092cee); /* branch */ 
}
c_0xcfb16360(0x912ec1a4e998e34d3ff18b52b7c6888a3fb87117c5280c1df6fe04e2279d542a); /* line */ 
        c_0xcfb16360(0xd0f6dc3247521162b007adb537c038b8396568f25ee79902ffc790197b705211); /* statement */ 
if (GetPoolStatus(_Pid) == PoolStatus.Open) {c_0xcfb16360(0x8c1608a578c20ff233b10cadf54543ec6db4688229f1360064cdc2dfd068e85c); /* branch */ 

c_0xcfb16360(0xb629c5fb4ca1eaa66d9f7cb942c2660d23b67795e7851e3889e60ced49191446); /* line */ 
            c_0xcfb16360(0x778b122b674a5e7b1565dd4f2e8425fac1516e265db8a1a19ffef96c43494b09); /* statement */ 
return Fee;
        }else { c_0xcfb16360(0x0e2703fb14dc19584520c35d97f28ccae2202c6f1a7c93c5a5627b9c7f6e3c79); /* branch */ 
}
        //will not get here, will fail on CalcTokens
    }

    //@dev use it with  require(msg.sender == tx.origin)
    function isContract(address _addr) internal view returns (bool) {c_0xcfb16360(0xe35124d4eade33def741ab2d09784c514cb945a67b13c9affb1b9d8b1e3e700a); /* function */ 

c_0xcfb16360(0x186764295fe3a84f9163fb32829e43574693e2276a1876bde028dc2779cbc092); /* line */ 
        c_0xcfb16360(0x92e3ad9176d695c7df22c9b9efbbb35d61da85c89237093efd79ccc8c44b9437); /* statement */ 
uint32 size;
c_0xcfb16360(0x1f8b3c5852cf914409f4f14c21dc29fc961a0a2d2a762a0290ce989dc32e7052); /* line */ 
        assembly {
            size := extcodesize(_addr)
        }
c_0xcfb16360(0xe81eba63ae352c6fe17b10064db20cef1c2458451fc61452e78850bee93ff118); /* line */ 
        c_0xcfb16360(0x8cd4871141a2fb4e3508bb99af129da82b33fd802c2cac23b8d96b99c571a286); /* statement */ 
return (size > 0);
    }

    //  no need register - will return true or false base on Check
    //  if need register - revert or true
    function IsWhiteList(
        address _Investor,
        uint256 _Id,
        uint256 _Amount
    ) internal returns (bool) {c_0xcfb16360(0xc47e55946877473e4175d1490441609950437fba114c3691aca0eef0a9878a57); /* function */ 

c_0xcfb16360(0x9c9a140ef52c640f04ceef2b0cfddfc6d9ee28d634c5086d405afa1b1f8afd31); /* line */ 
        c_0xcfb16360(0x03a54d6d105606c8527cf0b5d0c8c82579834961d2903ba8b3a772298982c48e); /* statement */ 
if (_Id == 0) {c_0xcfb16360(0xe1c92d93c2dff711edadcdd1abcd0c1ee23fcb130a4ab0452a246d333e62db5c); /* statement */ 
c_0xcfb16360(0x6dff09ff1a16192b93a00f83bd3ba16d62f801d68188a5f4fee9b76fa3abdfa4); /* branch */ 
return true;}else { c_0xcfb16360(0xd1a757a305cfe08f5afdbe656f7636f3b7e0ee8a8508452e3377900a1b1f6c4e); /* branch */ 
} //turn-off
c_0xcfb16360(0x4b41cc59d84aa9ca47b252a336fa2d9e4bde51ab6fd35fcdcd1cf3044613122b); /* line */ 
        c_0xcfb16360(0x2e49a99a966f456a25a37b37e0bb2f5201b596841247e2a5a54f7e10ba58e551); /* statement */ 
IWhiteList(WhiteList_Address).Register(_Investor, _Id, _Amount); //will revert if fail
c_0xcfb16360(0xabdf1f3dd81d1041687de4b9745d0da19c4d3484265b64d5bcc0402d9aa5157a); /* line */ 
        c_0xcfb16360(0x8261927ca2eca225b58194aa912fe50df2c59d14648f7123d059e57160c78c80); /* statement */ 
return true;
    }
}
