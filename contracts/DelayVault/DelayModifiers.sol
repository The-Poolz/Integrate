// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DelayData.sol";
import "poolz-helper-v2/contracts/Array.sol";

/// @title contains modifiers.
contract DelayModifiers is DelayData {
    modifier uniqueAddress(address _addr, address _oldAddr) {
        require(_addr != _oldAddr, "can't set the same address");
        _;
    }

    modifier notZeroAddress(address _addr) {
        _notZeroAddress(_addr);
        _;
    }

    modifier isVaultNotEmpty(address _token) {
        require(
            VaultMap[_token][msg.sender].Amount > 0,
            "vault is already empty"
        );
        _;
    }

    ///@dev By default, each token is inactive
    modifier isTokenActive(address _token) {
        require(
            DelayLimit[_token].isActive,
            "there are no limits set for this token"
        );
        _;
    }

    modifier orderedArray(uint256[] memory _array) {
        require(Array.isArrayOrdered(_array), "array should be ordered");
        _;
    }

    function _shortStartDelay(address _token, uint256 _startDelay)
        internal
        view
    {
        require(
            _startDelay >= VaultMap[_token][msg.sender].StartDelay,
            "can't set a shorter start period than the last one"
        );
    }

    function _shortFinishDelay(address _token, uint256 _finishDelay)
        internal
        view
    {
        require(
            _finishDelay >= VaultMap[_token][msg.sender].FinishDelay,
            "can't set a shorter finish period than the last one"
        );
    }

    function _shortCliffDelay(address _token, uint256 _cliffDelay)
        internal
        view
    {
        require(
            _cliffDelay >= VaultMap[_token][msg.sender].CliffDelay,
            "can't set a shorter cliff period than the last one"
        );
    }

    function _notZeroAddress(address _addr) private pure {
        require(_addr != address(0), "address can't be null");
    }

    function _equalValue(uint256 _fLength, uint256 _sLength) internal pure {
        require(_fLength == _sLength, "invalid array length");
    }

    function _checkMinDelay(uint256 _delay, uint256 _minDelay) internal pure {
        require(_delay >= _minDelay, "delay less than min delay");
    }
}
