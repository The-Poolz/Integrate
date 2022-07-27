pragma solidity =0.5.16;

import './interfaces/IUniswapV2ERC20.sol';
import './libraries/SafeMath.sol';

contract UniswapV2ERC20 is IUniswapV2ERC20 {
function c_0x209cf9ae(bytes32 c__0x209cf9ae) internal pure {}

    using SafeMath for uint;

    string public constant name = 'Uniswap V2';
    string public constant symbol = 'UNI-V2';
    uint8 public constant decimals = 18;
    uint  public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    bytes32 public DOMAIN_SEPARATOR;
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    mapping(address => uint) public nonces;

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    constructor() public {c_0x209cf9ae(0x90a25b1b86bce84885322ee85eede121393ec73502fab037369b0a19d1a30743); /* function */ 

c_0x209cf9ae(0xbe23583c8ef04ea6463edb8d135591795c6fdfa3bf46a403af8579be966c73f0); /* line */ 
        c_0x209cf9ae(0xa1daa11b956aa1d99583d1e304f7502e0efeb9eb306ce4da64fdbc7f2f4d6263); /* statement */ 
uint chainId;
c_0x209cf9ae(0x086018c86b17094a66112ab4f7c82b93a1c49ed6daec88c37775cee70baa9aa4); /* line */ 
        assembly {
            chainId := chainid
        }
c_0x209cf9ae(0xc1c5187e91e8700da630b8a70cece19cf92f68e801ef9aeec8e23930927cffde); /* line */ 
        c_0x209cf9ae(0x24ec39b31ee8d11f564babd47743d48490a48023a6bb1231cb4aa8daefa28aec); /* statement */ 
DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
                keccak256(bytes(name)),
                keccak256(bytes('1')),
                chainId,
                address(this)
            )
        );
    }

    function _mint(address to, uint value) internal {c_0x209cf9ae(0x95232fad8628486225ac9c341005d822652749dbb199ff94380a0136083886f8); /* function */ 

c_0x209cf9ae(0x46a955c334638bc4a555c9065875cbfa58f28d21615b810a7a6c74d4e089a001); /* line */ 
        c_0x209cf9ae(0x685952abe70de13fcc1b52fb18bf41e1a63d771d0a0866587809cd1eec3d8ade); /* statement */ 
totalSupply = totalSupply.add(value);
c_0x209cf9ae(0x2abe1513c2ac371fa34115d7a81311fb8572787ddafdaf8666d0ac4400d8e4a2); /* line */ 
        c_0x209cf9ae(0xf71e385fb7dbc5840f81f495e99cd0f2730eb1a96fd57ea9b534f35d6148da3c); /* statement */ 
balanceOf[to] = balanceOf[to].add(value);
c_0x209cf9ae(0xa95f2ee2c3c46133a0541388b7ea708c9541a5cce5e23b2a73247b1d9fde1c1d); /* line */ 
        c_0x209cf9ae(0xa5bc14b0e8f6eb0923df85ffb73575a4efab203b2eb7cfa1d2be43ff834cf476); /* statement */ 
emit Transfer(address(0), to, value);
    }

    function _burn(address from, uint value) internal {c_0x209cf9ae(0xbd641928acee82c3a75000ccc30e83d9cee16f75e2ebde8de988cd0d8992ffb6); /* function */ 

c_0x209cf9ae(0x4adc29db3d362505ac0d5f160b33143303972f449f9f20250627ad89f278e9db); /* line */ 
        c_0x209cf9ae(0x263ec9c611c087268f9ddddbf3bbc3d09193503c234c9f2dfc91ac3741e5a6cf); /* statement */ 
balanceOf[from] = balanceOf[from].sub(value);
c_0x209cf9ae(0xbd71dfcb71adb79a6c54e7f700e93f38c71f777bc05027771faf2ac9e5d41e96); /* line */ 
        c_0x209cf9ae(0x548a3abf9f4aa842fb6b85ed9baf169aa5240641d1383f55d7d80ee470ac68b5); /* statement */ 
totalSupply = totalSupply.sub(value);
c_0x209cf9ae(0xda8a2f737aefaeb3cd02839cba70714a2c8a866ebe37334dc1af3cf494a40630); /* line */ 
        c_0x209cf9ae(0xe9b2aadbd02e39d73d3879c224f619ef3b48be40382330860c9ebea1a366bcab); /* statement */ 
emit Transfer(from, address(0), value);
    }

    function _approve(address owner, address spender, uint value) private {c_0x209cf9ae(0x25c49d9b0bf2b3506208d40e24141542830b4f6a821c53afb204cf2ed11ac8cc); /* function */ 

c_0x209cf9ae(0x4eb71890e9a454076828b065cb34fb27cf51d7a48814581a1671c30d17c5ec6f); /* line */ 
        c_0x209cf9ae(0xf5b91220f32de0a6e5a0e11a423ec45190932ae4e12a72e3049b1d4151dcc63c); /* statement */ 
allowance[owner][spender] = value;
c_0x209cf9ae(0x01dde80a992686150f5dcd8cb2ff11c1376df0e6c0f3b9309f3ea918e8c77bb8); /* line */ 
        c_0x209cf9ae(0xa29d9b1c0d9ea899619ce92f55e60f2ab2ef6085893a8960a5b80187538ce572); /* statement */ 
emit Approval(owner, spender, value);
    }

    function _transfer(address from, address to, uint value) private {c_0x209cf9ae(0xd70f3286a9fec981159f32d2d96999df4f19518f9945ba14f016bae6e6da5771); /* function */ 

c_0x209cf9ae(0xdce9288623c68bd3e6a2988def8da5ead16d39aa6ae9e188bd82b7307a5d95a9); /* line */ 
        c_0x209cf9ae(0xad68db2e9f725afaee9d5a3cf55a2adc535ca3b0f10d564d94f53a97fd639cc9); /* statement */ 
balanceOf[from] = balanceOf[from].sub(value);
c_0x209cf9ae(0x633588ce6f3832ecdc8cbe1047c55fe7ab5445dacc8f3af4be56f3594b0c4ed9); /* line */ 
        c_0x209cf9ae(0x43b26815aad54fd43544798ca691b785ccbd4b732622cb01b56055b1c3a62b55); /* statement */ 
balanceOf[to] = balanceOf[to].add(value);
c_0x209cf9ae(0xdb8a4de5db6a9fbbf55659073384badd85a58eaa2f004e39778a59cdeed35bd6); /* line */ 
        c_0x209cf9ae(0x6f210ed15ec7f2600d5dcf3d93f97d6b29a447f2e2187b3e4454006957aa4cf1); /* statement */ 
emit Transfer(from, to, value);
    }

    function approve(address spender, uint value) external returns (bool) {c_0x209cf9ae(0xc6501581c42981fb476349500c6605a441e7422b6fc1ed541f0cee6825ef6324); /* function */ 

c_0x209cf9ae(0xb3b9a3fa67ffd7d1726594eaf958d965bedc3371bebc2b1a582f287d8861a671); /* line */ 
        c_0x209cf9ae(0x0c598bfa89629738e1b6ec12591baa241253d6beb647ab69fc351667c4a6743f); /* statement */ 
_approve(msg.sender, spender, value);
c_0x209cf9ae(0xcf035062a8ac520b3062e21669c53f170f098b6fe4f052e33384d0e4b533d372); /* line */ 
        c_0x209cf9ae(0xddf675932d5591def9907e2a70a561217fab3873fad2c8c67d9840418aab63d9); /* statement */ 
return true;
    }

    function transfer(address to, uint value) external returns (bool) {c_0x209cf9ae(0xb5e3085c1408a0a24420fa2b0b77d34f934160b63fea9149277b5823327309e0); /* function */ 

c_0x209cf9ae(0xca7bbdbe7c7665ab1515766863fae6a342933bae2f0f7799d406d6dc2582f70f); /* line */ 
        c_0x209cf9ae(0x2d03a60caf9c420655b635940acdb0cf3bf1993f6d81b8fcb7dfc83a3ef0a0df); /* statement */ 
_transfer(msg.sender, to, value);
c_0x209cf9ae(0x307d229104c648f4e63c50a13a61e3c5110eb519c009c49b4294116c104c13c4); /* line */ 
        c_0x209cf9ae(0xebca5812d92696024ed52b3a0eb89fe53d4f6f804ddac70d2f0fdcbaef6b7b5d); /* statement */ 
return true;
    }

    function transferFrom(address from, address to, uint value) external returns (bool) {c_0x209cf9ae(0xb38602114c590e4c06f4946f46c2323969ae247781fdfda99a498fabd709d757); /* function */ 

c_0x209cf9ae(0x0dfa3cde99ceaf043a5ef961ee43e6d0f817767d54e0d3eb9df14cddc989596b); /* line */ 
        c_0x209cf9ae(0x37218d516c35c16512f5ff7b093de85761f4ba68b27ba9d0af48cf44e7e6d08f); /* statement */ 
if (allowance[from][msg.sender] != uint(-1)) {c_0x209cf9ae(0x132957831047af177422801cb7a5295d8a70150fae15e520770bffe6237f411d); /* branch */ 

c_0x209cf9ae(0x35eb67440aecebeafefeaa0cb8c34830a6a5771f53cacb2d2412ddee055d8eca); /* line */ 
            c_0x209cf9ae(0x1b0e1437e95f9a9c78c82768a4754ef585a99596c04aea53259f28db6a295746); /* statement */ 
allowance[from][msg.sender] = allowance[from][msg.sender].sub(value);
        }else { c_0x209cf9ae(0xa8d57a24cd40a2ef75280f64fda565701d95a5954ca690dc95abaf810a7a08e1); /* branch */ 
}
c_0x209cf9ae(0xe80a2b981a366c82e3be0dbb89d7f13c5d292a5ef48d44d5898ece93b7259380); /* line */ 
        c_0x209cf9ae(0x9edac9b0def46d452605c8268c30adb9f2178a1776e22620a99d1f0e4bfe933b); /* statement */ 
_transfer(from, to, value);
c_0x209cf9ae(0x853cbd90c2f9ad737ae2523135d3f458798a66211228b35b1244cf2d1493ac9e); /* line */ 
        c_0x209cf9ae(0x178ece5baa174f9173e36cd46d8e8364cdf7800254a1958c720a2583044edbca); /* statement */ 
return true;
    }

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external {c_0x209cf9ae(0x35672987a2d561aba8bf2de4576b29a1185ca9bba0fa6e4505e6e7cb03d0961b); /* function */ 

c_0x209cf9ae(0x30d230fc99ed945eb56952ede54af5a80fb9c2f8354c8917db21cb3917751ac6); /* line */ 
        c_0x209cf9ae(0x085b4c42be0063956f731bd991c4b0b76694bded633d06c7e58bf94902dcf990); /* requirePre */ 
c_0x209cf9ae(0x15b43d0b375bd437b1bda3ad58d0a572ca71e1b9bef4b904ecc2b28615b4ac08); /* statement */ 
require(deadline >= block.timestamp, 'UniswapV2: EXPIRED');c_0x209cf9ae(0x95f01ca51619a29167edbffc75ae4b1437708d87c7b5e4457e3e6fa65fd480f0); /* requirePost */ 

c_0x209cf9ae(0x1d2708c97cfc40f8d0f4f8aad94c75bd674b5afd7f0bce0dcea218a0daeaac74); /* line */ 
        c_0x209cf9ae(0x232b8e7de7fda63d6255e68186a082e00fa7c32d0076d214cce478f9cc317fb7); /* statement */ 
bytes32 digest = keccak256(
            abi.encodePacked(
                '\x19\x01',
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonces[owner]++, deadline))
            )
        );
