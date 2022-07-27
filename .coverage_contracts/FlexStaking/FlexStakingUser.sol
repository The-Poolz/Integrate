// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0xa91c2fdd(bytes32 c__0xa91c2fdd) pure {}


import "./FlexStakingPO.sol";
import "poolz-helper-v2/contracts/interfaces/ILockedDeal.sol";

// FlexStakingUser - contains all user settings
contract FlexStakingUser is FlexStakingPO {
function c_0xf4ff1913(bytes32 c__0xf4ff1913) internal pure {}

    event StakeInfo(
        address User,
        uint256 Id,
        uint256 LockedAmount,
        uint256 Earn,
        uint256 Duration
    );

    function Stake(
        uint256 id,
        uint256 amount,
        uint256 duration // in seconds
    ) public whenNotPaused notNullAddress(LockedDealAddress) {c_0xf4ff1913(0x96254301da7ac892c3b984978a113d8ee11e282af4b7bf86749fc9629dfaf605); /* function */ 

c_0xf4ff1913(0x2adb84f749b9a96e150e220c0c3a3c6e4e6c0b86dbabd361f0e73e4736bfcea1); /* line */ 
        c_0xf4ff1913(0x08d6634e33cfeda6868ef0077958b553401372a3c6a83c1d97c32aecacf4bf4d); /* requirePre */ 
c_0xf4ff1913(0x3abfd8babd97bf87f644aad58113a5e1bdaa064d1ebe3db46217e4d44f991464); /* statement */ 
require(id > 0 && id <= TotalPools, "invalid id!");c_0xf4ff1913(0x125d63276503ed72946e884a01ecd8bfe189627cab2d6c4c5d8a08658ba2c66e); /* requirePost */ 

c_0xf4ff1913(0x066721695941154ff652479ee662f5f1e9ccb6321b61dd3c04b2df395316f0b0); /* line */ 
        c_0xf4ff1913(0x7aff1d8a9b06f5f97f53ba54eb8bdb18c2201e28ddd1df18650a3686ba6ddd5e); /* requirePre */ 
c_0xf4ff1913(0xe196bc8d1a980738e23a41efa266e33c7cad5c8c28d5666d8b30606c1e7bc728); /* statement */ 
require(
            amount >= PoolsMap[id].MinAmount &&
                amount <= PoolsMap[id].MaxAmount,
            "wrong amount!"
        );c_0xf4ff1913(0xc6298d5604986e6e2f8602ac4f0b3dbd8500b2ceded0b3e55e45aa9e8bd671e5); /* requirePost */ 

c_0xf4ff1913(0x74605ff354ef9764653a614540f33425dcfd974b72a232127c550d9ca15c8b5a); /* line */ 
        c_0xf4ff1913(0xb05d5349dc23c023fd1bd53564dce7c317f28fe779611d4da4a67c6bbbb7e8cb); /* requirePre */ 
c_0xf4ff1913(0xed4966d9030adae3aab87dcb593912627dec946a30219867bae0d983820b9ed1); /* statement */ 
require(
            duration <= PoolsMap[id].MaxDuration &&
                duration >= PoolsMap[id].MinDuration,
            "wrong duration time!"
        );c_0xf4ff1913(0x2d0a2ef29f0a506d024223a82c3db946f9ea06a19d86a539ad629e4fd3f6dddd); /* requirePost */ 

c_0xf4ff1913(0x7b3f75957135e0f09b80a4d140cad5364e582784a9b9daad06c7e854cd6e121a); /* line */ 
        c_0xf4ff1913(0x72338c56e77ed5959966e35297250f64df21f6c1b6b190adc04b464eb218b13c); /* statement */ 
uint256 earn = ((amount * PoolsMap[id].APR * duration) / 100) /
            365 /
            24 /
            60 /
            60;
c_0xf4ff1913(0x9ead4dad6f0c51642f2936b6524d4fb69e825b3f3e11f63e3fef62838cd568f9); /* line */ 
        c_0xf4ff1913(0x2af5c39807162b2689a29df901a6a3f866f5ca74f8686fe10704f5c56d27d7de); /* requirePre */ 
c_0xf4ff1913(0xafd5a8abd4f88991e7eed63eb45b7c59dc26dbc36dbb303ceb3979ff67e1d118); /* statement */ 
require(Reserves[id] >= earn, "not enough tokens!");c_0xf4ff1913(0xac0e287630693f72aa57512d32132afe1510166553cf4f2474d9ae439e4d656c); /* requirePost */ 

c_0xf4ff1913(0x0384de28c41d14205244625963e671e52c2055ab2fa0f26b13ff9449a85b1672); /* line */ 
        c_0xf4ff1913(0x0ee6f29b87f20162b115cda88143319cd5f4d8fc3f3294e3806966f8b283d8cc); /* requirePre */ 
c_0xf4ff1913(0xd2181112b8df110ec9df67139d1342709f3ff91ceaaf0e707aeedb09ccebdfd4); /* statement */ 
require(
            PoolsMap[id].StartTime <= block.timestamp &&
                PoolsMap[id].FinishTime >= block.timestamp,
            "Pool is not started or is finished!"
        );c_0xf4ff1913(0xb3012d65edfd73b7e103fb5ff49d19d5c3708070a52480b6399d0189cf5365ea); /* requirePost */ 

c_0xf4ff1913(0x1dd39d439e402f7d63c3e482ecef2b8753e53163ae132683358539b022fe4724); /* line */ 
        c_0xf4ff1913(0x4a7a1830090af38af4a9b6db9d27ea9c1e0082363eba9b1af0de2e9f29210fca); /* statement */ 
uint256 lockedAmount = amount;
c_0xf4ff1913(0xfad7f364559f24ac1677bf2e49a9d364a43ffd94334d6215108c3d8649a078ce); /* line */ 
        c_0xf4ff1913(0x493f4967fdb898d93bbb51a4c2ded54be0e968b673178dcc616ea1a049105072); /* statement */ 
address rewardToken = PoolsMap[id].RewardToken;
c_0xf4ff1913(0x51a624ced47399a2abc701bc194e90d9f1df44263b56a190fe0fa24233650556); /* line */ 
        c_0xf4ff1913(0x0a471f06a80a62a3c2e20360b137cc14152b3640fbfdcbf3b3bae208cf968d10); /* statement */ 
address lockedToken = PoolsMap[id].LockedToken;
c_0xf4ff1913(0xa24cfbf6dcf5fb727dbb2f0d1003b8938487c5bead6977ddac0d9b4891a3c821); /* line */ 
        c_0xf4ff1913(0x97105bb6272530dd120a80ac6b837df14a1b88eb747a65ddde4df2279076dc2e); /* statement */ 
uint256 earlyWithdraw = PoolsMap[id].EarlyWithdraw;
c_0xf4ff1913(0x63188f8d9a9bf678c4a3dd24cc32c6340bc3fd8a2b3331b36cf5b60179a52157); /* line */ 
        c_0xf4ff1913(0x4be9af491bf2e2fa396b969e740eedc4e7d9b3c1058555e6ac085834cfda2bd6); /* statement */ 
TransferInToken(lockedToken, msg.sender, amount);
c_0xf4ff1913(0xc00614c27e213914d032ae5d98ecdbcbed1635a1f8261c1ce15ee49e652abab6); /* line */ 
        c_0xf4ff1913(0xc8d8da231689525839b548fd1fbdc37c1285f5fb617445655afda5e3c09180c5); /* statement */ 
if (rewardToken != lockedToken && earn > 0) {c_0xf4ff1913(0xd2a77a71e7f9eb4de79288b93b3a6e6c161212e84faea6a1d947122c82aecc42); /* branch */ 

c_0xf4ff1913(0x06b97f069cc7f22c663b4bbf441eed513619ad439da68e3d445b031c0fd49391); /* line */ 
            c_0xf4ff1913(0xf720d99533a9246657c38285b305cc9a835a2f4eaacc58e8f556cd0f344ff790); /* statement */ 
LockToken(rewardToken, earn, duration, earlyWithdraw);
        } else {c_0xf4ff1913(0xc27e8de72a2f822fc29ead2a5609194f1d0eee386a54a50e249a711f84cc56f8); /* branch */ 

c_0xf4ff1913(0x980c0cbd7fd166eb506e9dc0fcde62ba183e9bd244ab7c8100beadab669b8f6c); /* line */ 
            c_0xf4ff1913(0x41c7401675ee7adcad3fa84496d50834f3e1ac8dfcdb091f567e2001c373fc36); /* statement */ 
lockedAmount += earn;
        }
c_0xf4ff1913(0xd484c666b90db642cfd4f9d13ded13fbb6205ebe38594574cd0ceddff10d8fd9); /* line */ 
        c_0xf4ff1913(0x7233e7616f47d3ee4f9f210ceee54ff2b98627ddffead1a2145ca693d6fb600f); /* statement */ 
LockToken(lockedToken, lockedAmount, duration, earlyWithdraw);
c_0xf4ff1913(0x860ba3c46e97a905740de4f3448c784a1896486aabef10870dee02a2626e9a38); /* line */ 
        c_0xf4ff1913(0xf729548dcb18a696b471d148d3b9374052dacf1359ad6d38b665f6e6244c6e20); /* statement */ 
Reserves[id] -= earn;
c_0xf4ff1913(0xfd67bb4bb517fee34aa1754056a3a5db09790b0695def74ac952f1d75e4c6315); /* line */ 
        c_0xf4ff1913(0x1c2c926e6f4fdc392e80030fc2166e30491b9291f6e049d162da289fdcbcc8d1); /* statement */ 
emit StakeInfo(msg.sender, id, amount, earn, duration);
    }

    function LockToken(
        address token,
        uint256 amount,
        uint256 duration,
        uint256 earlyWithdraw
    ) internal {c_0xf4ff1913(0x7052a657cb41b0a786912a4a6ae7500bb3930a9c0893815eb75c2c9deaf9d043); /* function */ 

c_0xf4ff1913(0x3df0f1f94c14aef0c4fbc99737b6a7ecc316bd3dcfaa83b35f75bb2996358e4b); /* line */ 
        c_0xf4ff1913(0xc9c0d6f06d561b0aa5c0eac5c7f8b8712a822149388c7aa893e6a750afcdd58e); /* statement */ 
ApproveAllowanceERC20(token, LockedDealAddress, amount);
c_0xf4ff1913(0xafd50c0b77480757d314e5b6be95e0705a7574e5366cea0815d7561405a2a0a3); /* line */ 
        c_0xf4ff1913(0x7f898144b27d7a3da2b28ab3f710f64ddbe07d8529af1a1b49f84958646c976c); /* statement */ 
ILockedDeal(LockedDealAddress).CreateNewPool(
            token,
            block.timestamp + duration - earlyWithdraw,
            block.timestamp + duration,
            amount,
            msg.sender
        );
    }
}
