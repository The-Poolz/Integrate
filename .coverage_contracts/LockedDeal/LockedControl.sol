// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./LockedPoolz.sol";

contract LockedControl is LockedPoolz{
function c_0xb034a66a(bytes32 c__0xb034a66a) internal pure {}


    function TransferPoolOwnership(
        uint256 _PoolId,
        address _NewOwner
    ) external isPoolValid(_PoolId) isPoolOwner(_PoolId) notZeroAddress(_NewOwner) {c_0xb034a66a(0xee3e1d82912acaa6cd9f983bbcbed079ae738c4fd8b892ee40c3bf04ad1632f6); /* function */ 

c_0xb034a66a(0x115aa48b8a1f90621fd57784ef15ddefd05b6c687e2d9ad5e607ee31315ed55f); /* line */ 
        c_0xb034a66a(0x3e2a061c92300c976705a5527d24783c302528b3cdf7359b44e5032bb9229dbd); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0xb034a66a(0xca826ee3f00876c17bc2f233ada623e7e9ad85dba722be65300eec6d0700cc2e); /* line */ 
        c_0xb034a66a(0x979941db674cb14b7f5fabd673ce8adc52932faca2e171eec389432606d42996); /* statement */ 
pool.Owner = _NewOwner;
c_0xb034a66a(0xc9242e46b9639fb08bb4ec187f8eb4c16d8e7c7ff5ee3098b29b8a98965ccedb); /* line */ 
        c_0xb034a66a(0x6c1f4cf5b0d5256d7b901029fdebfb6973cace7d32b5ed4e05d61106e5ff79e4); /* statement */ 
uint256[] storage array = MyPoolz[msg.sender];
c_0xb034a66a(0xb42da32bff9652da656e69b75bba77fba350bf946134ffcc6422ac987b2f628f); /* line */ 
        c_0xb034a66a(0x2e26e4ff810f9522d1df543bd8bb665a1a9cb0152bc1deb0fdd6cbdb06a2e5bc); /* statement */ 
for(uint i=0 ; i<array.length ; i++){
c_0xb034a66a(0xe1a5af7088cc2dc74578de9a8db73ffedd8af5250bcde07a72a9e12ff985704e); /* line */ 
            c_0xb034a66a(0x39f0426668394c6b958203b33b90a962e8210fce730e4044c5c84a7a46db79d8); /* statement */ 
if(array[i] == _PoolId){c_0xb034a66a(0x0d382712658bfdb4ca70194ac5b073f4fcf1fd642ad8d55f8716b3ea4cf751fa); /* branch */ 

c_0xb034a66a(0x7b424a874c0146e295485e86e96dc36f11a6c240569f63dd93a2da6260705dd6); /* line */ 
                c_0xb034a66a(0xda0753d40b28761b43d03789a1f45344f4f0765bd3ef3a94b53a7a89521c2980); /* statement */ 
array[i] = array[array.length - 1];
c_0xb034a66a(0x9535e60944daa2d3d4b7f62dfb9f40ea8801085d70584f7ba2e15abc23cd4a5f); /* line */ 
                c_0xb034a66a(0xdefefc27e5156cb3ad39d4476313beff8dcf8d36f09738027ca4a465af3da098); /* statement */ 
array.pop();
            }else { c_0xb034a66a(0x81efaa4c606ec42a17ee2d8a5ea87064732877d9bfad85694ff7afc1b69f416b); /* branch */ 
}
        }
c_0xb034a66a(0x6f3204521c0dcd2828ff2ae8a1129b56885b0ac8ba697511ba8d10cf65040d7e); /* line */ 
        c_0xb034a66a(0xb8018e0147396431960b3ad1ecc62104f5f418fd365b0d87c5d9dfa38d8e8b89); /* statement */ 
MyPoolz[_NewOwner].push(_PoolId);
c_0xb034a66a(0xd4be832c7a5cef2795ed497b9907618a71066ba2aaa703326d891ed2f2d59f54); /* line */ 
        c_0xb034a66a(0x76c5cf026d2f303875ceb631298cdce5ae126b28aedd9a6d64f1d288257aad5b); /* statement */ 
emit PoolOwnershipTransfered(_PoolId, _NewOwner, msg.sender);
    }

    function SplitPoolAmount(
        uint256 _PoolId,
        uint256 _NewAmount,
        address _NewOwner
    ) external isPoolValid(_PoolId) isPoolOwner(_PoolId) isLocked(_PoolId) returns(uint256) {c_0xb034a66a(0x88aa11816d6c7e109d2f7d453fe77e5a433e8ff373038bd5b484ed6ac7ee5dcf); /* function */ 

c_0xb034a66a(0xaaa460b6d529a645672e883f79126092a1715dd21c5233f2838161a494aaff2b); /* line */ 
        c_0xb034a66a(0x1f88d1417dc7c625069989c903706a6d85d6ee954e75c5d0c0f0054d7dfed4a3); /* statement */ 
uint256 poolId = SplitPool(_PoolId, _NewAmount, _NewOwner);
c_0xb034a66a(0xbacf3a83b44003b856300076c1748a131af6750ae8cce42d2702513c099abcae); /* line */ 
        c_0xb034a66a(0xb271f4ca889b9ce676a74d559d73eb06d3652814591fc13060c575d2838278f2); /* statement */ 
return poolId;
    }

    function ApproveAllowance(
        uint256 _PoolId,
        uint256 _Amount,
        address _Spender
    ) external isPoolValid(_PoolId) isPoolOwner(_PoolId) isLocked(_PoolId) notZeroAddress(_Spender) {c_0xb034a66a(0xb5ea24febd1ef70fe4e9556422ad6cda9b105461c5cc1f4ec05a97d8e775d2a2); /* function */ 

c_0xb034a66a(0xa7c4d1675b219b0b3a43e51fc2bb88713442c245140c9d1e1eca5bcdec569177); /* line */ 
        c_0xb034a66a(0x6b65b21634dbb92eecc041e5c9d4d680c52a687d802e496a980ae50873c3e081); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0xb034a66a(0xc5b4a5b8df68595616b0fab43ba0f4a601e9ba81d5b7b1ce051db354524e7b08); /* line */ 
        c_0xb034a66a(0x4f5ec0a66ee0580cb5ba6532056f32c43c9c32ec97e3ceb93b2e4fad68d531ef); /* statement */ 
pool.Allowance[_Spender] = _Amount;
c_0xb034a66a(0x7953102fb1f1edb84550142edec9666cb2e40433c19973b84be810105da3200a); /* line */ 
        c_0xb034a66a(0x26bf4e335413d2e83ae78291f2d63ddbe08afe16b2972691538d156638c5b740); /* statement */ 
emit PoolApproval(_PoolId, _Spender, _Amount);
    }

    function GetPoolAllowance(uint256 _PoolId, address _Address) public view isPoolValid(_PoolId) returns(uint256){c_0xb034a66a(0x5f9e1aa97ea16eccee171a21e75356198dd14cc9c292d7e7f8f5fb7e4682e53e); /* function */ 

c_0xb034a66a(0xf0bb75bbfac38ee20befa2893d39536608015979aaeb7057f4083ee337b4faab); /* line */ 
        c_0xb034a66a(0x20c3f9123d814f8a712765f677d1f81cccee9884108f5c99c968d0e720768850); /* statement */ 
return AllPoolz[_PoolId].Allowance[_Address];
    }

    function SplitPoolAmountFrom(
        uint256 _PoolId,
        uint256 _Amount,
        address _Address
    ) external isPoolValid(_PoolId) isAllowed(_PoolId, _Amount) isLocked(_PoolId) returns(uint256) {c_0xb034a66a(0x5b8b955fab13250c34b472d298b493e218fc4eb167eec0cbb1f618a6c88e0a15); /* function */ 

c_0xb034a66a(0x25e1fac41a5c1c436210b2e56a01062f55c616f1a48bb101cb7c704971334aef); /* line */ 
        c_0xb034a66a(0x4241f16c6d29f3bdb6af296c4ba38ffc13716fed1acbfe21e6feee4debdf089c); /* statement */ 
uint256 poolId = SplitPool(_PoolId, _Amount, _Address);
c_0xb034a66a(0x6103072e3080f1834094b88e24b903da89eaa7dac813cd6a4fb9125e83646236); /* line */ 
        c_0xb034a66a(0x9f0369a3fd8321b533cabbc29c3010ee4c262b4a81aa9a625e0872943722511e); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0xb034a66a(0xc3df1d20580181ce99428ae069a41c1ca746c2173c0091957855214ba2e34cc7); /* line */ 
        c_0xb034a66a(0x7973cc55f83d0bcbbfbd6f904884ffcb52361a72eb01f069c4d8e40b8b13f273); /* statement */ 
uint256 _NewAmount = SafeMath.sub(pool.Allowance[msg.sender], _Amount);
c_0xb034a66a(0xa4146a98145ad08c240bff2acca4cf7da863aa87ff0d5478054f6c4ab63820fe); /* line */ 
        c_0xb034a66a(0xb8849ad2fcf3933ea9791c2578af6dcdd5b50767f5fde179c800815430034c9a); /* statement */ 
pool.Allowance[_Address]  = _NewAmount;
c_0xb034a66a(0xb63a7e7318eb767bf3c0de87a5f89d18f2082d3a0ac8fcfe4302802cb8075f7d); /* line */ 
        c_0xb034a66a(0x2c7788476e695dd803906cfb12df7c452403cc1afb299a390357096a3472b0ae); /* statement */ 
return poolId;
    }

    function CreateNewPool(
        address _Token, //token to lock address
        uint64 _FinishTime, //Until what time the pool will work
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        address _Owner // Who the tokens belong to
    ) public isTokenValid(_Token) notZeroAddress(_Owner) returns(uint256) {c_0xb034a66a(0x950f651da76b092de1a43150e5d6d4e81e062889c53a04268ba61988cf2dc182); /* function */ 

c_0xb034a66a(0xf29d4a79a6563f626ce3e4da8c9cead738496197b54595d31a3a28d3d9cf1846); /* line */ 
        c_0xb034a66a(0x7122250ac5fb952891fef58c776a1fe6350d0fdf111ab908233876b426e67e98); /* statement */ 
TransferInToken(_Token, msg.sender, _StartAmount);
c_0xb034a66a(0x849fd1a429340769535b80122b0b9039b325c1404d29bc484cfa927a902bae4e); /* line */ 
        c_0xb034a66a(0x9e801059fd0515a816a77390adaa5eca0da528cb894dc4a3cf3dfe488ad23b72); /* statement */ 
uint256 poolId = CreatePool(_Token, _FinishTime, _StartAmount, _Owner);
c_0xb034a66a(0x4c61ea6ad3ca3aa4f387deed6e16dc434f12b23a4ecc607e8063e447a805c874); /* line */ 
        c_0xb034a66a(0x6a968acb0d917c1f7b9d0ab3cff44c83964b6e44d1f96d306e9e40ddf3cc08aa); /* statement */ 
return poolId;
    }

    function CreateMassPools(
        address _Token,
        uint64[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    ) external isGreaterThanZero(_Owner.length) isBelowLimit(_Owner.length) returns(uint256, uint256) {c_0xb034a66a(0xf7d320a5ca53b786d89fdd229ec2431e1514ca6954a8112b43237f2989660d57); /* function */ 

c_0xb034a66a(0xc4eeba9cce7a74a94689f26f267ecc958a4b9ea1d2caab58823bb75b7d0c8199); /* line */ 
        c_0xb034a66a(0x7435fd2cfff341613c8960e6581c7495fe8e18f01b6a36bf9aea05f7237b21e5); /* requirePre */ 
c_0xb034a66a(0x638f17513d8ab460394f005bdfd2dc8448815d95a497623f621d4081f8a37696); /* statement */ 
require(_Owner.length == _FinishTime.length, "Date Array Invalid");c_0xb034a66a(0x900fd8c0c6c34eb7049983ff2aebc3ac31e0f45fb77a09460c4a249cf3a2b078); /* requirePost */ 

c_0xb034a66a(0x1644e7bf6b48b25934acb64a41e5625e51bbb7b4761141132fe3220c23575212); /* line */ 
        c_0xb034a66a(0xe508635694da939017df7c91c5d92d3691742c6f46e02d0c7ef31fcc4353a3f8); /* requirePre */ 
c_0xb034a66a(0xc748cd08f96a13d48725a7b329cc360550644b2c154545d5bf5b32d813c279b4); /* statement */ 
require(_Owner.length == _StartAmount.length, "Amount Array Invalid");c_0xb034a66a(0xcd3814ceac51cd75e8b9dd66abfe499f6665bd2ab6b92eeac729113d16790d8c); /* requirePost */ 

c_0xb034a66a(0xd91c3cb8948210c8f11939846937e39f0efba2b79dbb6a4efa83e14541a863d0); /* line */ 
        c_0xb034a66a(0x9b3789c51b4ad33aa859caea6a03b27ef2d7d9b4664458be61bd0c1da69b1422); /* statement */ 
TransferInToken(_Token, msg.sender, getArraySum(_StartAmount));
c_0xb034a66a(0x34a67da14f683a43b77f153118aebe479ae8267bd0e4a6fedd35146a76904a41); /* line */ 
        c_0xb034a66a(0xd52f45aa1c4dbe65e715e0350bc2e14d9f948bb65987a5bbcf4d0210dc0e2a7b); /* statement */ 
uint256 firstPoolId = Index;
c_0xb034a66a(0xe80e64699442000503b0567d2af3017180b741abcab70542568ed99a8b7ec0a6); /* line */ 
        c_0xb034a66a(0xfea471c040ab212f326e84b0c9f47e3c5bafb5fe9e560ed99cacfc957fbe370e); /* statement */ 
for(uint i=0 ; i < _Owner.length; i++){
c_0xb034a66a(0xaeefc85b6aac4c60e7757342e5dc28300306d8d1d719e18a3fa2ee1ed70f8883); /* line */ 
            c_0xb034a66a(0x39c6768947b7f40aa09d86da8aea87c434b6ff019b19afb7aa479253d94751c5); /* statement */ 
CreatePool(_Token, _FinishTime[i], _StartAmount[i], _Owner[i]);
        }
c_0xb034a66a(0x63ea3c68f8d6793800d0119b9c6a22fe44afc225eff1e6f822f251dfe1a11b5b); /* line */ 
        c_0xb034a66a(0x066469461d0dc89ef91937eaeb10f2d1f5438d95219b828fd006ab4a31f52aea); /* statement */ 
uint256 lastPoolId = SafeMath.sub(Index, 1);
c_0xb034a66a(0x63ed3f92c7276d8901a245b4a47c131d2d3693b17cfb9c9c684363a5f0509df9); /* line */ 
        c_0xb034a66a(0xb8ce3786f3b105c6132b3ab0189004df94e6fab722d1de9409afd1bdf3f902aa); /* statement */ 
return (firstPoolId, lastPoolId);
    }

    // create pools with respect to finish time
    function CreatePoolsWrtTime(
        address _Token,
        uint64[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    )   external 
        isGreaterThanZero(_Owner.length)
        isGreaterThanZero(_FinishTime.length)
        isBelowLimit(_Owner.length * _FinishTime.length)
        returns(uint256, uint256)
    {c_0xb034a66a(0x51902c5216a81a5dad677fab3fe27bff5d60f37fe449f4377b5aa0bd50917c67); /* function */ 

c_0xb034a66a(0x3264576a5ca6e755d50ed5f216310ac35c44c6ddacf385acc980fdee6f212335); /* line */ 
        c_0xb034a66a(0x625ab21582566c0f0c14f5cf0d29c488346b67dba8621e1c37fd235cd76afd87); /* requirePre */ 
c_0xb034a66a(0xc46b481fa8dc16f06bb55ca59c61090b2dead7c237593e2b0560f408376aa73a); /* statement */ 
require(_Owner.length == _StartAmount.length, "Amount Array Invalid");c_0xb034a66a(0x461d17a8d257218888c1cbe4cbeb51a2b7a780d29497e6b237dbe5726b847868); /* requirePost */ 

c_0xb034a66a(0x351cbf3c34af87fc62cf6974b878e0c0dd8d065c02347dcd771e46b1a8d74928); /* line */ 
        c_0xb034a66a(0x3cd65decb7aee2065f6c98edbbd6cfb699278b7f0774e261520639187febf707); /* statement */ 
TransferInToken(_Token, msg.sender, getArraySum(_StartAmount) * _FinishTime.length);
c_0xb034a66a(0xd0f8af8edc8a90c22dcde45e09b653565af4efea8c6ef655f7b31b0f82180bb7); /* line */ 
        c_0xb034a66a(0xaf52a7cc2d68e9291fb4ba2d6a0943b8c338c30c9dc00d5c4152afa7dc2a63c6); /* statement */ 
uint256 firstPoolId = Index;
c_0xb034a66a(0x137b2403d64faefdc033c08d69d1ac6f6d296ac87218db951cf1c60da647c4cf); /* line */ 
        c_0xb034a66a(0xfb1b2ef4640fafcbbb5e878849f96510eb5e27d331752118a87382e73024da52); /* statement */ 
for(uint i=0 ; i < _FinishTime.length ; i++){
c_0xb034a66a(0x0ab9202514c8fe480bd974953d6ce4d1692b4c21bad962b0f125ddfa69a3b3c2); /* line */ 
            c_0xb034a66a(0x03d76ef7b02000a80bad5b6f7324b5bdc792a483e4f5c58cb42a916ab4416d79); /* statement */ 
for(uint j=0 ; j < _Owner.length ; j++){
c_0xb034a66a(0x28703d8afd95f702a5438dc003e8d44d16c36fc23e978100bab6b80f021841af); /* line */ 
                c_0xb034a66a(0xb2db8501951f7c8a27f90376c5a4c5ce412c17759a6be8e5cadeca8d182775ac); /* statement */ 
CreatePool(_Token, _FinishTime[i], _StartAmount[j], _Owner[j]);
            }
        }
c_0xb034a66a(0x1a40e69fae6456eaf29d3dc5b67140792af3c50af4c44c32a29aae842f24e559); /* line */ 
        c_0xb034a66a(0x05af7761be85d01f27f6d238d086758a431bcc1bfb46f8413e9c6a61d5fdb587); /* statement */ 
uint256 lastPoolId = SafeMath.sub(Index, 1);
c_0xb034a66a(0xb51c883d3e99b2623e263acddaed6568095874272c14a38a9150d19c2a05595c); /* line */ 
        c_0xb034a66a(0x1050824c960f9fc22552fffb8c4cb8ab4d6c68bb2afc517a5916377ec8f18346); /* statement */ 
return (firstPoolId, lastPoolId);
    }

    function getArraySum(uint256[] calldata _array) internal pure returns(uint256) {c_0xb034a66a(0xd74c7dad11e109356b6ddc22e9b6f3c51587442ef151b47d6e13c940e318565f); /* function */ 

c_0xb034a66a(0x5967092ff8578e2b64767e347529523262f8894b70dde11f0090a770c65e010f); /* line */ 
        c_0xb034a66a(0x1a3b433862fc733689bd561454c8f638201119f3be36eaa47bdaf2fe01a53331); /* statement */ 
uint256 sum = 0;
c_0xb034a66a(0x1c02b76bdb0bf1fc65eb113a77c0e2e13067a243b1e1b9715c0400c349d56576); /* line */ 
        c_0xb034a66a(0x7847c8b250070afd3e3e4fe4edc99e16594ff98814b33056e58bc7160216dd4c); /* statement */ 
for(uint i=0 ; i<_array.length ; i++){
c_0xb034a66a(0x87f19af018248590d88e0b9630e6988b792d8940116541a9d11e2a47fa01144e); /* line */ 
            c_0xb034a66a(0xeac02c0d97b04330fd823c581f6087826e2da6c4e7f64b79c9b6ea04fe1d5080); /* statement */ 
sum = sum + _array[i];
        }
c_0xb034a66a(0x72b5f3ba66014165d0c1c3b427dcf1063fa38adc2dfa6e1b7e02f3c751ef7162); /* line */ 
        c_0xb034a66a(0x5ac04b7a987099669d247e6944de69088e0f3642d53a915a140f77d0bbc344aa); /* statement */ 
return sum;
    }

}