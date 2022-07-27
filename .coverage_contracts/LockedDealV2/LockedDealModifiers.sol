// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x8fd153a3(bytes32 c__0x8fd153a3) pure {}


/// @title contains modifiers and stores variables.
contract LockedDealModifiers {
function c_0x7aa640c1(bytes32 c__0x7aa640c1) internal pure {}

    mapping(uint256 => mapping(address => uint256)) public Allowance;
    mapping(uint256 => Pool) public AllPoolz;
    mapping(address => uint256[]) public MyPoolz;
    uint256 public Index;

    address public WhiteList_Address;
    bool public isTokenFilterOn; // use to enable/disable token filter
    uint256 public TokenFeeWhiteListId;
    uint256 public TokenFilterWhiteListId;
    uint256 public UserWhiteListId;
    uint256 public maxTransactionLimit;

    struct Pool {
        uint256 StartTime;
        uint256 FinishTime;
        uint256 StartAmount;
        uint256 DebitedAmount;
        address Owner;
        address Token;
    }

    modifier notZeroAddress(address _address) {c_0x7aa640c1(0x5f74e4321ed47fb9e2b170e19b7f55a751e16ce9eb27c555ca8d1bec15c5d13c); /* function */ 

c_0x7aa640c1(0xdec33b8d57f57f2ca5ead2f82e05b2910c8cd62f6ce5b635621f83c107b39197); /* line */ 
        c_0x7aa640c1(0x0efcf118b1aaff1c187024eff34bd101b2f191ca8cf69cc9403e3948e7d7eca6); /* requirePre */ 
c_0x7aa640c1(0x0f182ed5c94d187ea96780da9e0894f3c8b0f38f68432034d8316bb6288a14eb); /* statement */ 
require(_address != address(0x0), "Zero Address is not allowed");c_0x7aa640c1(0xdc5756fc81f12257fe024464973646b5e8e0905e7fdfb94a20c5a1c752527ee8); /* requirePost */ 

c_0x7aa640c1(0xd44e91133ff6ab9636a8fa24fc3b4246343a40c0e8f08e466d4b55b3e9fb2324); /* line */ 
        _;
    }
    modifier isPoolValid(uint256 _PoolId) {c_0x7aa640c1(0xe39295cce7d841921ab8b630381b4a7c7db14a3921efc4ce4955ce9b5f2939cd); /* function */ 

c_0x7aa640c1(0xa8541f546012f476b742d188a22b2f073c52a33177323667b9cc7ec9b4656a16); /* line */ 
        c_0x7aa640c1(0x51a804bd3463acbd02f943b6d1fc7a3f058dd76b7327f7777d42a3f7ce470e04); /* requirePre */ 
c_0x7aa640c1(0xe5ef63ae46c14df08457b418abe6104c8b90539c7749f19d5d090f2978bbb253); /* statement */ 
require(_PoolId < Index, "Pool does not exist");c_0x7aa640c1(0x5e7f1e33a62212acd5a9cc3750038553b241e9a989a58b0e7cd0404e7809b83d); /* requirePost */ 

c_0x7aa640c1(0xb58c0e534d2bae74ef1f5afef6cc43810368946d9e7e3d9b2f7590f541ee15b0); /* line */ 
        _;
    }

    modifier isPoolOwner(uint256 _PoolId) {c_0x7aa640c1(0x744a788e9037983a559e8af7590fc8ef3e4dd40fcea812338d0721595c700994); /* function */ 

c_0x7aa640c1(0x64d7f24d80f6f79e532a13da0df2b2e0c39117ed4b5087d8a6703578cad7a7c3); /* line */ 
        c_0x7aa640c1(0x35d23b3b29ba147f155a61b834b82e9294d09f44c997cadd057cf2cacc71e447); /* requirePre */ 
c_0x7aa640c1(0x12cf2eaf9a2a060219e0f55423e0c3503f98b3ef73588c24e67128a59f42c709); /* statement */ 
require(
            AllPoolz[_PoolId].Owner == msg.sender,
            "You are not Pool Owner"
        );c_0x7aa640c1(0x7b267cbd647d47f4f01916366fc78a47f25cb449ce5eca8abfe5f4645f3ae6c0); /* requirePost */ 

c_0x7aa640c1(0x00180e56ee984917736886d1a3f39aa95661dfbae731a5663bc1948ed04d4f0c); /* line */ 
        _;
    }

    modifier isAllowed(uint256 _PoolId, uint256 _amount) {c_0x7aa640c1(0xf40336471256a34f218719cad97b9ec6be497f17cb45ba771b07e0f7dd1de2cd); /* function */ 

c_0x7aa640c1(0x7a33d6951bbd9e29396c66bea4e137065361804520280fbfa9125945b7bbef20); /* line */ 
        c_0x7aa640c1(0xfd73a70203cc2faf882cd2c1cb6434329e87e0042b6f71c231ce9fd0bc303bb8); /* requirePre */ 
c_0x7aa640c1(0x6bcf8faf0ce9226fd29c79a6d2233cf465ea7299ae2b0d81e27bd69cb27ff036); /* statement */ 
require(
            _amount <= Allowance[_PoolId][msg.sender],
            "Not enough Allowance"
        );c_0x7aa640c1(0xc3adb718eaa325711749cf68d8ab01ecd10374d6fc5aa4cce8d9d01095f571be); /* requirePost */ 

c_0x7aa640c1(0x99828bb18dc204249268a2ee5f120a3527873d279425e8862112b0ac64d26942); /* line */ 
        _;
    }

    modifier isLocked(uint256 _PoolId) {c_0x7aa640c1(0xa036d6f43ba5b25c56b14ecc9e86d49583d6f5d9733731a5c849a9e7b11f5691); /* function */ 

c_0x7aa640c1(0x70bad0a457b8a8951f50478715dd68f97276bf25827d67e5a32fdc2d70b6bbfd); /* line */ 
        c_0x7aa640c1(0x4900f93a16dea20f056e9d3480d31b3474fb85bb6a749ddb83bbb5b0f692d7f1); /* requirePre */ 
c_0x7aa640c1(0x60092ba081135c421345e982d88be0935e0a69c40b47482a01f66e018423e2b9); /* statement */ 
require(
            AllPoolz[_PoolId].StartTime > block.timestamp,
            "Pool is Unlocked"
        );c_0x7aa640c1(0x8d886b26ceeafdc5a0cd431bef053ec6849abf1f6a2ac2e509be343c5c9f9135); /* requirePost */ 

c_0x7aa640c1(0x365831865c3945c3379286d8e842e8d0557f7a0da807d270565cd694f3770cac); /* line */ 
        _;
    }

    modifier isGreaterThanZero(uint256 _num) {c_0x7aa640c1(0xed2862249bda51e2bc330ea77823ef1d2b1c12065254eb06f23e0fba2ccb11c7); /* function */ 

c_0x7aa640c1(0x12eedacb802434e57000f6d17ab0464e8bfa19d40240a36168eb72bacb64c764); /* line */ 
        c_0x7aa640c1(0x6f110d407df67171b68a33eacf033d7e9c447c9d1733af9fc11f5f836af47214); /* requirePre */ 
c_0x7aa640c1(0x2c2a1255dd42b93c0bf2d53c4533b99061764b01c9fba6ef5ad8adb96cc37a34); /* statement */ 
require(_num > 0, "Array length should be greater than zero");c_0x7aa640c1(0x9f323af88515756cb9e5adb389794fa07558deee9f1701461bd34673d3c1b9f4); /* requirePost */ 

c_0x7aa640c1(0x155b8da9a650251dee5af31b50cd892d47d1d744da33eb4072e5a4396a57bea4); /* line */ 
        _;
    }

    modifier isBelowLimit(uint256 _num) {c_0x7aa640c1(0x3e31d6c94250908af576e4d83aa87bfe95b74d5fc6f03f5e67894fc41a284452); /* function */ 

c_0x7aa640c1(0x4bee4e273a62754e8ce11b985396394881967494920952077adf8fc1ad0eb80d); /* line */ 
        c_0x7aa640c1(0x67a7e0609a36084eb93395320fdb6b9f1c56d49560a29fe1d9ffb1fabe9ed91c); /* requirePre */ 
c_0x7aa640c1(0x3616462181a32d52c349c2a046c7ca19a0c3fe29375e0f9f7a945e90e6dbe638); /* statement */ 
require(_num <= maxTransactionLimit, "Max array length limit exceeded");c_0x7aa640c1(0x072b0fa67b35b02278fd0452c10ce5d51627fb4ed91687d2747777239cd4507c); /* requirePost */ 

c_0x7aa640c1(0x33e754f7c1a2d7f93c0643b3131345d2d38ab3078c02d9a746716ba28e669ec4); /* line */ 
        _;
    }
}
