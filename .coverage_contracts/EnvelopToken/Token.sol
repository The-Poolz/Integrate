// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Manageable.sol";
import "poolz-helper/contracts/ERC20Helper.sol";
import "poolz-helper/contracts/ILockedDeal.sol";

contract POOLZSYNT is ERC20, ERC20Capped, ERC20Burnable, Manageable {
function c_0x1a3c44cc(bytes32 c__0x1a3c44cc) internal pure {}

    event TokenActivated(address Owner, uint256 Amount);

    constructor(
        string memory _name,
        string memory _symbol,
        uint _cap,
        uint8 _decimals,
        address _owner,
        address _lockedDealAddress,
        address _whitelistAddress
    )
        public
        ERC20(_name, _symbol)
        ERC20Capped(_cap * 10**uint(_decimals))
    {c_0x1a3c44cc(0xb0ca5f30bcca15d0fde15bb37271b872d708b27992416029217e5f37bc4ecc1b); /* function */ 

c_0x1a3c44cc(0x6d6811d1e425705c14a0b4547ae2e72e2fedfa9ce68d7322daaa8f8b15527164); /* line */ 
        c_0x1a3c44cc(0x449130ce1bc47b288c6320eacea04b31a3c8dcf9252e7a39e7d58da4be69ef80); /* requirePre */ 
c_0x1a3c44cc(0x707cae5eb157ccdbd7701bf6992ddf9852bf8f778e80f3e4831e0469148d4621); /* statement */ 
require(_decimals <= 18, "Decimal more than 18");c_0x1a3c44cc(0x9793711ff2814959549a51504a0b220a6d5f37a2cef05c1e2484d0710a64c310); /* requirePost */ 

c_0x1a3c44cc(0x486f59c0193bf94652230baffb0a65d20912fe183dfd42fcc7a2b00cf10520c3); /* line */ 
        c_0x1a3c44cc(0xee7bd23a3d36239294c86947f7ce3ae3d6fd208840ae3e608be9d456f50f03d2); /* statement */ 
_setupDecimals(_decimals);
c_0x1a3c44cc(0x0ebbe3324d1cbaaef91f112da35c626288f2691ccd3682911ae651b64365e2d6); /* line */ 
        c_0x1a3c44cc(0xbc63aa28e66f3375bdf5a05d3559d4faf17c83ff91f3fbf3b26d93cce63f5f07); /* statement */ 
_mint(_owner, cap());
c_0x1a3c44cc(0xc6bd2c0406c6367c77aaf785f36a4556a433e2caa6b94c55b5eb74fd9740e533); /* line */ 
        c_0x1a3c44cc(0x0d2e5825b27c2835f5637432fb4d8ac1c6c8ae65c2c93a0e4bc6e5e9c410796a); /* statement */ 
_SetLockedDealAddress(_lockedDealAddress);
c_0x1a3c44cc(0xef9c963438613b6e1839653a1a75b6192044d6df3cae98cf0cf0256c43ee460b); /* line */ 
        c_0x1a3c44cc(0xff1c8eb17338b36681b53a9df92af162365d624b53eeb1e56850f7709ded7eae); /* statement */ 
if(_whitelistAddress != address(0)){c_0x1a3c44cc(0xfb0d589c07ba3d6159bd64e94a07fabd64671a4dceae00584cc5f09494a79465); /* branch */ 

c_0x1a3c44cc(0x66c56b5bdea3bcd41a1db80204a2464ce5d81cc6a6de4f31d332ca7e94db833f); /* line */ 
            c_0x1a3c44cc(0x0b55506910a12ef7e9f8e38dec81223faedf6ac1ddfc99965c37a87fa77563cd); /* statement */ 
uint256 whitelistId = IWhiteList(_whitelistAddress).CreateManualWhiteList(uint256(-1), address(this));
c_0x1a3c44cc(0xd18f210cf213693ba2a9530ad351ac8edaaabf9ded642d2bbaba11a150ad2d89); /* line */ 
            c_0x1a3c44cc(0xa29b17d330ee18f284603a2c888f6ec6bdea8efbd73f7a0f3d0c2aceda5e3a7c); /* statement */ 
IWhiteList(_whitelistAddress).ChangeCreator(whitelistId, _msgSender());
c_0x1a3c44cc(0x4b1a673fec9cdf0c4185a8b3c7c08925be4d3c220c1033b2428f6ed61697be27); /* line */ 
            c_0x1a3c44cc(0x0234814eaec3537035e811740d9fbef8049d9decd5eb4d242af4095f85214902); /* statement */ 
_SetupWhitelist(_whitelistAddress, whitelistId);
        } else {c_0x1a3c44cc(0xae4692ab5e4faa21a9c5d74911c083e7c8e1f22e3cccf5a56f7110a156a4104a); /* branch */ 

c_0x1a3c44cc(0x7f1e55fbbde5e533e1964937cc7bc2429783e28f5f0a6bdd35c43717089c0c1f); /* line */ 
            c_0x1a3c44cc(0xe153b86c3376295cbda60c276530a0c275633f3a64ea42d4f20456f33a3976d2); /* statement */ 
_SetupWhitelist(_whitelistAddress, 0);
        }
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal virtual override(ERC20Capped, ERC20)
    {c_0x1a3c44cc(0x7980419f5f1e72123bc3304ac78bc4aabf81441bc682a07e43e4b12459250a10); /* function */ 

c_0x1a3c44cc(0x4ed696b8119bee59641f3e23a4ee66dd9bb32ca8f103a376e1d07f317467eb64); /* line */ 
        c_0x1a3c44cc(0x530f6616e9c185cdf21f77cd75422efaaf4d6213ac7b2106162ddb088614c60a); /* requirePre */ 
c_0x1a3c44cc(0x42f33f5326062b4204e58aa3a42892a8e71a3f12b330b9da5ecbf89e6290ef71); /* statement */ 
require(FinishTime <= now 
            || _msgSender() == owner() 
            || to == address(0)
            || registerWhitelist(to, amount),
            "Invalid Transfer Time or To Address");c_0x1a3c44cc(0x885cfa29d940d06687cd79d954d98b1689773d383cbfb16a988cbb57b75fb408); /* requirePost */ 

c_0x1a3c44cc(0xcfd95d0512c300e39d124a7d0b76a0daa7dd0631f864562bf11e682b39bf4243); /* line */ 
        c_0x1a3c44cc(0x6bf571e21e9981feeaf28f147836897026f3c6e0e98acff6688418765429725d); /* statement */ 
super._beforeTokenTransfer(from, to, amount); // Call parent hook
    }

    function SetLockingDetails(
        address _tokenAddress,
        uint64[] calldata _unlockTimes,
        uint8[] calldata _ratios,
        uint256 _finishTime
    ) external onlyOwnerOrGov  {c_0x1a3c44cc(0xd584ab90766d1a5230bcb48d8c350a8f700b40e29c2ef3e22d127350d26029bd); /* function */ 

c_0x1a3c44cc(0xf20ce7300d96fb2aa61203ca0b23098014c31daaac0f197d3266e3bdecdbd1b1); /* line */ 
        c_0x1a3c44cc(0x5a9a7fa5d324198d31928d63d36289c8a60cf5c8cee48a3afba1fc29254a6f25); /* statement */ 
_SetLockingDetails(_tokenAddress, cap(), _unlockTimes, _ratios, _finishTime);
    }

    function ActivateSynthetic() external {c_0x1a3c44cc(0x2835184822db164982683963024a8d49a2a7bbf9776d11c03c0bf0285b843409); /* function */ 

c_0x1a3c44cc(0x81eab53e38a601d2d2150a4d7dd5b50da2cf1c2eef0d8e4fd1f69e8712e82d96); /* line */ 
        c_0x1a3c44cc(0x3886c0d3bce572b3922c20d2d6ce76d8eccfa6782188a73b82c13ed94bce46c9); /* statement */ 
ActivateSynthetic(balanceOf(_msgSender()));
    }

    function ActivateSynthetic(uint _amountToActivate) public tokenReady(true) {c_0x1a3c44cc(0xc7e631daf067289282fd6cdd9869e2240b2f099722e56240eb1fda1fc3697f4e); /* function */ 

c_0x1a3c44cc(0x3dccc9f3260e9d448f618b1e1af99bcaeb5e4d4141d89e7e84d520885006d426); /* line */ 
        c_0x1a3c44cc(0xe2a8af1dc7999b2f9ef97ab9c44fed2013726a3f027c6b5c2f74b68a5c596d1d); /* statement */ 
(uint amountToBurn, uint CreditableAmount, uint64[] memory unlockTimes, uint256[] memory unlockAmounts) = getActivationResult(_amountToActivate);
c_0x1a3c44cc(0xfed692fb7b0f75b639b54eaae5d85e9bfe29ed3f88fc1299d6db60983630e295); /* line */ 
        c_0x1a3c44cc(0x9398439fbb036141bf08342dbc41a34f644ec8015c55828cc55ecfe852595cf1); /* statement */ 
TransferToken(OriginalTokenAddress, _msgSender(), CreditableAmount);
c_0x1a3c44cc(0x0391c8ea0d3e71734f22ef72bf9284be3b05489fe0eb5c033981e01d2ebd9543); /* line */ 
        c_0x1a3c44cc(0x2c85fcd76957f4d84e703cfd58d663a0b36a8db06b6e4e58eeb3921bebfec40b); /* statement */ 
if(SafeMath.sub(amountToBurn, CreditableAmount) > 0){c_0x1a3c44cc(0x17137dc28b3e18dc5bc27fd519db4b852c59ab72158f772e1b1a26f7b16c8055); /* branch */ 

c_0x1a3c44cc(0xf9b2d4945a44f8caab7d049b642e14d71c93965e69239e29660b9cbd91d54849); /* line */ 
            c_0x1a3c44cc(0xc7c7299305805db2ac3cd253d962c85a453b37d97e39a9ca0056ac2162bcc1d6); /* requirePre */ 
c_0x1a3c44cc(0xbb87ec2cd95de0b05cb6d11673572a55a192aa7b86ee83266ecd40548d4e0cba); /* statement */ 
require(LockedDealAddress != address(0), "Error: LockedDeal Contract Address Missing");c_0x1a3c44cc(0x4aa4dbd87699ce9a3207c3d79960148cd9793600ee054b42d2872e3763e78b45); /* requirePost */ 

c_0x1a3c44cc(0x1e5eecf731124bf001dd80eb2ebbb10cfda9369e44b73ee89552e7082d1452f8); /* line */ 
            c_0x1a3c44cc(0xbee8d41247948765d2cb0eb135c076017e45726f7935e24d260c9c058ecf0711); /* statement */ 
ApproveAllowanceERC20(OriginalTokenAddress, LockedDealAddress, SafeMath.sub(amountToBurn, CreditableAmount));
c_0x1a3c44cc(0xba7a0c5d30cc580289f23c6766f2223130e5ccf51959fe7670e3a13db6866153); /* line */ 
            c_0x1a3c44cc(0x3bccc55509e4c28944ef656d7b9553b0c2bcba750e0561863ca3658384923419); /* statement */ 
for(uint8 i=0 ; i<unlockTimes.length ; i++){
c_0x1a3c44cc(0x3d144bc78c764e0b020692362b024f5e137c1ff0e7fbb1830080cc7171de8111); /* line */ 
                c_0x1a3c44cc(0xe6cb40de70b7ed065db374b09edff12aac85144ce44182b4776d7f55630f8006); /* statement */ 
if(unlockAmounts[i] > 0){c_0x1a3c44cc(0x14d72c56e28a01e5dab3edb287ea0db91c9873ec43c202629a81fb53dbfed21b); /* branch */ 

c_0x1a3c44cc(0x4d4690d1230a85493df38fec5c5d441d99c7f9ce072ab74bf25682746a88b538); /* line */ 
                    c_0x1a3c44cc(0x1678cd70b24776c366c97cbe6b65a9d615b480fd74a7c69bea19cc556707cfbe); /* statement */ 
ILockedDeal(LockedDealAddress).CreateNewPool(OriginalTokenAddress, unlockTimes[i], unlockAmounts[i], _msgSender());         
                }else { c_0x1a3c44cc(0xd3a515e0dc7aee006e1ed01281bd0c3fd3755790af59c75a547d850fec80a1dd); /* branch */ 
}
            }
        }else { c_0x1a3c44cc(0xd72685421a986a1afc0ce4cbb7f34eced3e573204dd8ae66be7279e837b16d58); /* branch */ 
}
c_0x1a3c44cc(0x370177d4906c45405173fdcb89f51d5b84771992cc5e27903705ca77b99fd447); /* line */ 
        c_0x1a3c44cc(0x7e010d5ca960f417deb25ac0473e6b39c42a4708910d50dca81f5c6c6b1bcd63); /* statement */ 
burn(amountToBurn);   // here will be check for balance
c_0x1a3c44cc(0xec5946a2994218810bba7b78939843a0c1ed8df6944d7dd7a561b48bf15c2b30); /* line */ 
        c_0x1a3c44cc(0x2e40555b890eec28faaebe469116ae19a61ce50d157ee26123a0ebee33252d48); /* statement */ 
emit TokenActivated(_msgSender(), amountToBurn);
c_0x1a3c44cc(0x502e33f204aa79b174f54fef0d12181ea6571d5d6ddbe558450e36fe7eb76667); /* line */ 
        c_0x1a3c44cc(0x8932f85066841aa1ec6c4a1f620b42f00780dfa9eef43fb714a8e7abb668cb27); /* statement */ 
assert(amountToBurn == _amountToActivate);
    }

    function getActivationResult(uint _amountToActivate)
        public view tokenReady(true) returns(uint, uint, uint64[] memory, uint256[] memory)
    {c_0x1a3c44cc(0xf3d01344b207b82923f892947648d0a9e267408c3406ff46a9a3b3f5d7c9ceb0); /* function */ 

c_0x1a3c44cc(0x2ff6462fcf9beb4211f45ea6e971ec8f6ef46c95a294d1435005fe081e14e2d7); /* line */ 
        c_0x1a3c44cc(0xc2f2827b520e9fae042d20f9e57c1ed0c5d0c6bbdbd5464f209a9b62c8735e37); /* statement */ 
uint TotalTokens;
c_0x1a3c44cc(0xdc97a278f48fa861f7598f15ba046b57aeb9a48afc4df7e024d83bc0c038e599); /* line */ 
        c_0x1a3c44cc(0x375bd7618998dadc750533c8be5a28744810752c3499df66661a9028c5ca786d); /* statement */ 
uint CreditableAmount; 
c_0x1a3c44cc(0x26a4d72b73e997ee86c5532cbdefeaa8513bc4c618a0981684b56e8324103fef); /* line */ 
        c_0x1a3c44cc(0xe070642f970d174e2ca475340f4c94cb3ad0e3afb83fa4c4703ca8ef77f8665e); /* statement */ 
uint64[] memory unlockTimes = new uint64[](totalUnlocks);
c_0x1a3c44cc(0x9593bda1c7b000ef15ba960f3fc1c4e5bbb01e0b0c0cc809ec4597ca60854c1e); /* line */ 
        c_0x1a3c44cc(0x60d9e046e295acc63cc0064ff2d645a38a14f31c44fc22148d1af341e046316d); /* statement */ 
uint256[] memory unlockAmounts = new uint256[](totalUnlocks);
c_0x1a3c44cc(0xe839e96a4df4273f226aae62020531f3a9129f3481759b9c2aaea0610e6e15c7); /* line */ 
        c_0x1a3c44cc(0xe07b1f565e27e01f87880d49c3c45c41818cc37ec36294d2a9546421da3fdf59); /* statement */ 
uint8 iterator;

c_0x1a3c44cc(0xe72ca26bab42ad4a500555d6946e8003b818881bf324a4499117c8d1cece3463); /* line */ 
        c_0x1a3c44cc(0x5d2b855005492af907386b06cafa569d6e7e97a57fa181841d4616a143d7d5f8); /* statement */ 
for(uint8 i=0 ; i<totalUnlocks ; i++){
c_0x1a3c44cc(0x75a7fda3da85c206c99695b8f0550a72ec3609ed6e1294bb9acf0c29d1bc0c67); /* line */ 
            c_0x1a3c44cc(0xd99529720a8b02fad83e6b83ffa2bb4221d1a18aa8d5fb91d5a43a5abc4ca1b3); /* statement */ 
uint amount = SafeMath.div(
                SafeMath.mul( _amountToActivate, LockDetails[i].ratio ),
                totalOfRatios
            );
c_0x1a3c44cc(0x87e83d514caaf9d90d824b846bc83c5aa864f1b55fbcab727383e552c55e946d); /* line */ 
            c_0x1a3c44cc(0xdd9e6fe171462a4c6d9a8bc0f10ff6ccc253154aec9a73c637ecd8e5399e124c); /* statement */ 
TotalTokens = SafeMath.add(TotalTokens, amount);
c_0x1a3c44cc(0xde1d4e5ddfc9759da5b0c4040fcc3716b4660a7c6b14fa286299d4022249fa6c); /* line */ 
            c_0x1a3c44cc(0xadda87532d82a6f76697654b2f19061095562904fc84cb9c7bbc2533f17b5ac6); /* statement */ 
if(LockDetails[i].unlockTime <= now){c_0x1a3c44cc(0xf45fcdc28c29c986b40a93947f8303fb048e0b6c9a44ff60a5818997bbb8fd53); /* branch */ 

c_0x1a3c44cc(0x7bdca59cac26a694913f9d040a4babf1b1f5869688a60017cd4007dccb6eb44a); /* line */ 
                c_0x1a3c44cc(0xd2d19ba91eba5d0073ceebe908a93c1d1744001f7df75355eb0be49bcaada528); /* statement */ 
CreditableAmount = SafeMath.add(CreditableAmount, amount);
            } else {c_0x1a3c44cc(0x63e1db62ca287dc4b51f7093d21f97549b67424397326cb932be2eae32c7ed69); /* branch */ 

c_0x1a3c44cc(0x8bd0b43d516ef09fab41181512bd364b467270e9ba409e22a381b43c47c7efd0); /* line */ 
                c_0x1a3c44cc(0x5e5ad2e0747f4155b58004f0205eb3bed28ec66a89b297706f448b019728af6b); /* statement */ 
unlockTimes[iterator] = LockDetails[i].unlockTime;
c_0x1a3c44cc(0x65d140909fed7afe78fe3baae8ba360132b409717174e79bf21b710187830d50); /* line */ 
                c_0x1a3c44cc(0xb15d9385ac5975eb4838c7140d4cbcafa21e14c5a52ba07bffbdeb5fb674c0e1); /* statement */ 
unlockAmounts[iterator] = amount;
c_0x1a3c44cc(0xffdc683d4a15be36966b102f8ce6b9bc3f3ea44b09d532241328f4ed7e3f26b0); /* line */ 
                iterator++;
            }
        }
c_0x1a3c44cc(0x0c7ec84ce0add55cedab6c5acf9a94de8cd6e09903152eeea8639eff83f91d67); /* line */ 
        c_0x1a3c44cc(0xc8228c74fb5c69c75f54fd425e5122fa9d52dba89ac622e6fab5c9c935fd7f37); /* statement */ 
if(TotalTokens < _amountToActivate){c_0x1a3c44cc(0x929ee742de4e8498578190ad9f31eab7e57e8a2da79763bc41965787118deba4); /* branch */ 

c_0x1a3c44cc(0x59b72206ddd6f3e6a07fb272b46c24c3e333898582dfffc4598ff0163093aeda); /* line */ 
            c_0x1a3c44cc(0x8bb9046005b9bba5c30d6861b0b1c00613c1c8a7f22b74fc7e55b68fbaf20cd6); /* statement */ 
uint difference = SafeMath.sub(_amountToActivate, TotalTokens);
c_0x1a3c44cc(0x4780bb9f8981e1c1f4ea3820345636762d4260f488c9d015fc08990e24fc72d2); /* line */ 
            c_0x1a3c44cc(0x91718f06eec839e27607c502d69498183e765c25b5cc3c6884669a1ccffff578); /* statement */ 
if(unlockAmounts[0] == 0){c_0x1a3c44cc(0xc683ca0cd0a77c4c414a9eefff40f45f34d56a812df8c678643484651ae82366); /* branch */ 

c_0x1a3c44cc(0xdd7faf3e0ca32a4f4a56add331f027c0b37df78ec473dca2553014d8ee4355fd); /* line */ 
                c_0x1a3c44cc(0xa1a4bc498dc3f4f390a6a55f14dd1fdbd7f6a850a006b85e2891eece95a54a60); /* statement */ 
CreditableAmount = SafeMath.add(CreditableAmount, difference);
            } else {c_0x1a3c44cc(0xd724d30a2f134cf500fc5cc7c6822a4d1500b3ec8c5db711006a06651ce92ad5); /* branch */ 

c_0x1a3c44cc(0x7ea07d407e0ead50a87492f0cdaf540298d06f0b08b60099606292ee7eb22fd4); /* line */ 
                c_0x1a3c44cc(0xe7f370cf08e694b9b1a78a7acdad7e6b1398d7a664cb15ebb731ad9e06718a29); /* statement */ 
for(uint8 i=totalUnlocks - 1; i >= 0 ; i--){
c_0x1a3c44cc(0xcc904ca54d1f500997a70bb7942d30788352bbaeeb79155fc09225d38b4a3515); /* line */ 
                    c_0x1a3c44cc(0x7e2e293f8ae7b3ad0df38487cb83cdcbf704d64460e100e47cf79e51d412e292); /* statement */ 
if(unlockAmounts[i] > 0){c_0x1a3c44cc(0xb5772f8e63bd52bb7c1716bf5251af090e72b9cb69c6e041310682ef93dd77a3); /* branch */ 

c_0x1a3c44cc(0x4f916d7848e0035310920f5681c7faf8d5a00b69cfb5380e82bff78eef308825); /* line */ 
                        c_0x1a3c44cc(0x75af8e5226858b090d65c67dcae0030389e85790fb9d79ecf0ad0bdcafd59842); /* statement */ 
unlockAmounts[i] = SafeMath.add(unlockAmounts[i], difference);
c_0x1a3c44cc(0xd4b9ab3243ab567345198d07b8051b92fd981e7928130d63c414029fd2d141f7); /* line */ 
                        break;
                    }else { c_0x1a3c44cc(0xf7b77d512d2507e382376a26b8132912f32a0af44a0e62e8995ea46b039ae404); /* branch */ 
}
                }
            }
c_0x1a3c44cc(0x894758d9dac1dc1043052ef17fb5c6e0ced61f1f1bb5d29eb9b631b759aff784); /* line */ 
            c_0x1a3c44cc(0xcee7d04a0affc16db2787546c3a7145e6063d02ab7030aee6bd164fe4c86dbce); /* statement */ 
TotalTokens = _amountToActivate;
        }else { c_0x1a3c44cc(0x61c49b458296667c9860e4fffe5ca872736c999b29ee430a59c51e691bc1b929); /* branch */ 
}
c_0x1a3c44cc(0x40e0c89e41403e62d296f8e4cd7b5b3ec3a4862912ac1e84539bb80549adf15b); /* line */ 
        c_0x1a3c44cc(0x1caf9230291bdec8716a0fff2d4d4ac44f2ccc98ddf10fd69aa47ca745d85584); /* statement */ 
return(TotalTokens, CreditableAmount, unlockTimes, unlockAmounts);
    }
}