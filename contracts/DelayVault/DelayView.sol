// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DelayManageable.sol";

/// @title DelayView - getter view functions
contract DelayView is DelayManageable {
    function GetAllUsersData(address _token)
        external
        view
        returns (address[] memory, Vault[] memory _vaults)
    {
        _vaults = new Vault[](Users[_token].length);
        for (uint256 i = 0; i < Users[_token].length; i++) {
            _vaults[i] = VaultMap[_token][Users[_token][i]];
        }
        return (Users[_token], _vaults);
    }

    function GetAllMyTokens(address _user)
        external
        view
        returns (address[] memory)
    {
        return MyTokens[_user];
    }

    function GetMyTokens(address _user)
        external
        view
        returns (address[] memory)
    {
        address[] storage allTokens = MyTokens[_user];
        address[] memory tokens = new address[](allTokens.length);
        uint256 index;
        for (uint256 i = 0; i < allTokens.length; i++) {
            if (VaultMap[allTokens[i]][_user].Amount > 0) {
                tokens[index++] = allTokens[i];
            }
        }
        return Array.KeepNElementsInArray(tokens, index);
    }

    function GetDelayLimits(address _token)
        external
        view
        returns (
            uint256[] memory _amount,
            uint256[] memory _startDelays,
            uint256[] memory _cliffDelays,
            uint256[] memory _finishDelays
        )
    {
        (_amount, _startDelays, _cliffDelays, _finishDelays) = (
            DelayLimit[_token].Amounts,
            DelayLimit[_token].StartDelays,
            DelayLimit[_token].CliffDelays,
            DelayLimit[_token].FinishDelays
        );
    }

    function GetMinDelays(address _token, uint256 _amount)
        public
        view
        isTokenActive(_token)
        returns (
            uint256 _startDelay,
            uint256 _cliffDelay,
            uint256 _finishDelay
        )
    {
        Delay memory delayLimit = DelayLimit[_token];
        uint256 arrLength = delayLimit.Amounts.length;
        if (arrLength == 0 || delayLimit.Amounts[0] > _amount) return (0, 0, 0);
        _startDelay = delayLimit.StartDelays[0];
        _cliffDelay = delayLimit.CliffDelays[0];
        _finishDelay = delayLimit.FinishDelays[0];
        for (uint256 i = 0; i < arrLength; i++) {
            if (_amount >= delayLimit.Amounts[i]) {
                _startDelay = delayLimit.StartDelays[i];
                _cliffDelay = delayLimit.CliffDelays[i];
                _finishDelay = delayLimit.FinishDelays[i];
            } else {
                break;
            }
        }
    }

    function GetTokenFilterStatus(address _token) external view returns (bool) {
        return DelayLimit[_token].isActive;
    }
}
