// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x5913ac19(bytes32 c__0x5913ac19) pure {}


import "./WhiteListHelper.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WhiteList is WhiteListHelper, Ownable{
function c_0x926c0937(bytes32 c__0x926c0937) internal pure {}

    constructor() {c_0x926c0937(0x416a0a35d974322a16f6b8bbba8c4849fbdbf4d9d6c1ca9cca098f96aa703377); /* function */ 

c_0x926c0937(0x8b451ef977567a2c8949635109de1fa19ca69cbff2f3781b4a66e2d2d974bb1a); /* line */ 
        c_0x926c0937(0x3e2460dc919f2761dfc4cd17ed28039bf1b680d13f0e9e9079fd14c4e0f2facc); /* statement */ 
WhiteListCount = 1; //0 is off
c_0x926c0937(0x206f49bd94cf1953cf0fa1265e8857bca17eadcb3dad710b24bc00a366de673d); /* line */ 
        c_0x926c0937(0x524246d50151e68ff984789974591199b325e813e676a0171d2ae2ae1584c79a); /* statement */ 
MaxUsersLimit = 500;
    }

    //uint256 public SignUpCost;
    uint256 public MaxUsersLimit;

    modifier isBelowUserLimit(uint256 _limit) {c_0x926c0937(0x3d2c90636238e09ce4f7c4a499b60d2a354de1601f9259c4d0714e29544c2bff); /* function */ 

c_0x926c0937(0x5e606b411cc84a9f3dd8fb4d78c2490eae29bc43d6a624191f0947c7c9dfcc69); /* line */ 
        c_0x926c0937(0xab5065bc706ac2473c07d041fa541f0ccbecd6831887a575e407ccdcf1247e87); /* requirePre */ 
c_0x926c0937(0xe436bd053206085ee9aef75d12a40e5b5ab1e620f8a0babb9cf0f8ecc46d1735); /* statement */ 
require(_limit <= MaxUsersLimit, "Maximum User Limit exceeded");c_0x926c0937(0xe0e3afdb2dc2f8ba58505a270d7933402b3cdae2f4ec35bc4d6a29c7471b51be); /* requirePost */ 

c_0x926c0937(0x93326aae335aea4090f6048ee29385dba4839548ad78fbad83d74e3caeef9aef); /* line */ 
        _;
    }

    function setMaxUsersLimit(uint256 _limit) external onlyOwner {c_0x926c0937(0x5be21f54dcc2dff5c2939a15c7e6a77aadf097c4b457283efc29dce856413bc0); /* function */ 

c_0x926c0937(0xf26e53ccb818942d16028fda8fda0af1b51ca31c0a98bc8283c19d3df9480129); /* line */ 
        c_0x926c0937(0xee85af1d23d90ca97c47ec6a4603da41ce983119d82c26dedeb52c34ffbeaba7); /* statement */ 
MaxUsersLimit = _limit;
    }
    
    function WithdrawETHFee(address payable _to) public onlyOwner {c_0x926c0937(0xe73b7bebbc632c09b3db2b5a09d429d05bade612cee6222786c20545a0c5efbe); /* function */ 

c_0x926c0937(0x84f77c8e8132c46d760b502ccd2967e957c365d46d4492bfcc60bcb0a090760c); /* line */ 
        c_0x926c0937(0xae16b3f600d883f09a3a9484d3a402c23bd89dc3dc1c53eef346a4d275e92791); /* statement */ 
_to.transfer(address(this).balance); 
    }

    function setWhiteListCost(uint256 _newCost) external onlyOwner {c_0x926c0937(0xc2ec9435f5d1386843c56aee3415263f0ab0b8cacde1ddc2e801ff2fe59e8846); /* function */ 

c_0x926c0937(0x00981ef7ffd9cb1e4986abf144fdf1c3801a8490aa5c18cd6ed2f8ee1d306400); /* line */ 
        c_0x926c0937(0x52b6d2f8e28756fd494c47f582e9f521f967be87e20d11092ad81c3dada00928); /* statement */ 
WhiteListCost = _newCost;
    }

    function CreateManualWhiteList(
        uint256 _ChangeUntil,
        address _Contract
    ) public payable returns (uint256 Id) {c_0x926c0937(0x0a7b5785674ee91eb49740f6ccf70ff5814069593a612efb75b9fc97646390ae); /* function */ 

c_0x926c0937(0x83aababc4fd07ead6e11b4801af17b5f0e1afe4275ee8697167cc7bcd017bcd4); /* line */ 
        c_0x926c0937(0x00d851a0a5e5be6454889b448af83a67bd9ba26fe9526c768a445f8498528503); /* requirePre */ 
c_0x926c0937(0x5be757e276254ee16d3c3cf69c8e67f8884d91213ef6c34525b2e9070816de3f); /* statement */ 
require(msg.value >= WhiteListCost, "ether not enough");c_0x926c0937(0xb319968cbc9c44c25bd192c803a1835c5ca83faa2d6869d26d9891704e208410); /* requirePost */ 

c_0x926c0937(0xc1bf80e25184f3df8b14b362d169f9f519b77920c4a24febca9cd3a09d0ebff1); /* line */ 
        c_0x926c0937(0xb9a02d9321723de789596a6ce5574fdec293f046ec670521e8432351348659f9); /* statement */ 
WhitelistSettings[WhiteListCount] =  WhiteListItem(
            /*_Limit == 0 ? type(uint).max :*/
            // _Limit,
            msg.sender,
            _ChangeUntil,
            _Contract,
            false
        );
c_0x926c0937(0xfa98d6cb3d9d8fd8c8df4301444e27d6c716d27fc1ba8d268e7bb52248bdcba8); /* line */ 
        c_0x926c0937(0xce20c73467be4aaefbc02dc2d2acaf557efd22d497081e28a2b90d01cf8ac99b); /* statement */ 
uint256 temp = WhiteListCount;
c_0x926c0937(0x557973b0090fd414b3bcc04985cf8461bfeaff6bfdcfc04e8f3dae8273be20d2); /* line */ 
        WhiteListCount++;
c_0x926c0937(0xe3f6537e24f10ea7f5d663f23fbd68a7587c9f373c742dd83e5e4d44ed2d3791); /* line */ 
        c_0x926c0937(0x815afcdb1f63faaea77470b37ae73409dbafc4a0862d6224f09b845797bd257a); /* statement */ 
emit NewWhiteList(temp, msg.sender, _Contract, _ChangeUntil);
c_0x926c0937(0xb6d56fd198a6fd9d33e26c67ba2ac5850b36b2f63ee7343b79d5976f97ecb993); /* line */ 
        c_0x926c0937(0x61df5846c36c1d7df6d732b52afd3401f70829cd91c8f33edb5b637b5dcd0ba1); /* statement */ 
return temp;
    }

    function ChangeCreator(uint256 _Id, address _NewCreator)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
    {c_0x926c0937(0x38211acb548cdbe16cd818c5b57646a9dc82579b40f4362b7fd7a70277a53a96); /* function */ 

c_0x926c0937(0x7b243d00f6ac77376329586c305776421aaf29265064caa1824ee234313bff24); /* line */ 
        c_0x926c0937(0x8bf816282ecee154ea08ae0617076dcb464dc1f746ee1d50412a51ad07210541); /* statement */ 
WhitelistSettings[_Id].Creator = _NewCreator;
    }

    function ChangeContract(uint256 _Id, address _NewContract)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
    {c_0x926c0937(0x6ac8d2770753ec99384af8884305918bfb7fd7024172ef4c3073c03d7587a878); /* function */ 

c_0x926c0937(0x49cd50ce81b6733d784f360b5d1575d8bf6af5d21355eed9c47423d767c49715); /* line */ 
        c_0x926c0937(0x490825adce8941bae2a283739c060d751150561b3187b658dfaf65de61d0985e); /* statement */ 
WhitelistSettings[_Id].Contract = _NewContract;
    }

    function AddAddress(uint256 _Id, address[] calldata _Users, uint256[] calldata _Amount)
        external
        ValidateId(_Id)
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        isBelowUserLimit(_Users.length)
    {c_0x926c0937(0x1b891b05ea75d371a76d815b9c70f6a8650f5e83fa5b16b7e97a707a27754f28); /* function */ 

c_0x926c0937(0xef467b7fb013c8d34f1d5f596a280de51460d612e21a69269361a9640c6f3682); /* line */ 
        c_0x926c0937(0x98376b5d54abe25a39bd65f437c22d63eff3003241173618ee560da3de0eb3fc); /* requirePre */ 
c_0x926c0937(0xf60da7c9ad9170a6352ff6954897c7ec713b8e6023b830f2501081af92718f86); /* statement */ 
require(_Users.length == _Amount.length, "Number of users should be same as the amount length");c_0x926c0937(0x27b7f08312828734581c84ee11b0231a394290794b36741e435c6437957667b8); /* requirePost */ 

c_0x926c0937(0xad0a9706a8a526904b45bf4a41089a9efc9869b9966a983ee10bc7ba9e189be3); /* line */ 
        c_0x926c0937(0x326f28c0ccb25a9005e557e02d2ec4fd19dc1fd6db9ef3a33c3f04ebba77f34d); /* requirePre */ 
c_0x926c0937(0xe7cc33d9e7c940aa090b25cca3bcd1ee15153712f4fc912664fad1b759622c55); /* statement */ 
require(_Users.length > 0,"Need something...");c_0x926c0937(0xdafee5bebcae666d38eb7694098c8462db7f8e2da1563f8331e23d32e9e307ac); /* requirePost */ 

c_0x926c0937(0x48bef90f30fc594ec3a26f4562031c74ea43a575c20c0a8dc44650845666beb8); /* line */ 
        c_0x926c0937(0xb998e931ada4eff4467735fcc068f6ba6ca8b817beac4e8fdd9ed7d3c59f3cda); /* statement */ 
if(!WhitelistSettings[_Id].isReady){c_0x926c0937(0x026c81fb5ca6d3b433b2c3869b02883dd999ffb33ada56197198b304c64d8e0d); /* branch */ 

c_0x926c0937(0xfdbd9a19f2eeaf6ce264e3adfee021824d9312f241a122dc550df4c77c2c9bd1); /* line */ 
            c_0x926c0937(0xa9c9ecb9bd06745762058957b06aa0b20e8169f607d35b734e8b577559543cd0); /* statement */ 
WhitelistSettings[_Id].isReady = true;
        }else { c_0x926c0937(0xab3eea94f43b563609c7296adcaf80c1127fc6218b315a8a35f878ff4e7c06bc); /* branch */ 
}
c_0x926c0937(0x32e1516ec6f36564c1595aff9ffa02abea394b8509dacae87033bdec16f52b21); /* line */ 
        c_0x926c0937(0x2d4eeeafad32a11e56c68d87ccac024362ded714f3c4647633ed4783fdf96e7c); /* statement */ 
for (uint256 index = 0; index < _Users.length; index++) {
c_0x926c0937(0x5ca61e518005abeae84284664f6e579660c9b40981da89297abd1178ecdc6e77); /* line */ 
            c_0x926c0937(0xb769dcb9611966f87be2c3a3d445cb03a75695d3ba9b5de6dc75a979144b8355); /* statement */ 
_AddAddress(_Id, _Users[index], _Amount[index]);
        }
    }

    function RemoveAddress(uint256 _Id, address[] calldata _Users)
        external
        OnlyCreator(_Id)
        TimeRemaining(_Id)
        ValidateId(_Id)
        isBelowUserLimit(_Users.length)
    {c_0x926c0937(0x08cd940b47536f9b4022863a7180a75ec0bea170533a0caaae6d31773375ba4a); /* function */ 

c_0x926c0937(0x100737bbffb353a587c34893705df7142b5c2985e1b57b8b9f8723cdb32f21df); /* line */ 
        c_0x926c0937(0xeeaf4cfb82b2c86cdf29bf70a2a0738cbd8c1066e0b1dcbd5e2834d76b839a86); /* statement */ 
for (uint256 index = 0; index < _Users.length; index++) {
c_0x926c0937(0x2245e95469b1f54183d41791d8ce060c60db1ec415eeabc0cd1a8b2c5c390fbe); /* line */ 
            c_0x926c0937(0x8d9e26cd503cab8a459abd619c598e4d1035d3a0703413e202664cbcc11b0351); /* statement */ 
_RemoveAddress(_Id, _Users[index]);
        }
    }

    function Register(
        address _Subject,
        uint256 _Id,
        uint256 _Amount
    ) external {c_0x926c0937(0xc6c78c297bccef3e53c19fc7eedf76bd565695a7e2a28f6c24dc349463e89af8); /* function */ 

c_0x926c0937(0xe41ccb8d6c6b47d06986a4cbac70b65cff6a8337fbe8df4cc0ba852a534e8db3); /* line */ 
        c_0x926c0937(0x992af74df8286bbaa39edc44796d7a9c098930ccc265a192b8340586f09fe52e); /* statement */ 
if (_Id == 0) {c_0x926c0937(0xc4e827a131324efd27f10dc0c6297a561ef1604369d9da447f44eb9a7f7c7064); /* statement */ 
c_0x926c0937(0x8cd4437c9914ab8dc1aab8e7615943df1698e296e8bedbc027d09da5eee86a81); /* branch */ 
return;}else { c_0x926c0937(0xbb1ba3f3eb109ee51fbe691e34e638517b43341cce01624643d269f63a74b031); /* branch */ 
}
c_0x926c0937(0x88e95421ef5cfee0c44feb013c4a3a1cfb80e7a0765c39a283137a89732a944d); /* line */ 
        c_0x926c0937(0xb7b10c973c14ea133d9fedff85f2082b2b19aaca7c6f0c2a8f7ae1e107032d1b); /* requirePre */ 
c_0x926c0937(0xc92f7bf8cd7d98131c1d8e65c363b10a30e8bc444daa8e9a0a0a6af0f49240b3); /* statement */ 
require(
            msg.sender == WhitelistSettings[_Id].Contract,
            "Only the Contract can call this"
        );c_0x926c0937(0x4fe8e37e196bbcf5ff3987b415eff64e8c99988f86a5198128f842cdb451cff9); /* requirePost */ 

c_0x926c0937(0xf610917d27fbbf88348259926ddb8e3c1b15b142e3214b55620dcf16e74cb5e6); /* line */ 
        c_0x926c0937(0x54fedd93ef91e4e2d2b037fe66dc74774340d1d07edbddab0ee02267525dc04c); /* requirePre */ 
c_0x926c0937(0xe61a22ed8ee124649083d0445da5b886f06df84767831388033b81178ff18503); /* statement */ 
require(
            WhitelistDB[_Id][_Subject] >= _Amount,
            "Sorry, no alocation for Subject"
        );c_0x926c0937(0x4fbe9a0954a0ee80823368424f46da53383bd2f4aa258e51a5ecf070484b467d); /* requirePost */ 

c_0x926c0937(0xad3127fb82695ddb04f5d8e2ad597adb44164d30fbcc78848c1def9a732ecfc6); /* line */ 
        c_0x926c0937(0x76b3073db499a31be223498b53b20ee0ed4bf7d98fad79e53a98102d3ce8a334); /* statement */ 
uint256 temp = WhitelistDB[_Id][_Subject] - _Amount;
c_0x926c0937(0x30facd91c979c8ebc3faa8bbe1381888b23c2506827f084501c00e4f63388eae); /* line */ 
        c_0x926c0937(0x3be1e1bf88ddbe6bf8fce66e64b9349ad47efa9179e5e9d7c96d78effa6626e4); /* statement */ 
WhitelistDB[_Id][_Subject] = temp;
c_0x926c0937(0x3716a16d5f84df2795ab2ac9c353be425bec494475b79919e6c20aabda5af720); /* line */ 
        c_0x926c0937(0xca0a714009063109e508b74972c2416b62ff531a02ad34deca34508380386f28); /* statement */ 
assert(WhitelistDB[_Id][_Subject] == temp);
    }

    function LastRoundRegister(
        address _Subject,
        uint256 _Id
    ) external {c_0x926c0937(0x071f2d0445370f3669d4de69760b931a6d2a76c1cb5542c112267a1838247750); /* function */ 

c_0x926c0937(0x991e5fde11f73643887672a3f0b5645245e71a22171fe4a2b3c760c6c6bed105); /* line */ 
        c_0x926c0937(0xac600f2ecf3e176ce378f8ae6d2cbcd6a81d415305ac4b78534aa3b0228c9668); /* statement */ 
if (_Id == 0) {c_0x926c0937(0xc35670aa658048db6fdee35bd2566731aeeaecfac1083482c3beec8f9632e5f3); /* statement */ 
c_0x926c0937(0x065c1f6ae28bdac41f06f3561826fbeeb814666e2f4f4bc4327d466d9f29bfea); /* branch */ 
return;}else { c_0x926c0937(0x5016e283d56820f5be29c9349971d29e06042d9677770545c6e764fd8a5380ff); /* branch */ 
}
c_0x926c0937(0xafb4480e139c522010138556a97207f715bf22a6727a910162e6bca1a959481b); /* line */ 
        c_0x926c0937(0x5d5d6cb55a884d7441120a02e9a3428d4dabc3216fd218ef3b4234a1bbfdb2b2); /* requirePre */ 
c_0x926c0937(0x19b7884f13118c2a92552977e0ce91b04ebe592fe52ed68659fc75d61b7a46ab); /* statement */ 
require(
            msg.sender == WhitelistSettings[_Id].Contract,
            "Only the Contract can call this"
        );c_0x926c0937(0x6867e3531ea3e75fddf7875afae71177063d3fb17d69e233edc96cac3f89b943); /* requirePost */ 

c_0x926c0937(0xbf8c59ec437e0d713fafca27fc093ef0c9ec67c6865ba212b50fdfda84ee397d); /* line */ 
        c_0x926c0937(0x9b2cd0b21ee5fbe0cd19d683c5d19387c4ecd8e2afc3387913dda8540e1e35ed); /* requirePre */ 
c_0x926c0937(0x39f07c77e3b5381a7eafd75c4612927887fdfe02594744b2d4f9934188466289); /* statement */ 
require(
            WhitelistDB[_Id][_Subject] != type(uint).max,
            "Sorry, no alocation for Subject"
        );c_0x926c0937(0x61b748e843071998ad3c42598ba8dace1557ae064dfe441fd5c290ecca791a91); /* requirePost */ 

c_0x926c0937(0x9f966466652ca5b02817b587ae36ede43fd1933da83a07fc2c8dbac95df3c8ff); /* line */ 
        c_0x926c0937(0x36d5569427e62e3b031145a7d4b3c94b4ece0d636be251d8c82258fecdec7aa2); /* statement */ 
uint256 temp = type(uint).max;
c_0x926c0937(0xd9b3a938ad5ecfa390c32714c48705bafd73021beb7d17abc3ec4773f971fc87); /* line */ 
        c_0x926c0937(0x79b20275febf7ee4e341456b6aff0d3779783144ebd228cac6eb3a8f26ac1e9e); /* statement */ 
WhitelistDB[_Id][_Subject] = temp;
c_0x926c0937(0x4fe5872f8e31f3778ccfc956155ef64f2c434ccd088de454b3ffc9319e70dbe4); /* line */ 
        c_0x926c0937(0x04fcdee8099b250c5a0d8121b0138d3cb09da2bd34e6f3977e2fb2b9869ecb0b); /* statement */ 
assert(WhitelistDB[_Id][_Subject] == temp);
    }
}