// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./LockedPoolz.sol";

contract LockedControl is LockedPoolz {
    function TransferPoolOwnership(
        uint256 _PoolId,
        address _NewOwner
    )
        external
        isPoolValid(_PoolId)
        isPoolOwner(_PoolId)
        notZeroAddress(_NewOwner)
    {
        Pool storage pool = AllPoolz[_PoolId];
        pool.Owner = _NewOwner;
        uint256[] storage array = MyPoolz[msg.sender];
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == _PoolId) {
                array[i] = array[array.length - 1];
                array.pop();
            }
        }
        MyPoolz[_NewOwner].push(_PoolId);
        emit PoolOwnershipTransfered(_PoolId, _NewOwner, msg.sender);
    }

    function SplitPoolAmount(
        uint256 _PoolId,
        uint256 _NewAmount,
        address _NewOwner
    )
        external
        isPoolValid(_PoolId)
        isPoolOwner(_PoolId)
        isLocked(_PoolId)
        returns (uint256)
    {
        uint256 poolId = SplitPool(_PoolId, _NewAmount, _NewOwner);
        return poolId;
    }

    function ApproveAllowance(
        uint256 _PoolId,
        uint256 _Amount,
        address _Spender
    )
        external
        isPoolValid(_PoolId)
        isPoolOwner(_PoolId)
        isLocked(_PoolId)
        notZeroAddress(_Spender)
    {
        Pool storage pool = AllPoolz[_PoolId];
        pool.Allowance[_Spender] = _Amount;
        emit PoolApproval(_PoolId, _Spender, _Amount);
    }

    function GetPoolAllowance(
        uint256 _PoolId,
        address _Address
    ) public view isPoolValid(_PoolId) returns (uint256) {
        return AllPoolz[_PoolId].Allowance[_Address];
    }

    function SplitPoolAmountFrom(
        uint256 _PoolId,
        uint256 _Amount,
        address _Address
    )
        external
        isPoolValid(_PoolId)
        isAllowed(_PoolId, _Amount)
        isLocked(_PoolId)
        returns (uint256)
    {
        uint256 poolId = SplitPool(_PoolId, _Amount, _Address);
        Pool storage pool = AllPoolz[_PoolId];
        uint256 _NewAmount = SafeMath.sub(pool.Allowance[msg.sender], _Amount);
        pool.Allowance[_Address] = _NewAmount;
        return poolId;
    }

    function CreateNewPool(
        address _Token, //token to lock address
        uint64 _FinishTime, //Until what time the pool will work
        uint256 _StartAmount, //Total amount of the tokens to sell in the pool
        address _Owner // Who the tokens belong to
    ) public isTokenValid(_Token) notZeroAddress(_Owner) returns (uint256) {
        TransferInToken(_Token, msg.sender, _StartAmount);
        uint256 poolId = CreatePool(_Token, _FinishTime, _StartAmount, _Owner);
        return poolId;
    }

    function CreateMassPools(
        address _Token,
        uint64[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    )
        external
        isGreaterThanZero(_Owner.length)
        isBelowLimit(_Owner.length)
        returns (uint256, uint256)
    {
        require(_Owner.length == _FinishTime.length, "Date Array Invalid");
        require(_Owner.length == _StartAmount.length, "Amount Array Invalid");
        TransferInToken(_Token, msg.sender, getArraySum(_StartAmount));
        uint256 firstPoolId = Index;
        for (uint256 i = 0; i < _Owner.length; i++) {
            CreatePool(_Token, _FinishTime[i], _StartAmount[i], _Owner[i]);
        }
        uint256 lastPoolId = SafeMath.sub(Index, 1);
        return (firstPoolId, lastPoolId);
    }

    // create pools with respect to finish time
    function CreatePoolsWrtTime(
        address _Token,
        uint64[] calldata _FinishTime,
        uint256[] calldata _StartAmount,
        address[] calldata _Owner
    )
        external
        isGreaterThanZero(_Owner.length)
        isGreaterThanZero(_FinishTime.length)
        isBelowLimit(_Owner.length * _FinishTime.length)
        returns (uint256, uint256)
    {
        require(_Owner.length == _StartAmount.length, "Amount Array Invalid");
        TransferInToken(
            _Token,
            msg.sender,
            getArraySum(_StartAmount) * _FinishTime.length
        );
        uint256 firstPoolId = Index;
        for (uint256 i = 0; i < _FinishTime.length; i++) {
            for (uint256 j = 0; j < _Owner.length; j++) {
                CreatePool(_Token, _FinishTime[i], _StartAmount[j], _Owner[j]);
            }
        }
        uint256 lastPoolId = SafeMath.sub(Index, 1);
        return (firstPoolId, lastPoolId);
    }

    function getArraySum(
        uint256[] calldata _array
    ) internal pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < _array.length; i++) {
            sum = sum + _array[i];
        }
        return sum;
    }
}
