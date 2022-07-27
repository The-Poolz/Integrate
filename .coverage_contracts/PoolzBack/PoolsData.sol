// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Pools.sol";

contract PoolsData is Pools {
function c_0x44fb0dfe(bytes32 c__0x44fb0dfe) internal pure {}

    enum PoolStatus {Created, Open, PreMade, OutOfstock, Finished, Close} //the status of the pools

    modifier isPoolId(uint256 _id) {c_0x44fb0dfe(0xf07752da46cf3e27bb033c217709f3aad898c097d72ca1f8ec98399f39456433); /* function */ 

c_0x44fb0dfe(0xd5cb058108856a3a814e276e9d3780aabe2a077c10cc59c5ef5c78b1b76ce4b2); /* line */ 
        c_0x44fb0dfe(0x45b59a1126c2fa1c31c46dd8a32357005997074716b0ef1aeea001233ab73a71); /* requirePre */ 
c_0x44fb0dfe(0x45413bdb5e708a0b5a5e17c538058569c3969e820dab3f6567746629587f41ae); /* statement */ 
require(_id < poolsCount, "Invalid Pool ID");c_0x44fb0dfe(0x5b2ec90b077a1eebcf6797ba07da57f1e823c2ef7e257afbfad9968b86064e55); /* requirePost */ 

c_0x44fb0dfe(0x39e48350ee5d968cebe586e8ca2a908c4af682005833569efd620b8c0d03796a); /* line */ 
        _;
    }

    function GetMyPoolsId() public view returns (uint256[] memory) {c_0x44fb0dfe(0x94504d62d83b340c7bb1b842e2a378b20c4d6a9147c106aa8ec00fbd9bf7a7d7); /* function */ 

c_0x44fb0dfe(0x18195a0b3d9c3322b7d1201ecf64169723dca9ba0150442583bfee722a8b0f06); /* line */ 
        c_0x44fb0dfe(0x76cda4ad893f0cf866e8a76a9168963d1e1e40130c96fe7213ffe48b98cc181d); /* statement */ 
return poolsMap[msg.sender];
    }

    function GetPoolBaseData(uint256 _Id)
        public
        view
        isPoolId(_Id)
        returns (
            address,
            address,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {c_0x44fb0dfe(0x69f3848ef6be4573ec1cab0ccc0a698976880a43a6e00df0316ea2fbc51b45f8); /* function */ 

c_0x44fb0dfe(0xcece4e6344ef2ed362bbf2e3a17b418f69ca78a688825f140a9e1cde68ea496c); /* line */ 
        c_0x44fb0dfe(0x9ed4956ce3894f5cacfaaf254d90f6fded7f93226d79a65a07df7120d7fbe124); /* statement */ 
return (
            pools[_Id].BaseData.Token,
            pools[_Id].BaseData.Creator,
            pools[_Id].BaseData.FinishTime,
            pools[_Id].BaseData.Rate,
            pools[_Id].BaseData.POZRate,
            pools[_Id].BaseData.StartAmount
        );
    }

    function GetPoolMoreData(uint256 _Id)
        public
        view
        isPoolId(_Id)
        returns (
            uint64,
            uint256,
            uint256,
            uint256,
            uint256,
            bool
        )
    {c_0x44fb0dfe(0x13d81209479c123d3288be460ad26dbe4558d40b3c815efa3d86580cd663a97d); /* function */ 

c_0x44fb0dfe(0xd3b6df99b69a71567fa4af209255efa026431a6c1474ea90b92b89f88da8bc63); /* line */ 
        c_0x44fb0dfe(0x45e4ea89188578a1a441500c7bfab63d0af7c0aa6de2babca80788cec43c23d3); /* statement */ 
return (
            pools[_Id].MoreData.LockedUntil,
            pools[_Id].MoreData.Lefttokens,
            pools[_Id].MoreData.StartTime,
            pools[_Id].MoreData.OpenForAll,
            pools[_Id].MoreData.UnlockedTokens,
            pools[_Id].MoreData.Is21DecimalRate
        );
    }

    function GetPoolExtraData(uint256 _Id)
        public
        view
        isPoolId(_Id)
        returns (
            bool,
            uint256,
            address
        )
    {c_0x44fb0dfe(0x1b7a5648716f81e37c641476456497fce1c7b597f8cdf2996483bad4edf29b69); /* function */ 

c_0x44fb0dfe(0xda6792e190e79f4b9c120f7799b3ea4bb8ccce2f760b46f84cb3a5203c6d55c1); /* line */ 
        c_0x44fb0dfe(0xf0813196618ca0593800ed0775c9eeaab28d155393ed30039b504cf0844cce26); /* statement */ 
return (
            pools[_Id].MoreData.TookLeftOvers,
            pools[_Id].MoreData.WhiteListId,
            pools[_Id].BaseData.Maincoin
        );
    }

    function IsReadyWithdrawLeftOvers(uint256 _PoolId)
        public
        view
        isPoolId(_PoolId)
        returns (bool)
    {c_0x44fb0dfe(0x4e15d167757842eaf1965a852c06a661fed066b18fcf615f60adf492d86caba9); /* function */ 

c_0x44fb0dfe(0x9dee80098f04b5fef219a26a1ef8c6e2617da8ba897dbb51c138d1466b3e83a5); /* line */ 
        c_0x44fb0dfe(0x73b70b0063c380e8c3560d9180d758f37fff5d2ce30d7bbc35c49a4b2fa609d9); /* statement */ 
return
            pools[_PoolId].BaseData.FinishTime <= now &&
            pools[_PoolId].MoreData.Lefttokens > 0 &&
            !pools[_PoolId].MoreData.TookLeftOvers;
    }

    //@dev no use of revert to make sure the loop will work
    function WithdrawLeftOvers(uint256 _PoolId) public isPoolId(_PoolId) returns (bool) {c_0x44fb0dfe(0x76b7ffd737eb1eb81d26db57a7197865adcc0608b7ce067cb18dc18e22735726); /* function */ 

        //pool is finished + got left overs + did not took them
c_0x44fb0dfe(0xf545f945e6e6db33cb728de2cabf5aaef13ddca729fed99ce5384819b091d721); /* line */ 
        c_0x44fb0dfe(0xcf748eb8b71acb16db6e35e622c4878205b8fc14a6d250edf8b3fca3b2c2d18b); /* statement */ 
if (IsReadyWithdrawLeftOvers(_PoolId)) {c_0x44fb0dfe(0x0d4e3dff5fb24a1bcdbac39338561e520705730dfdc68c30348d7e90dbe2c936); /* branch */ 

c_0x44fb0dfe(0x1083fede29cf11960d9a89d12dc27d15aa361fff942508577cd791b399967936); /* line */ 
            c_0x44fb0dfe(0x1ebe2028b2c1b856d1dd99556ad4e95946735b99645cfe9ef3522902f98bbf2f); /* statement */ 
pools[_PoolId].MoreData.TookLeftOvers = true;
c_0x44fb0dfe(0xeb67b3a9ab4c21addfe3cfc25d3a2f049b22c996bdac11a2c0b078e0bf598c50); /* line */ 
            c_0x44fb0dfe(0x7c8ca64d98809247f210a5f853e31a802e8a8ae31b26ecfa9727f29ecbb211c0); /* statement */ 
TransferToken(
                pools[_PoolId].BaseData.Token,
                pools[_PoolId].BaseData.Creator,
                pools[_PoolId].MoreData.Lefttokens
            );
c_0x44fb0dfe(0x20479ab9e14d11641eb345a52312ae3a3bb0783c9d6d0931e4758d81392bb5a2); /* line */ 
            c_0x44fb0dfe(0x3967edf9d886984635ae657360ba7c53f1a6e57b0ed2d74995c59788be138e37); /* statement */ 
return true;
        }else { c_0x44fb0dfe(0x8011f6e30e6bbbd3af85eeede3c9af99af53d4cf4b274a30a77f1322432e9855); /* branch */ 
}
c_0x44fb0dfe(0x96049f020465233310cdbeeec0d1c10c547f3e8e0a207974c303d68c6e0dcf21); /* line */ 
        c_0x44fb0dfe(0x8caf52ecf2d33bffe5f5be70b907931e0ad6a0e8c9d56384b1073fc393849cfe); /* statement */ 
return false;
    }

    //calculate the status of a pool
    function GetPoolStatus(uint256 _id)
        public
        view
        isPoolId(_id)
        returns (PoolStatus)
    {c_0x44fb0dfe(0x30957e9ea1d6b7b8d81d2c5d0d72718d5abcdf0dda29a5e0d5100efe81ef4c5a); /* function */ 

        //Don't like the logic here - ToDo Boolean checks (truth table)
c_0x44fb0dfe(0x7edb831793941fe7a6667b53d97cffc350c3b4dd4803bb4d0ca54ed8dbf60a1a); /* line */ 
        c_0x44fb0dfe(0x446fb94ad841be5abf81062526fd24a63a2838463576eab921862da76bad8d10); /* statement */ 
if (now < pools[_id].MoreData.StartTime) {c_0x44fb0dfe(0x461af38d20a7f93841847c2a2d345d2aed6e724460dd0e1e616c23e6a0142bbf); /* statement */ 
c_0x44fb0dfe(0x94d8791ce0c1368b6e1d55724883cdcbea9520973a3ef7b19abf728312858551); /* branch */ 
return PoolStatus.PreMade;}else { c_0x44fb0dfe(0x89fa8fd4112a2b41493a00ce7f65ef2aeca733b44866a0b2550d731445421106); /* branch */ 
}
c_0x44fb0dfe(0x1fea22d4b23f031869bf8b235ec4900bc4046a17aeee0b5dc0744ea27fea95b3); /* line */ 
        c_0x44fb0dfe(0x758c0d304b0c41c26f8968104c0ce4590d465a305bd677a53965c4b8aea471e9); /* statement */ 
if (
            now < pools[_id].MoreData.OpenForAll &&
            pools[_id].MoreData.Lefttokens > 0
        ) {c_0x44fb0dfe(0x2bb1de4ad703cb79e6b821bf61fc194f67e36ae0126979e773d6e8a177252c9c); /* branch */ 

            //got tokens + only poz investors
c_0x44fb0dfe(0x489b72d5622afefcaefcf7bcfb71d3625d0e0f45d761bd54e7ad98463738cb9c); /* line */ 
            c_0x44fb0dfe(0xa3b2a07b33d6c1abb74bee3f1b8d560981b4eeef5258795aec35f2287bca4134); /* statement */ 
return (PoolStatus.Created);
        }else { c_0x44fb0dfe(0xeba21ebb3a5adb7f7cf7b5044fb6be6d8f97de55610132a33b8d5fe352d77704); /* branch */ 
}
c_0x44fb0dfe(0x5fb49021260704194ab76927c89c6f86bdac6e2d136b6a4d3282ce3b11963267); /* line */ 
        c_0x44fb0dfe(0xd34cf8f34e001499639fd7e4cd982e2a4d1c1e982a42cb2af66b8c26de5a844c); /* statement */ 
if (
            now >= pools[_id].MoreData.OpenForAll &&
            pools[_id].MoreData.Lefttokens > 0 &&
            now < pools[_id].BaseData.FinishTime
        ) {c_0x44fb0dfe(0x277ff7c2b4c1f580e2f0a65e471536671adcfe6582d8d2a4bfd2459683c17948); /* branch */ 

            //got tokens + all investors
c_0x44fb0dfe(0xffdecf7fcda8e544f7c895b5014f17e1d72223f239c63da101c804e24206440a); /* line */ 
            c_0x44fb0dfe(0x29c951103c7ba6937d803963a46f3c759fc3f75b4caec935a790fc1bbc0d89e6); /* statement */ 
return (PoolStatus.Open);
        }else { c_0x44fb0dfe(0x81aa174209adf01eeaf1cf145c9f5729d7802b59b5ee12942222b65660904097); /* branch */ 
}
c_0x44fb0dfe(0xb828e17560b49775b2141cfe62b5fb05d249ecd3487a36275ab040c92ce94a14); /* line */ 
        c_0x44fb0dfe(0x7893ab4f9947421c6873f678ac473667e2182e713f457c4613093a51ed5d8b34); /* statement */ 
if (
            pools[_id].MoreData.Lefttokens == 0 &&
            isPoolLocked(_id) &&
            now < pools[_id].BaseData.FinishTime
        ) //no tokens on locked pool, got time
        {c_0x44fb0dfe(0x45fd2131d2362d4b6dab9f7eed671278d725ac47852482a10aa084d246411f5c); /* branch */ 

c_0x44fb0dfe(0x5fd51c88a52e1dc068f39ebbc51f96733e91aff45a1433b7da37b92b3f4069c4); /* line */ 
            c_0x44fb0dfe(0x11a69cf412b01d72cbf447048872993f1df2a657d83169bb33fffced9309a944); /* statement */ 
return (PoolStatus.OutOfstock);
        }else { c_0x44fb0dfe(0x995103e7eabac6c0192334f3f4ee690b72c8f4f77f2a3bf46c766214f0a9843b); /* branch */ 
}
c_0x44fb0dfe(0x594a867cf6bcbf4592e5a9e595cc1c6581dd8ff884d1be99e8bc8ac1d0cff135); /* line */ 
        c_0x44fb0dfe(0x00ab2ca4d18751e2f15ddf4bd77cb11714faa942270ba53d9c4feedd839df962); /* statement */ 
if (
            pools[_id].MoreData.Lefttokens == 0 && !isPoolLocked(_id)
        ) //no tokens on direct pool
        {c_0x44fb0dfe(0xed70c28232e866fffb218467e21106c678d052c54985efa7827d548cb62deebc); /* branch */ 

c_0x44fb0dfe(0xaff54757e77236e3b7f57c5a9514c4fb631bcee38867611d9bd133c6a9d7b4af); /* line */ 
            c_0x44fb0dfe(0xc827a7b295ee5f7b94009b33fa83126f3dbc0988631ea0a166e1a716c3934b54); /* statement */ 
return (PoolStatus.Close);
        }else { c_0x44fb0dfe(0xf0d20f9378f1d0293d2801cbed76a0f336124c51749e3e1d8261a5dab0d46b7d); /* branch */ 
}
c_0x44fb0dfe(0x77f10efd5824f617bb67b39beb8bc659064216409d6900810a07712cfc120ccb); /* line */ 
        c_0x44fb0dfe(0xd1fa058259e839bfec03c979fd3fcb65a3af78c26cf8849c014e09d2362933f2); /* statement */ 
if (
            now >= pools[_id].BaseData.FinishTime &&
            !isPoolLocked(_id)
        ) {c_0x44fb0dfe(0x87768c0dd5e3298110d2b8b8aeab2426bcf0939853d31e3ac867f7513eab72fd); /* branch */ 

            // After finish time - not locked
c_0x44fb0dfe(0x218ed07532c40aa552e7c791fcec30f46709bd0c2e325965bef3d1777cf7a1d2); /* line */ 
            c_0x44fb0dfe(0x5c0986069e474a097afd4466043118f6db10ee566cd6411fa7f8aac50b047918); /* statement */ 
if (pools[_id].MoreData.TookLeftOvers) {c_0x44fb0dfe(0xeb49ecbcbc6cebfb52a073030627c20e3ea5d20421f699e4197f62c6c341b6ce); /* statement */ 
c_0x44fb0dfe(0x9b6afcfda7dae7ae37cacee3fb89ce2af013b9792222af257bae2043d6b44130); /* branch */ 
return (PoolStatus.Close);}else { c_0x44fb0dfe(0x3f8785bbedf27438d233d00291bbb5d84356d012538a2b9776a6d587a04d6f55); /* branch */ 
}
c_0x44fb0dfe(0x486fbd818e958b71afeaf4dc7ad73b3a4f093d52841e84de766a126691580347); /* line */ 
            c_0x44fb0dfe(0x9312ca8fac9fdee4e8ce0f064f55a04c1b202ec0e2f257da49a241b64845dfc3); /* statement */ 
return (PoolStatus.Finished);
        }else { c_0x44fb0dfe(0xe5b9099da660f3eb901d2a4af218163ddbe99f97d6909a81be859e09044a5fb0); /* branch */ 
}
c_0x44fb0dfe(0xefd89f2e1ae45e05d4b8b564b237cb09e4ebb7ecb4f97dab54f0bff7753055b9); /* line */ 
        c_0x44fb0dfe(0x4bffa6c9957bcbd65df57a7a2b8d009e7de8a60e677557c0998694a3530ec966); /* statement */ 
if (
            (pools[_id].MoreData.TookLeftOvers ||
                pools[_id].MoreData.Lefttokens == 0) &&
            (pools[_id].MoreData.UnlockedTokens +
                pools[_id].MoreData.Lefttokens ==
                pools[_id].BaseData.StartAmount)
        ) {c_0x44fb0dfe(0xf1aa031af975a72a428b9dfe64f38ca03a2b223dd311e787a18b1a76e2be1d4b); /* statement */ 
c_0x44fb0dfe(0x94f0b89f287de150281055a77c666cb9482e2706be7721bb4c03c595b734546b); /* branch */ 
return (PoolStatus.Close);}else { c_0x44fb0dfe(0x8b817024aeabb6d5cc8a4b2be0746cf887686f57eaaa680a88673fce757ea482); /* branch */ 
}
c_0x44fb0dfe(0x544d7ec9e8c4ef9a83f9bad62edcd3e3dc272e7a71185523a8d72fd6cbb5105e); /* line */ 
        c_0x44fb0dfe(0xc4e991de8b4ff1abc9dc36355a2bdf21ef7aeed2ba70a7a7b5b060d81c8138a3); /* statement */ 
return (PoolStatus.Finished);
    }
}
