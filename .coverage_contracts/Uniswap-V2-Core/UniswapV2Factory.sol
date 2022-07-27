pragma solidity =0.5.16;

import './interfaces/IUniswapV2Factory.sol';
import './UniswapV2Pair.sol';

contract UniswapV2Factory is IUniswapV2Factory {
function c_0x9ee3b9c2(bytes32 c__0x9ee3b9c2) internal pure {}

    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter) public {c_0x9ee3b9c2(0xb46948493f4614d333d4812d1d4ecb5e27f6e0d638dc18aeac4ccf736913ce2a); /* function */ 

c_0x9ee3b9c2(0xa8f44152f721f943f0446211650cec76091f33e10763b9f766db483c2867c177); /* line */ 
        c_0x9ee3b9c2(0xec7064c99b8aa76147dee65f913d27ac4d73bb598d00deda5fec79805d66f544); /* statement */ 
feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {c_0x9ee3b9c2(0xd0dfd35f8a6057431e5a392f77b806bc7f69a061825bf91bb06db1440b170ae8); /* function */ 

c_0x9ee3b9c2(0xb6616a7ac57b3fa3ccb37ae1cfa0ccd8e50421c31846cc253ace50a72123f320); /* line */ 
        c_0x9ee3b9c2(0x7bc8550c6c75886554950530c1e7a4aa711e63db904363049c63617947b5d48b); /* statement */ 
return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {c_0x9ee3b9c2(0x8b243e5514daf21a695e533972c5ffea6f8e03ce95be3a48e4eac8731530b05e); /* function */ 

c_0x9ee3b9c2(0xbc515e658d63477baf15ed764b99449ab587fdae4490345f5c431b54d9aed95c); /* line */ 
        c_0x9ee3b9c2(0xdfa65e59d1985ab0c49ebce02dbdb1fd66fd6f811cf9472d7b5713a0a926a91d); /* requirePre */ 
c_0x9ee3b9c2(0xc2554c2f7ba392196beeab2eced9372a0354c0e5905c2771cd757d3249b2c80c); /* statement */ 
require(tokenA != tokenB, 'UniswapV2: IDENTICAL_ADDRESSES');c_0x9ee3b9c2(0x33a1cae2239fc085584146eafc6baa613f78689a8f23bcbbf0fb732f4e30ed55); /* requirePost */ 

c_0x9ee3b9c2(0x0061de1037b6a5bf2c3e18c7c0c5fb52ac85c5493f56bbad36044867167151ad); /* line */ 
        c_0x9ee3b9c2(0x4a048e0d974b17f0cf5719fa57104b76a89d7be6e6e47db1f34cbfe205742cb1); /* statement */ 
(address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
c_0x9ee3b9c2(0xf647e749d9b41c9027621ddb0be038ac47466c98b19ea5021774bffd97d9e682); /* line */ 
        c_0x9ee3b9c2(0x5fa24237418f9f7dcee480f8e4e782058fe280d0857835ae81e123387971ab67); /* requirePre */ 
c_0x9ee3b9c2(0x268d1ff6ab446fd859f710185cab93d2f6e12cce34bf3d750859ed017ed5bb65); /* statement */ 
require(token0 != address(0), 'UniswapV2: ZERO_ADDRESS');c_0x9ee3b9c2(0xab2013cb9cf787666e9271d1a1ec2cb0a6300921d2b758d2971e2f3099e74429); /* requirePost */ 

c_0x9ee3b9c2(0x189f25835ada1b9b9c091de83ac6e007c4fb3a09609bf606e8425d14daaf9458); /* line */ 
        c_0x9ee3b9c2(0xef7dd54c4842a0e8b4cffda2b9a22b5aefc73efa0ab0ba2548590795dd946a27); /* requirePre */ 
c_0x9ee3b9c2(0xf16ca7edefbf1c1b18785c970faa0c4a2f8d22ae3e5c4bfa3bdebf71c9130049); /* statement */ 
require(getPair[token0][token1] == address(0), 'UniswapV2: PAIR_EXISTS');c_0x9ee3b9c2(0x9a0a56d1fb11848b1d22622da6486af521ac2d674b24c36a289040b1f2f0f4f0); /* requirePost */ 
 // single check is sufficient
c_0x9ee3b9c2(0x85a23f0715d565835c090bf84c4024248b5044ed00510b9368ca5ec0856bf443); /* line */ 
        c_0x9ee3b9c2(0xbbde02a5015cb2c31aedf7618cf3c1a171ca4949b6e45a0f4b6d7b4eef49783a); /* statement */ 
bytes memory bytecode = type(UniswapV2Pair).creationCode;
c_0x9ee3b9c2(0x1c833675a4bef79a597a0582c1a4bcf8b823c1f9d3a990bea6e507b496f0ad8e); /* line */ 
        c_0x9ee3b9c2(0xfdf63d3d615d098eae97138d18f9cde8891502669fb44d0e47c7eddef8198451); /* statement */ 
bytes32 salt = keccak256(abi.encodePacked(token0, token1));
c_0x9ee3b9c2(0xb62a12d3004891b69c90c914fa213d657a370f2daa86a5d4d0cd628b2bfd5022); /* line */ 
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
c_0x9ee3b9c2(0xebd91f2aec864f996c2fdf054a181d99b7cea1348914b2a87cad3ae86606d471); /* line */ 
        c_0x9ee3b9c2(0x8a6dbb1326b403222176a77615bd142e48b142b173159bffe3be3c5a017a9341); /* statement */ 
IUniswapV2Pair(pair).initialize(token0, token1);
c_0x9ee3b9c2(0xb0a78d259057a4089a671a91cc73e1508b90bc9245b8ae4a06a8ae998d1315f3); /* line */ 
        c_0x9ee3b9c2(0xb3f035a93055289359e56d030c0eee95bb03cbfcbe44115f82540d07f7ff64ca); /* statement */ 
getPair[token0][token1] = pair;
c_0x9ee3b9c2(0x3af1d1d7dc25fb9a402918a912ac1e309ca33df864e70edaa952e8d1fc1f7feb); /* line */ 
        c_0x9ee3b9c2(0x865f42003e53d3efc1a28e6ce54e9fa1a300e9ff2eea97eb289f300d3132f205); /* statement */ 
getPair[token1][token0] = pair; // populate mapping in the reverse direction
c_0x9ee3b9c2(0xd0affbb0cfdb568e05a1a0a62d2c5cfc1874271445bc54fde0917ea91bb42014); /* line */ 
        c_0x9ee3b9c2(0x1be4aa078a5c49418595df62bd12cef2afc0867bd72ed7163bd994aa9b089656); /* statement */ 
allPairs.push(pair);
c_0x9ee3b9c2(0x6b477ce2eeb28cdcc9f55a925a2673cf9110d3846703fd42a3eed88502fa4b0b); /* line */ 
        c_0x9ee3b9c2(0x34b75b83a861a620b7cf6fdcd5f4fabcc9c4c563fbccb92ab9504c8b0e635ddc); /* statement */ 
emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {c_0x9ee3b9c2(0xe1ac596911a345a9b6b8b9641a8374df89121641329b9dcbfc8ee959cd55f6ac); /* function */ 

c_0x9ee3b9c2(0xc69752e6e1c197559cc7202f28a9aa11097f8594ee2628a9762e14e326c8964c); /* line */ 
        c_0x9ee3b9c2(0xad6d226ebdacced6a0c38481886751e751cce30707bf3c4b52ff7bb58a6aef77); /* requirePre */ 
c_0x9ee3b9c2(0x7bf67fc0e422290759229c9a443115aeb60218c3919f89f64f7f9896f72306bf); /* statement */ 
require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');c_0x9ee3b9c2(0x76725b993d76279a01aadbe930ff68d08ccba735316a0fb09f4bb785cf15a7ed); /* requirePost */ 

c_0x9ee3b9c2(0x4a5ba0206fbeb754ce876db42b7eb133837d4d4c41b61f1a05df35cb224cb30b); /* line */ 
        c_0x9ee3b9c2(0x8ff358b5577e1eaa671106425db068f4eca7282c3392849a1d1a0424f16dfa13); /* statement */ 
feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {c_0x9ee3b9c2(0x66525d1f986c032d3d4add482f95ef9aa7e8a342d51c8da492bf57b58dae8051); /* function */ 

c_0x9ee3b9c2(0x246f43da5101991fe753aaa0b52d801ffb6d97b70214144e5f3d3f18b6c760ba); /* line */ 
        c_0x9ee3b9c2(0xe9ee63b5087445e7b66a6ffea24d21cccffddc92ae3a277e85d5029e009043e4); /* requirePre */ 
c_0x9ee3b9c2(0xd6435e146d04c7efd33ee4d751379a50fcce1d1965ac17a32d2d943f4807d531); /* statement */ 
require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');c_0x9ee3b9c2(0xa8f9fada7f49731d6e0b1a2eefbe7d11a65ffed190ab39db2257ea2ac70de7d9); /* requirePost */ 

c_0x9ee3b9c2(0xdea40211a7bca229dc181178308ffeadc7032544740bea5c3d916fa4eb14b8fe); /* line */ 
        c_0x9ee3b9c2(0xca7b960e899007521d4f5a8d4394c9efa2ecfacbe0c6db827801373cbedacfe4); /* statement */ 
feeToSetter = _feeToSetter;
    }
}