c_0x209cf9ae(0xdf816112809b1dcd6bda08dc821e1eaac5541f51d7ba030c9f104b874e35da4a); /* line */ 
        c_0x209cf9ae(0xf11f7a38fbaa331b061cff7b00e8e56e8dee08147df78c925fb51456d2d0fa6b); /* statement */ 
address recoveredAddress = ecrecover(digest, v, r, s);
c_0x209cf9ae(0x20723204e6a340ebabdd3a56647960edf8147d382a309c37e3557633d532a137); /* line */ 
        c_0x209cf9ae(0xd416c52510232bfbcd390527c29a4e72e62d45c52954e89c01ba3864e14d60bd); /* requirePre */ 
c_0x209cf9ae(0x0ba9af001d306eb5fd62fe5fdcb6932ea2b7ef4d4d8354c6bb181bd2fb76b26d); /* statement */ 
require(recoveredAddress != address(0) && recoveredAddress == owner, 'UniswapV2: INVALID_SIGNATURE');c_0x209cf9ae(0x83b2b82b24406234e42dfcbc8a1b156f6bc8987322b802b595fcdd7e83f559be); /* requirePost */ 

c_0x209cf9ae(0xed6b5455c32a49dcec7c0834c53f6605bdeaaf756b12b5e8d97a1c6882d24b87); /* line */ 
        c_0x209cf9ae(0xd75445e8206dd22ddcf3feb7b62cb5a0db5b1a97d617f7bbeab8c29e73423292); /* statement */ 
_approve(owner, spender, value);
    }
}
