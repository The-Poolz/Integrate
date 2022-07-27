// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x8cf079ef(bytes32 c__0x8cf079ef) pure {}


import "./LockedPoolz.sol";
import "poolz-helper-v2/contracts/Array.sol";

contract LockedControl is LockedPoolz {
function c_0x6396809e(bytes32 c__0x6396809e) internal pure {}

    function PoolTransfer(uint256 _PoolId, address _NewOwner)
        external
        isPoolValid(_PoolId)
        isPoolOwner(_PoolId)
        notZeroAddress(_NewOwner)
    {c_0x6396809e(0x164893527d8de371657c60f7b6154c27873dfdb33b139661c2e76af65062e7fa); /* function */ 

c_0x6396809e(0x44bb31a492060ab8d5bb98de1d0c6a8169eab5e6a6799e29221acce61fadcf17); /* line */ 
        c_0x6396809e(0xa7ec6dd2382f1df088487c22a0423b85cdc46ff9f4f2f7434faffe457da3cba7); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0x6396809e(0xcfecea3e22cce80f46bd9b82b01594ecb0d16ed37732cca2ddfdada1e51b77e1); /* line */ 
        c_0x6396809e(0x4dc034898a2b532fd6fc3290183868576b244582854bea5f85c2ea209b3c38c1); /* requirePre */ 
c_0x6396809e(0xcb7714f84a726f5084c560c2d8fc9b6fd76e2933fc774bd66b4593f150d27e52); /* statement */ 
require(_NewOwner != pool.Owner, "Can't be the same owner");c_0x6396809e(0x77c9ba3408118392d9f64ef1d8372bb331ea1a991d56a0f34cad0ed0ffad515a); /* requirePost */ 

c_0x6396809e(0x4353b5db227b63a0c51582ab208f03362c0e011e6fe3b4a53f6e46869ffc8bc4); /* line */ 
        c_0x6396809e(0xdf86f3f5a57489ba1a8e7c6331657cb608424120ac2f3a6780a42d6f59785b18); /* requirePre */ 
c_0x6396809e(0x0ce6256084e79c573372b453bd92d38d52e8ce679fdb1f91302410d6bdebb13f); /* statement */ 
require(
            pool.FinishTime > block.timestamp,
            "Can't create with past finish time"
        );c_0x6396809e(0x0d19b6edc225c61b296ad456327b93f24c039f281c89c6b0779c2db50ce294ae); /* requirePost */ 

c_0x6396809e(0xc035177332033d841b27a995f1e9d270d9159f0de2d9d5325083d88877dffaa1); /* line */ 
        c_0x6396809e(0x6b6002a5ff4f7b347b73e2939a64e4d58697518d4015e600661f3fe340bc75ea); /* statement */ 
uint256 newPoolId = CreatePool(
            pool.Token,
            pool.StartTime,
            pool.FinishTime,
            pool.StartAmount,
            _NewOwner
        );
c_0x6396809e(0x88c6030ac933d37edc9429b94b2d4fcf1b1b53e02a7d0169c16dd28db1ffd234); /* line */ 
        c_0x6396809e(0x3b1cac88694f49f91765a028c6eb7148331ebc54895df38b7dff7b7907a5cd49); /* statement */ 
pool.StartAmount = 0;
c_0x6396809e(0x780311b056b561d33751ac2792e7f9fd5cd4d7e91f53674be2f02759539d9dc1); /* line */ 
        c_0x6396809e(0x4ab885b80395e424bda64dedc8618a8d78b13385cd34ffbc1d03121872863192); /* statement */ 
AllPoolz[newPoolId].DebitedAmount = pool.DebitedAmount;
c_0x6396809e(0x92b8380d6a8368ed5a0158150ae86cbb4d5a14f12a8208f7f70afce76d932505); /* line */ 
        c_0x6396809e(0x28b73277a50ee904409aa0c9526dc3be4fe2cf6a71ac13701cd3fde9eeef4679); /* statement */ 
pool.DebitedAmount = 0;
c_0x6396809e(0x89ec47280c15b62b2d95b77e131ca9db70f8efd3a268ae96262c8dc5ca10690d); /* line */ 
        c_0x6396809e(0x152b900781c970d33dd623ae5ac5049608813eb3fc2620e07fced7abe0bec268); /* statement */ 
emit PoolTransferred(newPoolId, _PoolId, _NewOwner, msg.sender);
    }

    function SplitPoolAmount(
        uint256 _PoolId,
        uint256 _NewAmount,
        address _NewOwner
    ) external isPoolValid(_PoolId) isPoolOwner(_PoolId) isLocked(_PoolId) returns(uint256) {c_0x6396809e(0x7ce70a9f8158c304e1d84f86e47c4880b409eeba04ad7239ff30369ca459eb03); /* function */ 

c_0x6396809e(0xf9f9dceda008c1c9ffce7565be2c3ca4d574dfd7aae8dec520ac12fd025a7bf0); /* line */ 
        c_0x6396809e(0x39de60c6e3b7b81f88dd9b9e93302b4b63661d2ffe25d400913ceddecf4b2a11); /* statement */ 
uint256 poolId = SplitPool(_PoolId, _NewAmount, _NewOwner);
c_0x6396809e(0x43efc03af43fbd605fbaf123fe2357a4074833bedb0f78458b64172bfc550e1d); /* line */ 
        c_0x6396809e(0xb736160fe57d68e8a9c4404368737d6d7b0a9590a9369e0724a64ef1351360d4); /* statement */ 
return poolId;
    }

    function ApproveAllowance(
        uint256 _PoolId,
        uint256 _Amount,
        address _Spender
    ) external isPoolValid(_PoolId) isPoolOwner(_PoolId) isLocked(_PoolId) notZeroAddress(_Spender) {c_0x6396809e(0xf6faf8d3c96f582c4139da21c9a37b5f6f47e2fd56d619200851bd7e0dc87552); /* function */ 

c_0x6396809e(0x5162429599337675e925260892087a647aed15da4dd03c0bca7dc0c4369ecc51); /* line */ 
        c_0x6396809e(0x10d27d6229b9394b74f29c75e64eab9016abc3c607c79b9a66d89b74e40c969b); /* statement */ 
Allowance[_PoolId][_Spender] = _Amount;
c_0x6396809e(0xf9dcfc306bb5c5ff5e96d946f7b1344426b290ee797453c591e92da7e15eb8d2); /* line */ 
        c_0x6396809e(0x6e0ab4f45311446f0c63210f43566eb9a21b8a547b96d5c4899ed464234adabb); /* statement */ 
emit PoolApproval(_PoolId, _Spender, _Amount);
    }

    function GetPoolAllowance(uint256 _PoolId, address _Address) public view isPoolValid(_PoolId) returns(uint256){c_0x6396809e(0xc32485ca8412b306dab09d05b0ca25705fa385af89358a0586d9df7b2105bba9); /* function */ 

c_0x6396809e(0x08e77f66f50defb557ee194b6754263c3ae049e5e2b3048e004ceb224f4a86a2); /* line */ 
        c_0x6396809e(0xb5ec53fb2964f341317fce493af25ff5e589eb13f2e0424300b79631caeff909); /* statement */ 
return Allowance[_PoolId][_Address];
    }

    function SplitPoolAmountFrom(
        uint256 _PoolId,
        uint256 _Amount,
        address _Address
    ) external isPoolValid(_PoolId) isAllowed(_PoolId, _Amount) isLocked(_PoolId) returns(uint256) {c_0x6396809e(0x67ef4139d42407de67004dd660f12f43e18c0d36a9725b1b7d3da319e3dceec9); /* function */ 

c_0x6396809e(0xd99badb5856c98021d7020cbf2a7b7a113843d74e32a68d104971a0d4a81747f); /* line */ 
        c_0x6396809e(0x2e5a3f34ff02d07db5487c5674246b72b2923886b2daa2669f622da3b0f8ddb4); /* statement */ 
uint256 poolId = SplitPool(_PoolId, _Amount, _Address);
c_0x6396809e(0xaf8fc3147fe630903d1887dedaaf836fc252d2972be680a727816ad33d041e4f); /* line */ 
        c_0x6396809e(0x967abe47b70ade24f63f0a43b3bf638b5ab50bc010c99ed99af6027a47169768); /* statement */ 
uint256 _NewAmount = Allowance[_PoolId][msg.sender] - _Amount;
c_0x6396809e(0x438d4e71458c01da9454792bb7165e3e3c8daedbf07447d827eb79e5c1995480); /* line */ 
        c_0x6396809e(0xf85d2a502b5c790e143486164db1cd25ff3aaefd2690ec9156397b9c07ec21f9); /* statement */ 
Allowance[_PoolId][msg.sender]  = _NewAmount;
c_0x6396809e(0x4fe81f0c3eb3d9d549790af1cbcb698f376c007674c9b3de863b394e9e1ff1fe); /* line */ 
        c_0x6396809e(0x20635f74c3671ad7a227cbdd58ee551af647547231b33a6cdd180233a9f72323); /* statement */ 
return poolId;
    }

    function CreateNewPool(
        address _Token, //token to lock address
        uint256 _StartTime, //Until what time the pool will start
        uint256 _FinishTime, //Until what time the pool will end
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        address _Owner // Who the tokens belong to
    ) external payable notZeroAddress(_Owner) returns(uint256) {c_0x6396809e(0x0364b756bf31ff0f512a04580daf5be599e53c89f0dcfbe1bce40f0e24f016f1); /* function */ 

c_0x6396809e(0xa875e170a7e47f43df26e2ad658320db4589d4cbfc6d0c7131c1b2326889f5e4); /* line */ 
        c_0x6396809e(0xc8c7a734615ca6acc8fc5f03fced7f3c3ad5b566c1874029ac31f98ece2985b8); /* statement */ 
TransferInToken(_Token, msg.sender, _StartAmount);
c_0x6396809e(0x56352e543792e172a21c53dfb5969392a4f9214d9a0e1d5c1fe67cccb20134ec); /* line */ 
        c_0x6396809e(0x18ae2829fd0b2ea5d8c71ca60b9cbbfbb3e8ae87d93d6c741af417d6ca15a63d); /* statement */ 
if(WhiteList_Address != address(0) && !(isUserWithoutFee(msg.sender) || isTokenWithoutFee(_Token))){c_0x6396809e(0x5fec8cd306883d4dbfe5da78101ea3b5dc257b2c2402b62fffb3abde2f777a3f); /* branch */ 

c_0x6396809e(0x878a24176f968585d0ee2482c8b8b4349fcefdf616c667eb97654b0f5785d1c8); /* line */ 
            c_0x6396809e(0x48dca426ea5ab9db67ba251a460231b43b249d0dd647a563280e818c23031bd1); /* statement */ 
PayFee(Fee);
        }else { c_0x6396809e(0xf507b5b23d77758b3743e1515129e3476e52a1d27827357071251d168b9feccf); /* branch */ 
}
c_0x6396809e(0x070ee75c9e33841d0a9aac8e250762a53fd496d7e125ddd7cd7ae18d1bcfb82a); /* line */ 
        c_0x6396809e(0xddd6b82929376ba87fa91ce204d350f6c4c03965384ad7b2cfdafeebdcb6ca46); /* statement */ 
CreatePool(_Token, _StartTime, _FinishTime, _StartAmount, _Owner);
    }

    function CreateMassPools(
        address _Token,
        uint256[] calldata _StartTime,
        uint256[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    )   external payable
        isGreaterThanZero(_Owner.length)
        isBelowLimit(_Owner.length)
    {c_0x6396809e(0xcb2a69142d19ed28529096339b567e95b85dc075525384b8925ba52b1128e21b); /* function */ 

c_0x6396809e(0xa4965f312d09f1cac5b2776c720c12790a5c634358bd346ad84b6358578b7044); /* line */ 
        c_0x6396809e(0x1f1c11b03712f168171ebd8336a399e4e638db11380b78d25b984a10420c3e75); /* requirePre */ 
c_0x6396809e(0xb8ac042d0b96102dee081bd7be38b677d337a9d4be0b4e69499d2cf665c575a7); /* statement */ 
require(_Owner.length == _FinishTime.length, "Date Array Invalid");c_0x6396809e(0x6b78d93826e61710bb716ee38c802e70c98666c19be368601f800e9d63ba0d62); /* requirePost */ 

c_0x6396809e(0x45e7bce4ceb0f3f200962bfdc5e51a0aa7abc39d16431f9a1d7a0ae5784e27f3); /* line */ 
        c_0x6396809e(0xf0b2d098de756229c7dfadfe0246b244efb43ffa7599c84d34dd3118c176c8ef); /* requirePre */ 
c_0x6396809e(0x6a8e5e8b3f90e881044b49c02eb0054e5d4695951fc1f5751dd1ee07aa8e07df); /* statement */ 
require(_StartTime.length == _FinishTime.length, "Date Array Invalid");c_0x6396809e(0x3e7b632024a1958344085db4940c250f40e8190ef6e75b5e54b9bb661f855e55); /* requirePost */ 

c_0x6396809e(0x8b353c4875e9dd6d45e8883bdac63cc1811ce3a56aef64d927c8d4cbcd0002bc); /* line */ 
        c_0x6396809e(0x75f16e7867f7d3ea4a3bb74f7350fa58a8cc25949f68fae3758af54f32adcde5); /* requirePre */ 
c_0x6396809e(0x0eec1428ca8d597e58a63e4ac44af20d6f12f843a561d16fc5696c4d01bc9ab4); /* statement */ 
require(_Owner.length == _StartAmount.length, "Amount Array Invalid");c_0x6396809e(0xbec30e6fec4ece12eb743827cfa54e6f76f7e3190017c5e5031c021ae5f03a56); /* requirePost */ 

c_0x6396809e(0xb10d9e749b36ffecb853e8a0b567cbf5bcc8913f22b3dc2e003363ce17883bc3); /* line */ 
        c_0x6396809e(0x00e71182f12ce430306e946eccceff02685502c4c7fa630ea3fcb89fdc331f0b); /* statement */ 
TransferInToken(_Token, msg.sender, Array.getArraySum(_StartAmount));
c_0x6396809e(0x66cc44036d7240c8cab70b336f73c09b21340d940e5ab5ef7bc4e7d7779bc35a); /* line */ 
        c_0x6396809e(0x799a19503f4496391fdeca0e110f06c16ce7b9ba7c9e85fe253f9b9a3dea03a4); /* statement */ 
if(WhiteList_Address != address(0) && !(isUserWithoutFee(msg.sender) || isTokenWithoutFee(_Token))){c_0x6396809e(0x04e9bef9237724e8bb18372b9665ce5e47541f5b563c6b53ec29c140e752eba1); /* branch */ 

c_0x6396809e(0xde7174ab594f3433c42c26b0cbdb9bfbf555b4de8c230b6cab334f7cf8c3a6c2); /* line */ 
            c_0x6396809e(0xd0f98bc24663f36851499d985eb48e6fc9c335558ea0c9a5e9c97132748f54d9); /* statement */ 
PayFee(Fee * _Owner.length);
        }else { c_0x6396809e(0x8649d3d4db53b93906d2ff3ee39369b57d7de1a804ad9325153115402300a8cb); /* branch */ 
}
c_0x6396809e(0xfe13955692599f71c8181e22e5a68401c68e0f988d5fb74cfc026d0df745d39f); /* line */ 
        c_0x6396809e(0x0fd782652b45e6c8f4d5b8c3a9f83c12539199a82f8ede5d5d7ff6e2a9b5f3f6); /* statement */ 
uint256 firstPoolId = Index;
c_0x6396809e(0x9e5af45db624505618c90a9c5e002c52d1a2db3707ec7c1af68af0af8f1bc5a4); /* line */ 
        c_0x6396809e(0x2960e5f0378e3951b7242345ed07ef2d4c9859ea1eea64d48a931335ad062ec3); /* statement */ 
for(uint i=0 ; i < _Owner.length; i++){
c_0x6396809e(0xba6a1512d52b3bbf4674d985c464272894a7765fc47c6d472397f82e28f1a074); /* line */ 
            c_0x6396809e(0x40d896b25ea1b9cd95b152cc620266a90eb4746fdf41266f4b3e0b3fb32cd893); /* statement */ 
CreatePool(_Token, _StartTime[i], _FinishTime[i], _StartAmount[i], _Owner[i]);
        }
c_0x6396809e(0x6468f5adca656183ca59bd8f649012352533d8c087a688ce5f5d2f5b693ba0d9); /* line */ 
        c_0x6396809e(0x85b4a8cf25d086f9609e0fa01660cf60e7e9778bd7a716e7f408ba47ee80d0c5); /* statement */ 
uint256 lastPoolId = Index - 1;
c_0x6396809e(0x3b5ed2a858721df2cd00fd287790387d9ed2600d14e17ff2256d3990d4ee5840); /* line */ 
        c_0x6396809e(0x50becb26a17b2eaf3bac045b3fc70679b65f401dd531ac3ee79ed03b729ccdee); /* statement */ 
emit MassPoolsCreated(firstPoolId, lastPoolId);
    }

    // create pools with respect to finish time
    function CreatePoolsWrtTime(
        address _Token,
        uint256[] calldata _StartTime,
        uint256[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    )   external payable
        isGreaterThanZero(_StartTime.length)
        isBelowLimit(_Owner.length * _FinishTime.length)
    {c_0x6396809e(0x45652519f31f7587fe60200da797d014f2d8c5abcf061f847503eff810e9fc76); /* function */ 

c_0x6396809e(0x4397a11159cf5e9ec105609121ee3572d1d918aaafcdb52432c13df87389d2b8); /* line */ 
        c_0x6396809e(0x5914c9ab580bc37eb747ed3a6d4bfac41bc38b8bbffc7b60148c06a73304e777); /* requirePre */ 
c_0x6396809e(0x249aa9dc2cb79b8cf481ba675a0e782362a6a772ecab42ce432f2ff9be094618); /* statement */ 
require(_Owner.length == _StartAmount.length, "Amount Array Invalid");c_0x6396809e(0xe32151d4a1ee2957dc03134c8833b3cf8dcd9139ce975ba52e1a5f2e96ed224c); /* requirePost */ 

c_0x6396809e(0xdd8b97f5173d0034c38587da39399367c6af5c71970c3033f9569958dc1659a7); /* line */ 
        c_0x6396809e(0xb28cb6076d1b7fcdaf263bb11f636d7440447f25019a4aae8848e7cddce05410); /* requirePre */ 
c_0x6396809e(0xf32794842dfac92c7ef57640572095302c4db3d3ea4a87253816d235803e2428); /* statement */ 
require(_FinishTime.length == _StartTime.length, "Date Array Invalid");c_0x6396809e(0x1dccfcb71aa43aba35395cc63b2ff262d42eaa67121a7a5fed170cb2891b55cd); /* requirePost */ 

c_0x6396809e(0x4f3cd3a6f44d13ba566b686ca0570bf3dd00a0f969f7486588ef10906373b008); /* line */ 
        c_0x6396809e(0x3ee37f97d434bd3d5bfd780cd5a3768a403501c572ebe84eb161d355695c30f8); /* statement */ 
TransferInToken(_Token, msg.sender, Array.getArraySum(_StartAmount) * _FinishTime.length);
c_0x6396809e(0x98a5f3ee832635f9ab6dbf057ec231a3f64de5ed1861ab51beb2d0133dc4b8b8); /* line */ 
        c_0x6396809e(0x13d397c9121e489ec710bf6e408f511d1188812eacb74b764a9d49b3c646132a); /* statement */ 
uint256 firstPoolId = Index;
c_0x6396809e(0x5d49c13dca9d0cb1641be65cde4a54c00d1c39d7c72ad3d7694103848588ea17); /* line */ 
        c_0x6396809e(0x79ba093e6e3d675009de8efe4122cb31dce86d0752122ec89744d9e5e126aa1a); /* statement */ 
if(WhiteList_Address != address(0) && !(isUserWithoutFee(msg.sender) || isTokenWithoutFee(_Token))){c_0x6396809e(0x60f713cd13e102f5c06a0b6713d0a4616ac5ae92930f8fbaa0fa8a0f0f4f0280); /* branch */ 

c_0x6396809e(0xa39ba933f0484af8f4202a8e6ebf3eb0638e682724e406e7fc682ca4d9cdfb86); /* line */ 
            c_0x6396809e(0x8b134e1f0bd9c0357f9041bf28871fd6545ce606fa6c36f44bc8c2c8efd35c4c); /* statement */ 
PayFee(Fee * _Owner.length * _FinishTime.length);
        }else { c_0x6396809e(0x57c843cda7162ba44a60083ee491ecc5de7cf52ba1e18275d8deb07869d29f17); /* branch */ 
}
c_0x6396809e(0xc31a4936e447196f5a4cf916edf69bca57dcd7f549730a80964f01554b114c70); /* line */ 
        c_0x6396809e(0x6b1e32058a99fed6246d94e152f6a22556d0046bb0ddf42459e87368d12f5d24); /* statement */ 
for(uint i=0 ; i < _FinishTime.length ; i++){
c_0x6396809e(0x32fdb9c9aa204962bceece82038b1b161d7dd09c53aecc859eada8c6b3184525); /* line */ 
            c_0x6396809e(0x68599acf953b7db6024310c2851e10ef2f9bb39c7630411c2a4568e781161b27); /* statement */ 
for(uint j=0 ; j < _Owner.length ; j++){
c_0x6396809e(0xda6a607aa75edf6bf60bedf148214fa53c62fe695a8160de5d560f827fd7f322); /* line */ 
                c_0x6396809e(0xb60dcaa905c49abcafeefb33f4844522a65658c47ff60245e6e1d5c4f0b3d6eb); /* statement */ 
CreatePool(_Token, _StartTime[i], _FinishTime[i], _StartAmount[j], _Owner[j]);
            }
        }
c_0x6396809e(0xd5d2fa21d12eb8965a8ef995ce724d9a8069bffedce9d2ce0b26f3b309d78ec3); /* line */ 
        c_0x6396809e(0xde0e483aacf128759f1d1408e19752559b844b20406a51e3dc50acf1fc3b613a); /* statement */ 
uint256 lastPoolId = Index - 1;
c_0x6396809e(0xab3f98b9c5bc123500fc15ed0efc5d407ec9f4c9374f192853e8b4a33c13be50); /* line */ 
        c_0x6396809e(0x829dcea8a48ce1f9e44bdc3facec91743ad6d2e6b15637a332565a38b1af0d90); /* statement */ 
emit MassPoolsCreated(firstPoolId, lastPoolId);
    }
}
