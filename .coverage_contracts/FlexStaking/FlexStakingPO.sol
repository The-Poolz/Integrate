// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0x98e291e9(bytes32 c__0x98e291e9) pure {}


import "./FlexStakingData.sol";

// FlexStakingPO - contains all Project Owner settings
contract FlexStakingPO is FlexStakingData {
function c_0x1a8e60b7(bytes32 c__0x1a8e60b7) internal pure {}

    event WithdrawnLeftover(uint256 Id, address Receiver, uint256 Amount);

    event CreatedPool(
        address Owner,
        uint256 Id,
        address LockedToken,
        address RewardToken,
        uint256 TokensAmount,
        uint256 StartTime,
        uint256 FinishTime,
        uint256 APR,
        uint256 MinDuration,
        uint256 MaxDuration,
        uint256 MinAmount,
        uint256 MaxAmount,
        uint256 EarlyWithdraw
    );

    function CreateStakingPool(
        address lockedToken, // The token address that is locking
        address rewardToken, // The reward token address
        uint256 tokensAmount, // Total amount of reward tokens
        uint256 startTime, // The time that can start using the staking (all time is Unix, sec)
        uint256 finishTime, // The time that no longer can use the staking
        uint256 APR, // Annual percentage rate
        uint256 minDuration, // For how long the user can set up the staking
        uint256 maxDuration,
        uint256 minAmount, // How much user can stake
        uint256 maxAmount,
        uint256 earlyWithdraw
    )
        public
        whenNotPaused
        notNullAddress(lockedToken)
        notNullAddress(rewardToken)
    {c_0x1a8e60b7(0x2fb1bbfcf0db8d8da8e68d5d899e5e2e868e29498f7a75da069f01fbf762bab7); /* function */ 

c_0x1a8e60b7(0x6d7a993aa89631fcd188a6b9862e3d3cdb4a5db493c1d5bb1b9ca23aff269a0d); /* line */ 
        c_0x1a8e60b7(0x667ad4796ee86d5369f8f95ce166578e2ca1cd2cdb8cfb790d64ebe771029b9f); /* requirePre */ 
c_0x1a8e60b7(0x1b11ba921b50144b7fb7408f91888cf5e03b96905db0adf0f9da18845156a846); /* statement */ 
require(
            APR > 0 && minDuration > 0 && minAmount > 0 && tokensAmount > 0,
            "the value should be greater than zero!"
        );c_0x1a8e60b7(0xc9e2a1485fd6c4607ab422dcf30f7f1508c0e8fb2a73425ee00077a6cf4dea9f); /* requirePost */ 

c_0x1a8e60b7(0xee3941c7e4d4e35ab20169ed8cd1856845533bccb69b2956c0e81bc132e878c6); /* line */ 
        c_0x1a8e60b7(0x0589e975ee9507dd742252b6e1ded975e6cd5f46678cd6720dc30cee1cf22344); /* requirePre */ 
c_0x1a8e60b7(0xc5046a681dfa1317dc2c5f5947616d0dbafeb6cd6ed9b9843d28e73da704a572); /* statement */ 
require(
            startTime >= block.timestamp - 60 && finishTime > startTime,
            "invalid start time!"
        );c_0x1a8e60b7(0xa1889e16c659c8b9eaa54c06d88d1208781f207b23dada1b1266ac22f0e65743); /* requirePost */ 

c_0x1a8e60b7(0x8ae519a21653163a1b56e646251e3c8d4e9456d8316dcc3986ce5ea059ead382); /* line */ 
        c_0x1a8e60b7(0xf2894044bd1d5c7ef373cfa470a3332a97189215c382bf46a26e42d33b5724c7); /* requirePre */ 
c_0x1a8e60b7(0x9117c876aabd6c999bd6b6d734c1c1b75c34da51f0e6d4ab959c595f7578a642); /* statement */ 
require(maxAmount >= minAmount, "invalid maxium amount!");c_0x1a8e60b7(0x26488df8d5771bd0313c80b2ec91bf790b8f630355be81f00bc4ad7df854e645); /* requirePost */ 

c_0x1a8e60b7(0xd53e411ad7f5b235cd7ad3bd457d1e6f61be9a4e1ec7b2da875bc0aa1760998e); /* line */ 
        c_0x1a8e60b7(0xeb968dfaf5a71f2fe643e71dfdbb1a00311b7115f18416b8dc79e79277e344be); /* requirePre */ 
c_0x1a8e60b7(0xd611bc1fb12a5a3be6f30bd1866ffeb1254ee7c0ece2993d920439825a2eb2b7); /* statement */ 
require(
            maxDuration <= finishTime - startTime && maxDuration >= minDuration,
            "invalid maximum duration time!"
        );c_0x1a8e60b7(0x84f22458c88b3a63f9e9529df1ddc25a4c89d02c1cd73e148f6ec1a2a24d44f1); /* requirePost */ 

c_0x1a8e60b7(0xf479d81085689a492745a0c0067460b540894c6b981ab83af0c4221da8979901); /* line */ 
        c_0x1a8e60b7(0x57bdb5592993f979c08bd7806437900306a76334df8653dc6b1775b9b5794949); /* statement */ 
PoolsMap[++TotalPools] = Pool(
            msg.sender,
            lockedToken,
            rewardToken,
            tokensAmount,
            startTime,
            finishTime,
            APR,
            minDuration,
            maxDuration,
            minAmount,
            maxAmount,
            earlyWithdraw
        );
c_0x1a8e60b7(0xc23490f814e07e5cc3fc9b8d862ddfeb616f76be8f88306fe65d049c119f7407); /* line */ 
        c_0x1a8e60b7(0x22c37fa356913abe71a9a8c18f0a21292abb6ded32af4ea7d1e32b54b3a59b01); /* statement */ 
TransferInToken(
            PoolsMap[TotalPools].RewardToken,
            msg.sender,
            tokensAmount
        );
c_0x1a8e60b7(0x857d8734cc499113585b0b377b3610e4e97772fc3da4bc554874a80547e60ae1); /* line */ 
        c_0x1a8e60b7(0x723aabce674ee3fdc4447c4550b69cb2a360f04f180e3c79ab221e0c5df3be98); /* statement */ 
Reserves[TotalPools] = tokensAmount;
c_0x1a8e60b7(0xd8ab76c076b0482900d70207f09f200b692ee899658c854fbd9778bbbc6c31b5); /* line */ 
        c_0x1a8e60b7(0x5f1a6d46d2916a0874d5517f30bf9f7a03b36be4f0ef8af276e36e8be7910f5f); /* statement */ 
emit CreatedPool(
            msg.sender,
            TotalPools,
            lockedToken,
            rewardToken,
            tokensAmount,
            startTime,
            finishTime,
            APR,
            minDuration,
            maxDuration,
            minAmount,
            maxAmount,
            earlyWithdraw
        );
    }

    function WithdrawLeftOver(uint256 id) public {c_0x1a8e60b7(0x3f3e438231881dd39bf61e48b70c79dda993fe45321c5e8339ad1ff5e32646f1); /* function */ 

c_0x1a8e60b7(0xeb15eea89cbb9e1bf993f83efb2375670e44a1a1b4ea803c85756b81acc4d783); /* line */ 
        c_0x1a8e60b7(0x34101b3b70ccdc4fd91c4228d4b70c97b7e6162661b1f8de3b026ef35ad9b783); /* requirePre */ 
c_0x1a8e60b7(0xcef455d88f0a267f7c7039cb4469a9b4784cca6e381348a67ea7b7bdcd27a9a4); /* statement */ 
require(id > 0 && id <= TotalPools, "invalid id!");c_0x1a8e60b7(0xbe1f1a2a4ab315863cefd98e5f0fa4a707a67c27ed96d3fab53967ea61d00253); /* requirePost */ 

c_0x1a8e60b7(0x21d10cc544fcb2e734d25891c46588cfeadbaf176e07aadcc12505e2563f4895); /* line */ 
        c_0x1a8e60b7(0x8c8dc7085fdab84e32a00dc091a255107eff60b7ae2054f980331308985b1553); /* requirePre */ 
c_0x1a8e60b7(0x25caa0d451ef60302639d30715d16df0ea9a901dc55e0ded437dce9d9d77ca0b); /* statement */ 
require(PoolsMap[id].Owner == msg.sender, "invalid owner address!");c_0x1a8e60b7(0x999645cc2eee3a344eb5714aab0855f5013d04494232924dcf75d2503d69dbe2); /* requirePost */ 

c_0x1a8e60b7(0xa418d5e823132f8699deb05b6f0ab7f0779cd381087397cc61705f7d9c6cfbbf); /* line */ 
        c_0x1a8e60b7(0x681314acfd419d172f23941b4bdf385ae464d2c207b72ea31fc940cdbfef5707); /* requirePre */ 
c_0x1a8e60b7(0x11fa957843a7e2e5eb946fa61cc3e8b38ec3245197cebfc487407e99f1a502d1); /* statement */ 
require(
            block.timestamp > PoolsMap[id].FinishTime,
            "should wait when pool is over!"
        );c_0x1a8e60b7(0x7876f8cee34263889af8133259affb4a7e4d04b1d9ccfffccab82eee2c363148); /* requirePost */ 

c_0x1a8e60b7(0xa4d296a09e4f459fdab5d3d5908209dc2ea7d006d98b688c17e2af17408c31df); /* line */ 
        c_0x1a8e60b7(0x4cbd800c07be036860eecc507689358960d5653e1a3d7e896e5fb6a0d2565cbb); /* requirePre */ 
c_0x1a8e60b7(0x810e16838bc1a7c9b26aadad69465cda42832e8dcce5e0a9dcd81eb2c8a19b05); /* statement */ 
require(Reserves[id] > 0, "all tokens distributed!");c_0x1a8e60b7(0xc05ccd0d4a68cb78691d6713d717a2b78973b0ed4bce210229c66052042d4e48); /* requirePost */ 

c_0x1a8e60b7(0xb074da3c68ec9d7c960dafc7fb3bd9f1ce968ae1d1902d9508a9e5d1cdf4701a); /* line */ 
        c_0x1a8e60b7(0x63909f13a5b1291bbad66868d94eca5cca7447f2cf02ae6e324c5f7baf34903e); /* statement */ 
TransferToken(PoolsMap[id].RewardToken, msg.sender, Reserves[id]);
c_0x1a8e60b7(0x0ee2cf4f4d628ed6155c971a674bccf99976bab524b81d59651321b4f75453b8); /* line */ 
        c_0x1a8e60b7(0x9b3dba080d3cacf5bef78dd9285e201bdfa07e5cbc5a6ccfd2e061b0e40bb32b); /* statement */ 
emit WithdrawnLeftover(id, msg.sender, Reserves[id]);
c_0x1a8e60b7(0x68b098415ac6f5ca6c5d436b685715bdb0e57099edb2a57bb6211d80fce71a76); /* line */ 
        c_0x1a8e60b7(0xcaf8af24aa7d34f45bfa1e448a47da8332f485bbda09aa4f753aa56c1a6dd093); /* statement */ 
Reserves[id] = 0;
    }
}
