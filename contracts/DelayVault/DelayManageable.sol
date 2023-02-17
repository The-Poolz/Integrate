// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "poolz-helper-v2/contracts/GovManager.sol";
import "./DelayModifiers.sol";
import "./DelayEvents.sol";

/// @title all admin settings
contract DelayManageable is Pausable, GovManager, DelayEvents, DelayModifiers {
    function setLockedDealAddress(address _lockedDealAddress)
        external
        onlyOwnerOrGov
        uniqueAddress(_lockedDealAddress, LockedDealAddress)
    {
        LockedDealAddress = _lockedDealAddress;
    }

    function setMinDelays(
        address _token,
        uint256[] calldata _amounts,
        uint256[] calldata _startDelays,
        uint256[] calldata _cliffDelays,
        uint256[] calldata _finishDelays
    ) external onlyOwnerOrGov notZeroAddress(_token) orderedArray(_amounts) {
        {
            // Stack Too deep error fixing
            _equalValues(
                _amounts.length,
                _startDelays.length,
                _cliffDelays.length,
                _finishDelays.length
            );
        }
        DelayLimit[_token] = Delay(
            _amounts,
            _startDelays,
            _cliffDelays,
            _finishDelays,
            true
        );
        emit UpdatedMinDelays(
            _token,
            _amounts,
            _startDelays,
            _cliffDelays,
            _finishDelays
        );
    }

    function swapTokenStatusFilter(address _token)
        external
        onlyOwnerOrGov
        notZeroAddress(_token)
    {
        DelayLimit[_token].isActive = !DelayLimit[_token].isActive;
    }

    function Pause() external onlyOwnerOrGov {
        _pause();
    }

    function Unpause() external onlyOwnerOrGov {
        _unpause();
    }

    function _equalValues(
        uint256 _amountsL,
        uint256 _startDelaysL,
        uint256 _finishDelaysL,
        uint256 _cliffDelaysL
    ) private pure {
        _equalValue(_amountsL, _startDelaysL);
        _equalValue(_finishDelaysL, _startDelaysL);
        _equalValue(_cliffDelaysL, _startDelaysL);
    }
}
