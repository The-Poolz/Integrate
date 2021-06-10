// stakeOf(address account) public view returns (uint256)
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface IStaking {
    function stakeOf(address account) external view returns (uint256) ;
}
