// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
function c_0xacbe1b0c(bytes32 c__0xacbe1b0c) pure {}


import "./LockedPoolzData.sol";

contract LockedDealV2 is LockedPoolzData {
function c_0x4e6cf717(bytes32 c__0x4e6cf717) internal pure {}

    function getWithdrawableAmount(uint256 _PoolId) public view isPoolValid(_PoolId) returns(uint256){c_0x4e6cf717(0x5800fdd3aa7ff735c2448b773afb9886b7edbfc41a05cd565be231b143e5ea8e); /* function */ 

c_0x4e6cf717(0xa0a271b5ef3331ccf33803264eb29cce0517930268e95d108306f9614959f37e); /* line */ 
        c_0x4e6cf717(0xa1989a908795fd5bc36fbee673a552ac39eddba57203c7d9bcab39acea4504b6); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0x4e6cf717(0x22beea5b448534b17e6bfadc9247f4f5c0bdb2cfe4a5fe765afe05cf913a11fb); /* line */ 
        c_0x4e6cf717(0x4726c071c26d7099e55a527140f7f211b8c512685b4bab35cb90264cd894f1ad); /* statement */ 
if(block.timestamp < pool.StartTime) {c_0x4e6cf717(0xe6f9e9b167419e8e9bab3252772e9c7cb19636c229f4d1ee88bcb0e333c5f733); /* statement */ 
c_0x4e6cf717(0xd369c8cb6eb2cfa5ecdee89fad9190ac89cb0b0607cea8820a5e8e0c3c3562d0); /* branch */ 
return 0;}else { c_0x4e6cf717(0x9d4da3f20db974f42ff43dd869c47c7c0915f69812da2fe42b711fd3adda86f1); /* branch */ 
}
c_0x4e6cf717(0x820eca1d224a1bbbfdd8325c32f06a9c08d9312468c5fc024c36aa22b5216e34); /* line */ 
        c_0x4e6cf717(0xcdc57516ccfa648a8eaec6ec12d11c710cf85f0c84b255daa945892f868e2676); /* statement */ 
if(pool.FinishTime < block.timestamp) {c_0x4e6cf717(0x81e206e6e1a4926933bb92cea3e8750e16a44d46623fc8e9e139b1116df8d48c); /* statement */ 
c_0x4e6cf717(0xc050b6f042bf725a45bff4f302dbc38ef36ca25c48c95aa20e587e9a5091b0ea); /* branch */ 
return pool.StartAmount - pool.DebitedAmount;}else { c_0x4e6cf717(0xbe445fdf860a547a2087fe6fc1f5223ce3df5105ce4ee7e74bd92033465ed743); /* branch */ 
}
c_0x4e6cf717(0x2f78cf9546611c2d301a8480811ced6314da1776f22aef2575b03f3f650a6e88); /* line */ 
        c_0x4e6cf717(0x79f673d592a56edd8300086a9d77708623160a8b40e2fd1ec57b840cbef42847); /* statement */ 
uint256 totalPoolDuration = pool.FinishTime - pool.StartTime;
c_0x4e6cf717(0x1c882207f8f2c4c56939d02a7fff3cbaa892d997fd0179979da7bec5b1b06550); /* line */ 
        c_0x4e6cf717(0x0df8b3ae509c2941ae7c54613d7ed0213ba8574479a3a4ba213add55f9a0a870); /* statement */ 
uint256 timePassed = block.timestamp - pool.StartTime;
c_0x4e6cf717(0xa827b4e37554bbc9ce6afade99565cfda8f168078422d37f8dc2708dc4d8e554); /* line */ 
        c_0x4e6cf717(0xde8f201f9d565f42e241c1011ac4b65e940b56511b0b7cef6ba3266aadce8a5f); /* statement */ 
uint256 timePassedPermille = timePassed * 1000;
c_0x4e6cf717(0x7afb20c3d3056c9b18fc06ba38534afc25745a812cba50620b8a8522a21db1e6); /* line */ 
        c_0x4e6cf717(0x73dae9aa1e81f3b339c336b359b1d800a39f69184c247df250e0002522b9d7e8); /* statement */ 
uint256 ratioPermille = timePassedPermille / totalPoolDuration;
c_0x4e6cf717(0x6c2741afda05bc4a2c9dd688a05c6ef2a7a42a9fa96cbf5662210dd244e2ed20); /* line */ 
        c_0x4e6cf717(0x8d397ad52a493f9709efca3311d2ed355cfc5bd7f099fd83a7485926e4e19736); /* statement */ 
uint256 debitableAmount = pool.StartAmount * ratioPermille/ 1000;
c_0x4e6cf717(0xf50c9f9c40bc3c6f1bc4357837b80099f6a49947603719b21a973a42da50a8ce); /* line */ 
        c_0x4e6cf717(0x9624fb998da90a16ebea8d469647f9ac20ab78d6eaa540de9fbfaa4e1e86c92b); /* statement */ 
return debitableAmount - pool.DebitedAmount;
    }

    //@dev no use of revert to make sure the loop will work
    function WithdrawToken(uint256 _PoolId) external returns (bool) {c_0x4e6cf717(0x4ab1ab70bed51d0e64147d9da55fdc749b0ec71f20c07450033cb49a8e1d4af4); /* function */ 

        //pool is finished + got left overs + did not took them
c_0x4e6cf717(0x74fb063e9d45b5418f392a35db3b597e59b6ea40a11d812f6d61529efcf5f2ff); /* line */ 
        c_0x4e6cf717(0xa67f6d6dfc5195de457c21bdb8f922e0d6ca3bea2b95cf79bf656579a1eacc73); /* statement */ 
Pool storage pool = AllPoolz[_PoolId];
c_0x4e6cf717(0x15564a7c6ce48e83782fc917a6d1c23215ae7ad5f1465b63b0bb2df8a857332d); /* line */ 
        c_0x4e6cf717(0x8172c9e64c043af18c213f4ef285eddd79288443a9319b434e4999cd509a44c0); /* statement */ 
if (
            _PoolId < Index &&
            pool.StartTime <= block.timestamp &&
            pool.StartAmount - pool.DebitedAmount > 0
        ) {c_0x4e6cf717(0xcdb944143706a8bd95b078df26142698397afcb4f252d3fc19c6c10d48bd6bb8); /* branch */ 

c_0x4e6cf717(0x0c7a6cda5f81baace6189c4f78f2a804949f1358e61d7a374fd1aff2398c8706); /* line */ 
            c_0x4e6cf717(0x6045fa8655410854d5de1b82d18a9e7dff78c5d7711b09c3dfbe3baef8439446); /* statement */ 
uint256 tokenAmount = getWithdrawableAmount(_PoolId);
c_0x4e6cf717(0x8cca38c99b6150b5c87a0a15016c7a3b3d7333186541245f3769054f32df39ec); /* line */ 
            c_0x4e6cf717(0xbdb17485d60c23dbb5564f1a454b244d8bb12750f198ba7cdba8178414f588c1); /* statement */ 
uint256 tempDebitAmount = tokenAmount + pool.DebitedAmount;
c_0x4e6cf717(0xa6579fbf600b493cadb9b65623424d053fe04e444010f03e1853e8e8c3906e43); /* line */ 
            c_0x4e6cf717(0x6e9d57989b61a41c65f30fe1d6a2308f5cbe4c2321e08b606e611457790a5105); /* statement */ 
pool.DebitedAmount = tempDebitAmount;
c_0x4e6cf717(0x213b818b2ddc0323c5995f9ddfed6082713dc5b0d3228c3acf11468020ae862c); /* line */ 
            c_0x4e6cf717(0xcb61c11af8839a4db8b6212ced60514ceb2f67e857aaffd1bc48e2ad1656b543); /* statement */ 
TransferToken(
                pool.Token,
                pool.Owner,
                tokenAmount
            );
c_0x4e6cf717(0x6ef5cad995b91e46fd54109e671973b2a772b79ef6f5344959625b0f654375ea); /* line */ 
            c_0x4e6cf717(0x7e992fce766431d3e7ab07c5a794e5ed3a5cf7d49f03397586dfa7ddca512c6b); /* statement */ 
emit TokenWithdrawn(_PoolId, pool.Owner, tokenAmount);
c_0x4e6cf717(0xfe2282d7ba7d3c3352f3fe779bd8a3f1cb713d6d53f158a7936e7cd3c146a954); /* line */ 
            c_0x4e6cf717(0xb3051b956c307498a556986f8c988733d4bb2de0bf662aaffb50a7e6833ee0bd); /* statement */ 
return true;
        }else { c_0x4e6cf717(0xbf6cb69f7e3a3bb5fab9c111f259f42c29356a9ab3690ea2a3b59a233ab7d5ae); /* branch */ 
}
c_0x4e6cf717(0xa62961f01cb4861bc9771c9b1c954db843fbe628160eb30a6ce21e198215df72); /* line */ 
        c_0x4e6cf717(0x1183c1e70e0bbf7d2cb812426a434f545ea8f249ee91ae680a391b20855326fe); /* statement */ 
return false;
    }
}
