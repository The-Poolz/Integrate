pragma solidity =0.5.16;

import './interfaces/IUniswapV2Pair.sol';
import './UniswapV2ERC20.sol';
import './libraries/Math.sol';
import './libraries/UQ112x112.sol';
import './interfaces/IERC20.sol';
import './interfaces/IUniswapV2Factory.sol';
import './interfaces/IUniswapV2Callee.sol';

contract UniswapV2Pair is IUniswapV2Pair, UniswapV2ERC20 {
function c_0xcfb0a84a(bytes32 c__0xcfb0a84a) internal pure {}

    using SafeMath  for uint;
    using UQ112x112 for uint224;

    uint public constant MINIMUM_LIQUIDITY = 10**3;
    bytes4 private constant SELECTOR = bytes4(keccak256(bytes('transfer(address,uint256)')));

    address public factory;
    address public token0;
    address public token1;

    uint112 private reserve0;           // uses single storage slot, accessible via getReserves
    uint112 private reserve1;           // uses single storage slot, accessible via getReserves
    uint32  private blockTimestampLast; // uses single storage slot, accessible via getReserves

    uint public price0CumulativeLast;
    uint public price1CumulativeLast;
    uint public kLast; // reserve0 * reserve1, as of immediately after the most recent liquidity event

    uint private unlocked = 1;
    modifier lock() {c_0xcfb0a84a(0x250025a84047e9c000f775d3c6bf6194a6b9b0250dea93f436d91a8cfb0f7493); /* function */ 

c_0xcfb0a84a(0xbc959b0bd30ddaed6f1323f54f9e3548008c3fee4aebebd6deca03b9c9fa0324); /* line */ 
        c_0xcfb0a84a(0x55994f727a223c32d04b4dd2bfb964d465f228819bbd788dac93767260ad3bb5); /* requirePre */ 
c_0xcfb0a84a(0xca96f733c53913727cb4ebd65c7254d8be6e25d7fff6681de01de0f1aaddc71d); /* statement */ 
require(unlocked == 1, 'UniswapV2: LOCKED');c_0xcfb0a84a(0xfb77cc7502ddde7faadde047fa5aea16e9ecaf16b11614021b361527890d9305); /* requirePost */ 

c_0xcfb0a84a(0x3ff2eda6a7b299fd052a1f7684d00476cee639acd5fc176f05d2b9b33afbc234); /* line */ 
        c_0xcfb0a84a(0x26d5fcca1d771d427c482cf0199f640aa2fedeb24b7efd31f805b5d3a39c4824); /* statement */ 
unlocked = 0;
c_0xcfb0a84a(0x4f938dea8ae6a6e0e0562a5931ce7b0417cb9d53cd332666ed62700d111ce554); /* line */ 
        _;
c_0xcfb0a84a(0x838d1a0c9e32cf1e1f34e157af3dfe2c53b4bd7d2f6f1eb0e0124a9d06a9506f); /* line */ 
        c_0xcfb0a84a(0xa2135cfef09e11685211c3bfc3d10458b6e8ca42893f7f9514445611042267c4); /* statement */ 
unlocked = 1;
    }

    function getReserves() public view returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast) {c_0xcfb0a84a(0x11fde0109e8b279c0f4a32c4fb2978cf084084edf50473e5501267a8fcd81218); /* function */ 

c_0xcfb0a84a(0x217a8e9471febf48744e374499028f5b876f1cfa0e85baf9b882b7587b058b23); /* line */ 
        c_0xcfb0a84a(0x241b176bbb1bd8cabb918620629b690b0f0f285a9f336525f2bfdb01d78cfaf7); /* statement */ 
_reserve0 = reserve0;
c_0xcfb0a84a(0x38a62d529e0f021bb9eaef72b624a891284f2d88f331240b0472f6533c003a29); /* line */ 
        c_0xcfb0a84a(0x3c5bf7bc2c072dd502d7ce5310f5492ef86c131383b28239fd591e14d81ea565); /* statement */ 
_reserve1 = reserve1;
c_0xcfb0a84a(0xeea3ed266ca3e9ebdbb1012ee533b184f24823e106d990ad2b2d2bb3fb657974); /* line */ 
        c_0xcfb0a84a(0x81d45cbd7d507cb5c82c3b96f59bba72cc10ad8665d681dfec22337a20bdbcb1); /* statement */ 
_blockTimestampLast = blockTimestampLast;
    }

    function _safeTransfer(address token, address to, uint value) private {c_0xcfb0a84a(0x7c91c3759b5a39588b2ca8245713f5902e863ea36dd7cbdb24a93b7821522723); /* function */ 

c_0xcfb0a84a(0x3a849fcf94cc1824df3b7c6024622bacc233033f4c14ee5e805f59675af481a3); /* line */ 
        c_0xcfb0a84a(0xee39bc2abb2456550025b0e8ef306a9a1fe5a5ab4fbf763fd3001d8d950b4b04); /* statement */ 
(bool success, bytes memory data) = token.call(abi.encodeWithSelector(SELECTOR, to, value));
c_0xcfb0a84a(0xa995f4a5867f68f75207c238baf7a41d629910f42d3f4818c8ca850d0db60297); /* line */ 
        c_0xcfb0a84a(0x2e6559bebcdc210332f8223baeaef8b8eec8176c4df977f242defa2832a7e38c); /* requirePre */ 
c_0xcfb0a84a(0x295bbb212145334b7027372b6912ff4246a62c5728d97a51f795f2f35174382f); /* statement */ 
require(success && (data.length == 0 || abi.decode(data, (bool))), 'UniswapV2: TRANSFER_FAILED');c_0xcfb0a84a(0xf8ddf03511d55697474835108178379463b1c52b126ea455bdefc5e5ee9f85af); /* requirePost */ 

    }

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    constructor() public {c_0xcfb0a84a(0x4b78590ec9ef086568d15d9f9a018e0112a238514d64f632e4ef61c0af919bf2); /* function */ 

c_0xcfb0a84a(0x4165008a364431ac51bb90fb108b333499a60cb490f19d972df5a6f22e9b0515); /* line */ 
        c_0xcfb0a84a(0x90fcad93d54326311beb0cea35ccf4d8647ba0eeec3365ba1747c193b10ed222); /* statement */ 
factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {c_0xcfb0a84a(0x54e1dc1138c6dcfb960d3e4900dd7f07143775e8b04c68a14a5a72b3419f2b27); /* function */ 

c_0xcfb0a84a(0xdc81c294d07a8702cda7d96f4d472cdd816197c56e2c5a2c2481cec6bd5405ca); /* line */ 
        c_0xcfb0a84a(0x860e77bdd567b091d57245f04d4bfc5e65239752e2ab6dc47323ba8755fcf4a5); /* requirePre */ 
c_0xcfb0a84a(0x9cd636615dc8d13164e6664da1c5a785984b439b9f546900d8039922cb6a0a5f); /* statement */ 
require(msg.sender == factory, 'UniswapV2: FORBIDDEN');c_0xcfb0a84a(0xe30ee8f88b0ac36b97956d2cf698946651fc5a414ed463139e612a8c8cf79240); /* requirePost */ 
 // sufficient check
c_0xcfb0a84a(0xa2a410df38eef0f09df995af103b1b46471675fc0fc4ceddc7d509048687c0a1); /* line */ 
        c_0xcfb0a84a(0x1b831ec350ba8d57da6bcba62ca605eee811f742d3db01e424d545fab74fedd4); /* statement */ 
token0 = _token0;
c_0xcfb0a84a(0x915b8cb1089e95da8af9df300fbb8115be02133860977c597e6c61b1ee648610); /* line */ 
        c_0xcfb0a84a(0x7c6ab089697f53f552075b6eb3d82dbba466580242ce22c2c3114ffb9abdb1ef); /* statement */ 
token1 = _token1;
    }

    // update reserves and, on the first call per block, price accumulators
    function _update(uint balance0, uint balance1, uint112 _reserve0, uint112 _reserve1) private {c_0xcfb0a84a(0xc6fa0fd979ffb1a69038800488fc56a0c9cac22f24cba9cb530b2b07c0dc94ad); /* function */ 

c_0xcfb0a84a(0xefc272a213862187797db0d55b81b74603bb6b521361ae71bc61fa95f60209b8); /* line */ 
        c_0xcfb0a84a(0xce75d836b0ac7f7637cf2184c9bcc2f98638274d1d8e948b54a77f5de5b4fabf); /* requirePre */ 
c_0xcfb0a84a(0xcff19e74ffd1c72bad86c84e22a67cd8fd1e17131a8dff816742fe7eaad1a07c); /* statement */ 
require(balance0 <= uint112(-1) && balance1 <= uint112(-1), 'UniswapV2: OVERFLOW');c_0xcfb0a84a(0x30fb793b99041ea837aa9aca6a5b48ded9bcb4bbaa7439e35d259c6c4cfbb694); /* requirePost */ 

c_0xcfb0a84a(0x289612a51317f36e36560b3b94246e15cdca289cfccba2736cb14e3e5ec19133); /* line */ 
        c_0xcfb0a84a(0x00f72bea7dc3e51a0c30ce5265e3611b991d919527a6eded2ebf40d437630d63); /* statement */ 
uint32 blockTimestamp = uint32(block.timestamp % 2**32);
c_0xcfb0a84a(0x1595c820b9c47d719a72cac20c5077c1afa1aea1da6f19fa5dc963549683875b); /* line */ 
        c_0xcfb0a84a(0xbb77aa571edb5f9611ce593c64f2bd71b4a59b236303b9d0bac5344c3f14b5c0); /* statement */ 
uint32 timeElapsed = blockTimestamp - blockTimestampLast; // overflow is desired
c_0xcfb0a84a(0xe97fc2dda0d90a62aec0b620dd7f65f91d52cb55a72d7ac8fe9cd7719d747928); /* line */ 
        c_0xcfb0a84a(0x0315ad4c4be05ff22a0df00f4e6b87136fa051935240a36ad225a2631500b0bf); /* statement */ 
if (timeElapsed > 0 && _reserve0 != 0 && _reserve1 != 0) {c_0xcfb0a84a(0xb27e8b77dfe46b21504f635bc444bc9d8d25815e9b9aae39f4efd8c304f3a52f); /* branch */ 

            // * never overflows, and + overflow is desired
c_0xcfb0a84a(0x5f0059945febc7d0d3f3bbf91103141c730f1e699c8a2b87df1d7ba75ed19acd); /* line */ 
            c_0xcfb0a84a(0xf847d7810b4968386fdf83e484c5309de1f3a48f726275c7dd98b2ac467a941b); /* statement */ 
price0CumulativeLast += uint(UQ112x112.encode(_reserve1).uqdiv(_reserve0)) * timeElapsed;
c_0xcfb0a84a(0x57e5310e2dcb07a07b22f856c5a2dc4890dd7175eef21d5eb631c7c46f2a1b11); /* line */ 
            c_0xcfb0a84a(0x06bbe1998a4f01da944587510c332c128783a24c666607561d0df6a01532ec50); /* statement */ 
price1CumulativeLast += uint(UQ112x112.encode(_reserve0).uqdiv(_reserve1)) * timeElapsed;
        }else { c_0xcfb0a84a(0x35c2f4d1a269a2358adcf4c7eb94be8f993f1534df8311a1acfba0f0397f280f); /* branch */ 
}
c_0xcfb0a84a(0xf73e421b3cb5bb60d0c7dc1aec7cf1dd1bf63ae0c6f04bfa12aa35232f16e7b0); /* line */ 
        c_0xcfb0a84a(0x9b6543e0a73a59242ec44f46baae2a7b6147744da399a9fbb1cc0c78a355b06a); /* statement */ 
reserve0 = uint112(balance0);
c_0xcfb0a84a(0xe63eb0d8472f045edffbc400b2f3312fb1c083f1d87c26151f94773a34ab1ff3); /* line */ 
        c_0xcfb0a84a(0xdcdea5b2788ccaf1b5994430a171974240a34467951d63eb4f0499543ee4e890); /* statement */ 
reserve1 = uint112(balance1);
c_0xcfb0a84a(0x7c7687e064b43dcd68c8eaed013b48bbf8fbdf6ed072ef226de311af8bb0a1db); /* line */ 
        c_0xcfb0a84a(0xa36007a7c478d5aa54114260c7dcda71b5a00453417b09c14170bfd3c841dcdd); /* statement */ 
blockTimestampLast = blockTimestamp;
c_0xcfb0a84a(0x07d979593a5080bac84801a73096db2f68e2bfc94e4f35d573ce50b68cf386de); /* line */ 
        c_0xcfb0a84a(0xb523c7ad7578524ef4548a5da533be93d15267d31ed661de3953fc76f59f97fd); /* statement */ 
emit Sync(reserve0, reserve1);
    }

    // if fee is on, mint liquidity equivalent to 1/6th of the growth in sqrt(k)
    function _mintFee(uint112 _reserve0, uint112 _reserve1) private returns (bool feeOn) {c_0xcfb0a84a(0x8e747dfd08ec5e02932cb3c92ab4335ac319f8a47a56feae7d02e5926c8bd3d9); /* function */ 

c_0xcfb0a84a(0x4cb6a773d2b4e8a45986c53be9ed8bf123bf6ea8e817e197bb6b63517a69b8e1); /* line */ 
        c_0xcfb0a84a(0x9c7454f9cacbd590eb7318b18360da89285bee9b5a8218941757d367dc8d873c); /* statement */ 
address feeTo = IUniswapV2Factory(factory).feeTo();
c_0xcfb0a84a(0x0ea3004937f209f9cb148eb053e05a11bd51a8b896b8fc4b50aa1bb911260504); /* line */ 
        c_0xcfb0a84a(0xac4022eec318453d1d6c23ef9ebdcd6bcf0ec41044ff4d3e4031e03957ae3776); /* statement */ 
feeOn = feeTo != address(0);
c_0xcfb0a84a(0xd971dfc2c55d732cf546c3921bf368f01189861cf83ce4a67cec23fb915c96e7); /* line */ 
        c_0xcfb0a84a(0x495f2024038d4f25a80a5f46e5e16b040439cf76c7edad2af8f3dc4fabb187d4); /* statement */ 
uint _kLast = kLast; // gas savings
c_0xcfb0a84a(0x9a5d636e7d424f6e1876f26ac8260274f53e72a9bd27832e5e5b663b05223ce6); /* line */ 
        c_0xcfb0a84a(0x7b12e89de48b64c3ff475857a3ab7bbf601915402dcb624395dde6590cef93f1); /* statement */ 
if (feeOn) {c_0xcfb0a84a(0x27581e0de91214bb0dc25444779b3ec518faa55ad58d73e6fc91c2d75a3a10c9); /* branch */ 

c_0xcfb0a84a(0xa9ffedd2df912887d6f16e385c8a1172f2487d3d8c88fbc50495b2eb8dffbb5c); /* line */ 
            c_0xcfb0a84a(0x20d90833f5ad4ffb5b2be35fbdd825fd26cad201238970335ce586d9154b863f); /* statement */ 
if (_kLast != 0) {c_0xcfb0a84a(0xb81495eee63d27093154c0df90f4ad55ec37864e33c58d5226c4e63a52600d1c); /* branch */ 

c_0xcfb0a84a(0x8d809ac0bfd1a771223abc487a8d06d2ee7d033c51ef4dcdfc0917b72ba90fae); /* line */ 
                c_0xcfb0a84a(0x78b2921bacc0ee33b1e206ea2f1a9d794223569ca60a5f75ca07faee514f36ab); /* statement */ 
uint rootK = Math.sqrt(uint(_reserve0).mul(_reserve1));
c_0xcfb0a84a(0x2758f4b33d5283ea0bde1c25bff6f76e9b58dac6fcf7af4ed895d9815e3255c8); /* line */ 
                c_0xcfb0a84a(0x33c8a875722ced8558ea5be5b64d5ff35d2125378c50f3e0c1ec9b815b3061ee); /* statement */ 
uint rootKLast = Math.sqrt(_kLast);
c_0xcfb0a84a(0x80db45885835666bb2017c5b2a5b6dd41be20e9c22c26dda927a10177a656733); /* line */ 
                c_0xcfb0a84a(0x3827d50b35545f3ef104ca291e25f5e65a171e240b3e3528fe4686b2ceeded6f); /* statement */ 
if (rootK > rootKLast) {c_0xcfb0a84a(0x8b9a1e595cb7713469dbc03f288df684512f01ad3a96bc54e803152cb574b9e1); /* branch */ 

c_0xcfb0a84a(0xabe12a63ec6041760e2422bd7617d7a75773a42c08efd8bdad3b7d0863479da8); /* line */ 
                    c_0xcfb0a84a(0x0b281ae835977e4564449cad50febd4ba8b3b189242984f7444edd4895576efe); /* statement */ 
uint numerator = totalSupply.mul(rootK.sub(rootKLast));
c_0xcfb0a84a(0x9d7d8c506d218fcc48315c9822af7536f5f8f553cbe6095bd57490a3cbee5698); /* line */ 
                    c_0xcfb0a84a(0x0269d3b420127640de9e8c57b05ca2cc1ee67c39eaab78445468c6bb2ab61105); /* statement */ 
uint denominator = rootK.mul(5).add(rootKLast);
c_0xcfb0a84a(0xefc0ea6f20560c6c68498a36261ac6ca9943cf8550a812691b5a052f4726bf97); /* line */ 
                    c_0xcfb0a84a(0xea36edc387352b5e9b5377e3b34037b21e1caac12c1ea5f237b44eded81fd9ac); /* statement */ 
uint liquidity = numerator / denominator;
c_0xcfb0a84a(0x5c8de3cc0d11a7f261586c2dc5713b75270b6343a241e9c370c971348a9ddef0); /* line */ 
                    c_0xcfb0a84a(0x02308903ca7f92b671d8c6b5ff8a212927406f897fb2f581fee9a697d5c8dfa3); /* statement */ 
if (liquidity > 0) {c_0xcfb0a84a(0x57948ef01aee25b76ee80dbf2075b8478df0de52b1d93d50cd22e318e52c2ace); /* statement */ 
c_0xcfb0a84a(0xa75e659164eccacb715f56a6a8854e6bffaa9e757d2119ea6ff5ac7c0364b9d3); /* branch */ 
_mint(feeTo, liquidity);}else { c_0xcfb0a84a(0xa7e2d23ae9d1ee8f56dcff73ecc38794971ab897ad5a6324e6fd64fa0b9b2f72); /* branch */ 
}
                }else { c_0xcfb0a84a(0x45d3258eae1c149b7a3d35d73fe06d774cb676b9743d1a20a85dffc7487187e5); /* branch */ 
}
            }else { c_0xcfb0a84a(0xcc383d183a0b424d534294c5d730ccb85e15165e49e5e334df431d8383e711d5); /* branch */ 
}
        } else {c_0xcfb0a84a(0x53dd52260c1f95142856342dd8aeda8b1bffb7b2d113282959e055a1a843a1c1); /* statement */ 
c_0xcfb0a84a(0x42172ba892f819e52c07cd21340cf0cc07c60b1cbe33358b07170d4b40976815); /* branch */ 
if (_kLast != 0) {c_0xcfb0a84a(0x4ec91b656b690a7570632204e20c1ee2abfd68769a0255fb7cc618ba3d5bff73); /* branch */ 

c_0xcfb0a84a(0xa33f86f78969f91da9e9dc483240e695df4f5ad47105d4a6d7f22cf3b646c14d); /* line */ 
            c_0xcfb0a84a(0x9ac6008ae20fa0732e2e67576ef9f7fde61a342a953df9cc34c20549ae77de48); /* statement */ 
kLast = 0;
        }else { c_0xcfb0a84a(0x15b2c8de7ea23fa639b403e6a75da25693ac8dd473963f13cb76f0d28919a8c5); /* branch */ 
}}
    }

    // this low-level function should be called from a contract which performs important safety checks
    function mint(address to) external lock returns (uint liquidity) {c_0xcfb0a84a(0xffb995e2cedbd66a5a2134dc736f4633bfe764ff26469c800f589e15095f18e0); /* function */ 

c_0xcfb0a84a(0xc0615382e8e8d88868113abaf30c0c33b3eb2b52e91a1049a4c705ab2aa20004); /* line */ 
        c_0xcfb0a84a(0x2953b496b7b2e3369b1a506e473e143454aecc65e0e34153ca8192c606451591); /* statement */ 
(uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
c_0xcfb0a84a(0xb2b2a1bff40f96255b9695661e4e42d94fcac8fbe11034042a4374f88d4abaf0); /* line */ 
        c_0xcfb0a84a(0x36f1cd91dfef69a1bf3b32acd647c2c2b85b9d8bd8a94ebc5ce532c943186b49); /* statement */ 
uint balance0 = IERC20(token0).balanceOf(address(this));
c_0xcfb0a84a(0x72d03460e7051a91c041a291ab196faa370a0131ccbb929ef0723830ca87a6e8); /* line */ 
        c_0xcfb0a84a(0x4bbe0c664899e3e0571e9ac49439b642a0261a11082b8986dfc1cbdc1829a00a); /* statement */ 
uint balance1 = IERC20(token1).balanceOf(address(this));
c_0xcfb0a84a(0xc36c5881c97160a5278866c388fce404102f677e8c007ba80a909349d1a04562); /* line */ 
        c_0xcfb0a84a(0x4d6bae5c318d2046cbcc3df8f98f341582987cd0cc81bd26c740d179d31385ed); /* statement */ 
uint amount0 = balance0.sub(_reserve0);
c_0xcfb0a84a(0xd90a888c1cf3d19b246776f277264cfbab23d25bba6984bedd442b259e9aafc4); /* line */ 
        c_0xcfb0a84a(0x46c966bb41d16332b78b907c879afecee4faa41debc79094233db4d4e6178c78); /* statement */ 
uint amount1 = balance1.sub(_reserve1);

c_0xcfb0a84a(0x9c90e8b10fda7a039ea17db6ce06ce7e086cbaa78901336f68402e58e9b26aea); /* line */ 
        c_0xcfb0a84a(0x3f33906d9356b5a8df527aafd7c2a44ee62c21432233d0e2f44445eefd4ac17f); /* statement */ 
bool feeOn = _mintFee(_reserve0, _reserve1);
c_0xcfb0a84a(0x06828a68ca4d21546df0adcf3b0baf4ebac0294ee4ad68425f24e19b0cb70350); /* line */ 
        c_0xcfb0a84a(0xbaac2d98801a7875a11ffa0782e346fdd077c8f7e3884bcddfbbb00dc67e06f0); /* statement */ 
uint _totalSupply = totalSupply; // gas savings, must be defined here since totalSupply can update in _mintFee
c_0xcfb0a84a(0x6bae7fd269e0b106244570d4ff8a351bb9a85714de20c518f102b992813d18ac); /* line */ 
        c_0xcfb0a84a(0x74e5db256d92be75809f277aee009c9e9add526a4b290f8e741848ba60465e75); /* statement */ 
if (_totalSupply == 0) {c_0xcfb0a84a(0x64df77ff63f076a065f1b43af5121be9b57e41d27892c1f833f3077cce80f55b); /* branch */ 

c_0xcfb0a84a(0xdbdfb6e96f022612887422dda2d1a564863cf1f61c1a860a3429dc52aac5d0a8); /* line */ 
            c_0xcfb0a84a(0x4148829a981389fc7d902ee6207f87a5ae242da421d40c9d96c60b8c3c2139cb); /* statement */ 
liquidity = Math.sqrt(amount0.mul(amount1)).sub(MINIMUM_LIQUIDITY);
c_0xcfb0a84a(0xdc938b7fb2661c792fe28d0c055c0b4d9c8eba4033f117f2c633a5d16780c02c); /* line */ 
           c_0xcfb0a84a(0x480bdbd3d9cf70f386bc71168d9ed47d0e2875d92b7185d661416ce67f3231bb); /* statement */ 
_mint(address(0), MINIMUM_LIQUIDITY); // permanently lock the first MINIMUM_LIQUIDITY tokens
        } else {c_0xcfb0a84a(0x917f258b4ebadee2e1025a5e331eb7dcf9d74b867ea5f35bc0a7041334426bf8); /* branch */ 

c_0xcfb0a84a(0xe8e0674599e853c91e3df4bc3b2de361a136b6be8974be6e15d0b8802d365360); /* line */ 
            c_0xcfb0a84a(0x26fed55fb6da1d907b4d3aac146670599def5e9cf0ad63ba3aaaf703f68e110c); /* statement */ 
liquidity = Math.min(amount0.mul(_totalSupply) / _reserve0, amount1.mul(_totalSupply) / _reserve1);
        }
c_0xcfb0a84a(0x0cc621677bab3bd2666687a6bff02517d12974f88b218c66b93dcc0481f855ce); /* line */ 
        c_0xcfb0a84a(0x01a42bf61be350849f657e2b5cfec41368a6c06c117a99948eea10b61d5b8c74); /* requirePre */ 
c_0xcfb0a84a(0x4bc5a745c285d49ab2c35d665c4b0f8cc978c95f966edf86b9e48e1c7d09debf); /* statement */ 
require(liquidity > 0, 'UniswapV2: INSUFFICIENT_LIQUIDITY_MINTED');c_0xcfb0a84a(0x865597143f793593d0775a2ac321021953fc966e86616c5eb1de4b1d1507fc67); /* requirePost */ 

c_0xcfb0a84a(0x94ee640d0c97dc56fd14a2a4898eb05fd1677088ab980d10fdc6dc63005a10ca); /* line */ 
        c_0xcfb0a84a(0xb58321be7bfdeca9d638694fbf8b57b6a06cb24ed054f59f221bd07e2cac6ec6); /* statement */ 
_mint(to, liquidity);

c_0xcfb0a84a(0xc313c57e05a0ff3c0841b177c94c43c5a1eee20918ab27a1c0e5aa16aa51a0be); /* line */ 
        c_0xcfb0a84a(0xda075e23fd5de354ee1b2ac58a3b93e6fdcd9f947104c26a7a688a9f801f3f6f); /* statement */ 
_update(balance0, balance1, _reserve0, _reserve1);
c_0xcfb0a84a(0x5d9a8271100eb333680ef79a1fc3e6eab5fe67b8c3e37ab5cc20b03901815746); /* line */ 
        c_0xcfb0a84a(0xd9f40ab46340ac3009d5dee41eb9c6b6375444081d2bc4269a7abbd5950e3b90); /* statement */ 
if (feeOn) {c_0xcfb0a84a(0x8b17328c7e43a2e69c39f553aa1e195885bc5cc48e19b69d1827132af163b459); /* statement */ 
c_0xcfb0a84a(0x16d6f8a229a96915574b78597962e81e5d78592c37262dc5b2496e0fb147fbc7); /* branch */ 
kLast = uint(reserve0).mul(reserve1);}else { c_0xcfb0a84a(0xbccf287183227840f5f6a594292f5008c4e512fe54047100d874888790f1ae57); /* branch */ 
} // reserve0 and reserve1 are up-to-date
c_0xcfb0a84a(0xdf55a2440af0f0812b054b855c1d77d837d0da9ade708747b496c7f5f68aab47); /* line */ 
        c_0xcfb0a84a(0x6331f2cf551dd90755928617ec3a53a450d3cb78d3b700c51c3bdfb9fcd56bf8); /* statement */ 
emit Mint(msg.sender, amount0, amount1);
    }

    // this low-level function should be called from a contract which performs important safety checks
    function burn(address to) external lock returns (uint amount0, uint amount1) {c_0xcfb0a84a(0x77881efcfc43f80670c81573ef0a6c841b1f4c0c58618aa633d55c4183793b48); /* function */ 

c_0xcfb0a84a(0x026556c726c9d4405d37ae5f010c1fa3212e53e38e8c94b586fad626fe31656c); /* line */ 
        c_0xcfb0a84a(0x68b634611f418cb9eb6212a051d743c01f0201f456c5aa3426ecad805c20fd04); /* statement */ 
(uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
c_0xcfb0a84a(0xce5ba860e3bd7956606adb17042f2ceab3cae7c9211300ed2b68fe65fd1b6b19); /* line */ 
        c_0xcfb0a84a(0x0989e956e751093264eb630657454170877b71e7e4fb7585c935f39572a0437d); /* statement */ 
address _token0 = token0;                                // gas savings
c_0xcfb0a84a(0x5dfa9c57f76fd33ae9df902bdcc9e50ebd23ef83fb3334d6e0e922a7fe427373); /* line */ 
        c_0xcfb0a84a(0x5b6a32e96736a601377cafa7679d6eaf1f6a7e880a4c31c426dc2e6a876a69c7); /* statement */ 
address _token1 = token1;                                // gas savings
c_0xcfb0a84a(0xbdaaf0cfa715a9dc92fa4a334e4fedae08acf358d822b1e23327741d65530beb); /* line */ 
        c_0xcfb0a84a(0xb0696c5d7a0e6cb96fa8575e47bca7043685a64edc702c2802e7ec00df143132); /* statement */ 
uint balance0 = IERC20(_token0).balanceOf(address(this));
c_0xcfb0a84a(0x504059e868a100a071f1262b69febc7da9123ca1992491ebd8faf0707fb43a47); /* line */ 
        c_0xcfb0a84a(0x6eac5d91e5375c746d281ae6c24897126541a4aae6745ca294a7f9033891ee85); /* statement */ 
uint balance1 = IERC20(_token1).balanceOf(address(this));
c_0xcfb0a84a(0xd40ac3cad25c5ea504725317550570806bac8cacd860d10cfb230a292bf9e6f0); /* line */ 
        c_0xcfb0a84a(0x26fc46902df3e679e465183c76e60a61c292c518802b87495c611aa3dab74ad5); /* statement */ 
uint liquidity = balanceOf[address(this)];

c_0xcfb0a84a(0x5e9617380fcdd2349bc3e81005276bf4cdbd72a434d467f82a330b8908c56250); /* line */ 
        c_0xcfb0a84a(0xa785bc855fce2aa3fde18167ffe9f2220a16c2f16ff609b790fdd25d3ed458fb); /* statement */ 
bool feeOn = _mintFee(_reserve0, _reserve1);
c_0xcfb0a84a(0xef437eb551e65aa72868ca04cc9229c65ab6ddd0c5f925e46954f19a2ebe6052); /* line */ 
        c_0xcfb0a84a(0xa0be92aef252793383a8fdedd5911c046aa2778e2e3dc552f320b6091c141b27); /* statement */ 
uint _totalSupply = totalSupply; // gas savings, must be defined here since totalSupply can update in _mintFee
c_0xcfb0a84a(0xa85582677e8376b197d28abb74d754b754329d26ab06f36f997dfb966ebf19fa); /* line */ 
        c_0xcfb0a84a(0x55af28bd2557a5dab2dc581831ac15864909ce4ae89a43ffc34f7e4bd2947b56); /* statement */ 
amount0 = liquidity.mul(balance0) / _totalSupply; // using balances ensures pro-rata distribution
c_0xcfb0a84a(0x652d367887520bc36abcf410e69344864dc8534d50549fc8d12bdf2706dd1fc7); /* line */ 
        c_0xcfb0a84a(0x972a991473aa77918dc01944fc8998aec58c1ef79fdde34a92ecd15cb665db3d); /* statement */ 
amount1 = liquidity.mul(balance1) / _totalSupply; // using balances ensures pro-rata distribution
c_0xcfb0a84a(0x6acf06c14ad0713bd5df2c5a99d5efd1bbec02045ca2e7a5930b39caca5b28db); /* line */ 
        c_0xcfb0a84a(0x58a387dac1d7c4127be8dcff96fbb874b552a900035b8eb26cce1ea930ef0d51); /* requirePre */ 
c_0xcfb0a84a(0x7cbc1b85cd1d24e70653340583315c0000b81681b226cb37d579ae07675dbc27); /* statement */ 
require(amount0 > 0 && amount1 > 0, 'UniswapV2: INSUFFICIENT_LIQUIDITY_BURNED');c_0xcfb0a84a(0x7da95f88c0e8c3d5f0dc552c0cefe0a07f225e8774ac14b734978182a0a5f590); /* requirePost */ 

c_0xcfb0a84a(0xdcba0f16cdb2da20ec851b1d3db6290102d2d7908274c8ce8153abc729f076b8); /* line */ 
        c_0xcfb0a84a(0x07dd9c251c83996325614493b979c91129bb00e304a1e09eb6055d05d16b5b72); /* statement */ 
_burn(address(this), liquidity);
c_0xcfb0a84a(0xfb8c720acd2ec879d8973bc2e770fcabe4bf11fef990bddea415c49064bf9ec2); /* line */ 
        c_0xcfb0a84a(0x52d21e8474c2ecbf2d47fb8fef4f8f756cf69ed7abb0eb966f50c957fb29fff6); /* statement */ 
_safeTransfer(_token0, to, amount0);
c_0xcfb0a84a(0x5e187a4716055e2bdd8514089b54b92d7c4c38089667a7320e1d82236ca20d1f); /* line */ 
        c_0xcfb0a84a(0xad7484967b5582847c977d01c0b1d9b2a1cfafb1756a45247ab915abe026e545); /* statement */ 
_safeTransfer(_token1, to, amount1);
c_0xcfb0a84a(0x4eed5ef48cdf76a8d6d6376000dbb91049bb446239f534426f917dcc0506cb34); /* line */ 
        c_0xcfb0a84a(0x07d24e2c6e6c163694fb5013300e72273a7c0c67d3063081801c86f748e4be24); /* statement */ 
balance0 = IERC20(_token0).balanceOf(address(this));
c_0xcfb0a84a(0x9cb6e8d9ce6a3730549c0c4aacec1d937b16e7063abe9a951f4ea382c02aa6ab); /* line */ 
        c_0xcfb0a84a(0x9618b63e838da3f6549b09864707c5d43a9370d7f33e26b02a8324c1d1a4b971); /* statement */ 
balance1 = IERC20(_token1).balanceOf(address(this));

c_0xcfb0a84a(0x46dd271961ea51e37fa349cfff1440f880de202ed7796b978afe520c78151753); /* line */ 
        c_0xcfb0a84a(0x8ec81e2dd216de012b0f32bab6788ac93d1d0bf9d3102a80ba96a2d4d8f865c4); /* statement */ 
_update(balance0, balance1, _reserve0, _reserve1);
c_0xcfb0a84a(0xe223ef70eb6b97cab63277cbd8a7c13de57735e33a06c7741bba68fe14e76243); /* line */ 
        c_0xcfb0a84a(0xdb8836ea5bb4d43beb6e0c5b699b5efe330a379131dc732bb2a7f1b683b6e196); /* statement */ 
if (feeOn) {c_0xcfb0a84a(0x51ab52f8290247f4efaa54c41e908139d181169e09d1d301e44b7f864924114e); /* statement */ 
c_0xcfb0a84a(0xc44fa95d5a920593283d564872e5f58fdde09a95a27dc7212a0603da4d793927); /* branch */ 
kLast = uint(reserve0).mul(reserve1);}else { c_0xcfb0a84a(0x4b5708e5226b96b2de79d915b74aa86d9b05300569e25a0ea5efb585061ec9a2); /* branch */ 
} // reserve0 and reserve1 are up-to-date
c_0xcfb0a84a(0xcea00add9f3cd2cca4db084b84030f651408f4a9cc36d941f6593de79db52328); /* line */ 
        c_0xcfb0a84a(0x5b58f5aa0e21991ce83f5978f0f7688e5a9a3ec685f8340093fb9650539a3ea5); /* statement */ 
emit Burn(msg.sender, amount0, amount1, to);
    }

    // this low-level function should be called from a contract which performs important safety checks
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external lock {c_0xcfb0a84a(0xbd4e937aba46cc6f86f51fca5cffcd6be3534ffdf9dcef384070dd13e5f5abca); /* function */ 

c_0xcfb0a84a(0x08fafb17fe6d9f1f8c172372984eade2984e9ca531be95b547adacbc8086cbd5); /* line */ 
        c_0xcfb0a84a(0x973199ec07dcf9c9fe23682a4163f98469b94402d831d875211bf7fa27bcaff0); /* requirePre */ 
c_0xcfb0a84a(0x90ea52e3b3053f64e289ce00879e9f8274abcb49266387458ad48147967b7b8c); /* statement */ 
require(amount0Out > 0 || amount1Out > 0, 'UniswapV2: INSUFFICIENT_OUTPUT_AMOUNT');c_0xcfb0a84a(0xf50702be69c0e702e12e8648ab7c20090903a72b6af934f43daea732fc843eac); /* requirePost */ 

c_0xcfb0a84a(0xef7dec8c034e6c0ac2bd81e45433746835feb6ae46abd1efe657b4fe9268f3d9); /* line */ 
        c_0xcfb0a84a(0x185b5f41e27c994d44145bbd3dd5c374968359452e3f066e538fd3299a25ad30); /* statement */ 
(uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
c_0xcfb0a84a(0xf70913d8c1e48a523fdc29e1f8762abd349be00c15d45464b024b824191dde7e); /* line */ 
        c_0xcfb0a84a(0xb475247ebc0801329b5d182b965740f0589bb7b5612d786099f1ea581e03d9cf); /* requirePre */ 
c_0xcfb0a84a(0x72df4c3d96453b43c8fcd423a4b7cb5ead8dc05261e57867f6cda8a5569caec6); /* statement */ 
require(amount0Out < _reserve0 && amount1Out < _reserve1, 'UniswapV2: INSUFFICIENT_LIQUIDITY');c_0xcfb0a84a(0xe1a64137ed954c74508dcd5c44909c56fe47a125b73341378a13a86e27bca9cf); /* requirePost */ 


c_0xcfb0a84a(0x58de28c338bea95e906bed4f147658844711bda38829875802a73b9728cd4f14); /* line */ 
        c_0xcfb0a84a(0x6b9ac80894ad7322dcdfe796d4ac864961271f667c938e88556cef649bd1e104); /* statement */ 
uint balance0;
c_0xcfb0a84a(0x2cbaca11c38fcf576e173ab596b21782049f85e577b4075f07d68b77d0059db0); /* line */ 
        c_0xcfb0a84a(0xaf4263ad443798fd1bbd55b19c206228038accd733af3b4f7cddc78b8ff132dc); /* statement */ 
uint balance1;
c_0xcfb0a84a(0x6db9eae9d49a82700b8cfeda33f24511f6025e50edf5a7f7a42f05060c6a4e94); /* line */ 
        { // scope for _token{0,1}, avoids stack too deep errors
c_0xcfb0a84a(0xbea9a182e28c8cf80e92e760d9200fffa83ba3358add3fd6ec2e2f211bc417f5); /* line */ 
        c_0xcfb0a84a(0x587cc4a6cc881764259c79406126295f65086899374371c9a26e8de6f2a690ba); /* statement */ 
address _token0 = token0;
c_0xcfb0a84a(0x6102a2ed1d1da3a9b2ae064bab70695328cc4bc50d98caa160adcf835c440bc6); /* line */ 
        c_0xcfb0a84a(0xae40731da44bb22e4647a1e99a21d48d90693102a1a89a329c055f51b0f90c1f); /* statement */ 
address _token1 = token1;
c_0xcfb0a84a(0x4193ef232fc6d548e6b52bf7ca892d65e1031fd4829b3b11542fad558ba1b5c7); /* line */ 
        c_0xcfb0a84a(0xf87a117ab7270f7ade9893a698eaea32231d9021f406f3172c95e5ed3ed925fe); /* requirePre */ 
c_0xcfb0a84a(0x1e911c70f133c75e7021e531ea7617d8d7c40c3502ac6c3c925908a693fee8a8); /* statement */ 
require(to != _token0 && to != _token1, 'UniswapV2: INVALID_TO');c_0xcfb0a84a(0xfa222d42aac69d0d15549e9582ed03fd23d8c0f347f7fb712bc416aa91a42359); /* requirePost */ 

c_0xcfb0a84a(0xe068439168a7d7ef8ff46eb15876c6c4958cb395923c93314c6922344f7ca4bf); /* line */ 
        c_0xcfb0a84a(0xe7a751b1c79d7d78cde064dc69a7cdb6ed1491a3b2a2dae1ba8b5acfd25e3ae9); /* statement */ 
if (amount0Out > 0) {c_0xcfb0a84a(0xab0173a96283db0f5012f04ac9aa7bccf109b20494028fae8162ab27a7ed9cf6); /* statement */ 
c_0xcfb0a84a(0xb4b16f46802f8102141d9f2fa9a72b6fa0828f28025815740a531154513d2e99); /* branch */ 
_safeTransfer(_token0, to, amount0Out);}else { c_0xcfb0a84a(0xf0d78929130e4a4c786f5b94c93021ed9108826c9b00820408ae5b7ebd9990c7); /* branch */ 
} // optimistically transfer tokens
c_0xcfb0a84a(0x24f4eb2dac52e3679a22c4a8aadea55be0077c2131513f508db06bbc6ee2095f); /* line */ 
        c_0xcfb0a84a(0xc3e1c22fd757fde59dbff1782392ed4a7f9be62d916e682c111d057015bd564a); /* statement */ 
if (amount1Out > 0) {c_0xcfb0a84a(0xe9795d1ca34729d5db94a1f559c21d1c63da148705e47b84c4b49021a71e4923); /* statement */ 
c_0xcfb0a84a(0xc08067293a743634c3833b4dc87dcf9a231468935fa7ea6b3cc8cd17ff806187); /* branch */ 
_safeTransfer(_token1, to, amount1Out);}else { c_0xcfb0a84a(0xc916724384c996807ac134d067c6c5cb725f66908033174a240086cd5a64f1e1); /* branch */ 
} // optimistically transfer tokens
c_0xcfb0a84a(0x7b50f8cb5c048ce68c17545822f5890c0b7a557427a5205d786a555a597c3cb9); /* line */ 
        c_0xcfb0a84a(0x11f028763c6ac54b69901d83aa422a6117b1ebe3a910e88c54aae68a0d816aac); /* statement */ 
if (data.length > 0) {c_0xcfb0a84a(0xd8cce4bd216dcd1fc65f9dbd673e5d8df994e73276e2815a0402a04a3aa450ce); /* statement */ 
c_0xcfb0a84a(0x1fa46eddedd826d1728cd44139b77d0a1bf595c5bdfc0c4fd4f788ce82bdb790); /* branch */ 
IUniswapV2Callee(to).uniswapV2Call(msg.sender, amount0Out, amount1Out, data);}else { c_0xcfb0a84a(0x902db4dfd8dd03e9c53c6fc9b0951844ad20b1d4006a0a2237a6b448556a1aee); /* branch */ 
}
c_0xcfb0a84a(0xb8ed6e0387b7e6cefb91de262980c532067b5200e6f683504873dd920a554efd); /* line */ 
        c_0xcfb0a84a(0xf1d7e7ddda9ce0247fd84c24b4981f999be99ac2d4ea5d1f83c682825986e191); /* statement */ 
balance0 = IERC20(_token0).balanceOf(address(this));
c_0xcfb0a84a(0x24f2c085fa918dd59dcbe8f33c65273e1dbe11bb0d11a28bc217e95b3f3bc394); /* line */ 
        c_0xcfb0a84a(0x4e9b4918b2dcc46c3060952529467dde375cdcfeaef0e67759cd821876e71049); /* statement */ 
balance1 = IERC20(_token1).balanceOf(address(this));
        }
c_0xcfb0a84a(0x3717106e7d91832c1425b331f11ead05234db789473d8eaeadaf7a286e89c9b3); /* line */ 
        c_0xcfb0a84a(0x73d5d74a0aa6d85af81cf779741e967c25696e6f278e882c2af913ca41bd03b5); /* statement */ 
uint amount0In = balance0 > _reserve0 - amount0Out ? balance0 - (_reserve0 - amount0Out) : 0;
c_0xcfb0a84a(0x4cb4005848f1414a3911ae73aff246539eff88aa83e3efb096da45a6de8428e6); /* line */ 
        c_0xcfb0a84a(0x7e1ecc92b297fb644c12e95414f64f03f1fffeec4fc0c6c8e5180edf8b9da886); /* statement */ 
uint amount1In = balance1 > _reserve1 - amount1Out ? balance1 - (_reserve1 - amount1Out) : 0;
c_0xcfb0a84a(0x9b5a51e69b43a65b116cf52ae78ab4418ef524868434bc41ae1023239583af2d); /* line */ 
        c_0xcfb0a84a(0x83ae8a3cc31099d6651dde14f6f8bedd8cb0f0327303d6dcf8bfc5e296dac93c); /* requirePre */ 
c_0xcfb0a84a(0x2bf27c1e1917a6de83c8a3539e516dd54fd0ea5213dec2fee23d5abeab61f12e); /* statement */ 
require(amount0In > 0 || amount1In > 0, 'UniswapV2: INSUFFICIENT_INPUT_AMOUNT');c_0xcfb0a84a(0xf489aa790cd046d3cd4a8183cc80e8ac1af086e15f22e0caeec53e1d19d90b9b); /* requirePost */ 

c_0xcfb0a84a(0x2cf38151b61881cde160fb84cacd747c646907ec87149f13ec0b430494634cb5); /* line */ 
        { // scope for reserve{0,1}Adjusted, avoids stack too deep errors
c_0xcfb0a84a(0x46e332a589aab3e6da9157989adf01f4cfb1b610e0bb1797c9e987eec91edf37); /* line */ 
        c_0xcfb0a84a(0x16ee340686d325c6c8906effcc77930754d0b8654c09f34c25470a218aad463c); /* statement */ 
uint balance0Adjusted = balance0.mul(1000).sub(amount0In.mul(3));
c_0xcfb0a84a(0x119372357898f48aea922e9b1aa92d8d39dec4de68fa59f689eb20fc00fe2e9d); /* line */ 
        c_0xcfb0a84a(0xfa780711d272769f35071066b9048b3551337911d0cb99d72be82667015581a0); /* statement */ 
uint balance1Adjusted = balance1.mul(1000).sub(amount1In.mul(3));
c_0xcfb0a84a(0xd2f0b25a31777739e758477f79ec2a0bddc827c2eef9f011cf94a7d961fdaa98); /* line */ 
        c_0xcfb0a84a(0x71d88d6c76ffd1658c8acc2519921c9088dc7b37779a58a003be80720b4016bf); /* requirePre */ 
c_0xcfb0a84a(0x5796cc2ac1eedb9212d9b30a127b81ed80a0150cd9a3a3173b45a7b024a34025); /* statement */ 
require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'UniswapV2: K');c_0xcfb0a84a(0x32da8eda526532a36178249936fb8d334dc22a0f73275eff77e9b4e879c93ad2); /* requirePost */ 

        }

c_0xcfb0a84a(0x090901643a7f0a8ec9168b5f3b37fe34b696718ed7e0121f38a13095e8b5f069); /* line */ 
        c_0xcfb0a84a(0x4a051278cf0d39a8a870f0d95c0df840b90a1b2bc66f8b5975415b823fba46eb); /* statement */ 
_update(balance0, balance1, _reserve0, _reserve1);
c_0xcfb0a84a(0x08c54452781134ae4a0e518d873f492433e5def31605f71d4c838f0881643ebe); /* line */ 
        c_0xcfb0a84a(0xa7480a09c961f319802364f8475e2e7575091e17cb3cb09dc7a5fcb87f4503f6); /* statement */ 
emit Swap(msg.sender, amount0In, amount1In, amount0Out, amount1Out, to);
    }

    // force balances to match reserves
    function skim(address to) external lock {c_0xcfb0a84a(0x486e8b4460408d5ded0b5e3f1e7a8d4657b2e9ab45a984a016a272b94fac0e48); /* function */ 

c_0xcfb0a84a(0xa2dd4888500aa6af576820157fc95c2b5b9ce28c32eda05ae9d897be69b452ee); /* line */ 
        c_0xcfb0a84a(0x51be73f0bae5cc948a3ad31be571ac064a1f485983e5a1103e122a4fa2d46efc); /* statement */ 
address _token0 = token0; // gas savings
c_0xcfb0a84a(0x85e721e427269c547bce327c66249124030d5f92392aaf0159399f26bde772ce); /* line */ 
        c_0xcfb0a84a(0xf868a2cb942e4b85d5433b47c2c1ab9613a9635d871557a88d392c775cce5a3b); /* statement */ 
address _token1 = token1; // gas savings
c_0xcfb0a84a(0x63914028a3a554b1b67291818bbcf4e9312d92c8cdbf1ed2542c23ccc9c93e01); /* line */ 
        c_0xcfb0a84a(0xf90d7f8189b8ca23b7596e33acad22492c49413f55c75a86a8897c3b6392128c); /* statement */ 
_safeTransfer(_token0, to, IERC20(_token0).balanceOf(address(this)).sub(reserve0));
c_0xcfb0a84a(0xa04152d2c156edb426a1c66f34b498b5169f0beabb31f1a26cf9eaa26cd69a12); /* line */ 
        c_0xcfb0a84a(0x732037684bc8c868548b97dd5ae4120df0c588d6ebde77a20d64a791c87da46c); /* statement */ 
_safeTransfer(_token1, to, IERC20(_token1).balanceOf(address(this)).sub(reserve1));
    }

    // force reserves to match balances
    function sync() external lock {c_0xcfb0a84a(0x159cba30458ccaeee4a2d66b70bb7b51b4cbd9953cdf4ece1350995b237c493c); /* function */ 

c_0xcfb0a84a(0x48519095cb4689a43e157ce780ed61fe4004de1255165d5277f6b1b64b2c152d); /* line */ 
        c_0xcfb0a84a(0x05ca804b3bf8aaee0291949ca37d3cce7523a89465134d55a8a0e1fd05697dba); /* statement */ 
_update(IERC20(token0).balanceOf(address(this)), IERC20(token1).balanceOf(address(this)), reserve0, reserve1);
    }
}
