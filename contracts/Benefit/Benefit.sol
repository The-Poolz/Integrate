// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./IPozBenefit.sol";
import "./IStaking.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Benefit is IPOZBenefit, Ownable {
    constructor() public {
        MinHold = 1;
        ChecksCount = 0;
    }

    struct BalanceCheckData {
        bool IsToken; //token or staking contract address
        address ContractAddress; // the address of the token or the staking
        address LpContract; // check the current Token Holdin in Lp
    }

    uint256 public MinHold; //minimum total holding to be POOLZ Holder
    mapping(uint256 => BalanceCheckData) CheckList; //All the contracts to get the sum
    uint256 public ChecksCount; //Total Checks to make

    function SetMinHold(uint256 _MinHold) public onlyOwner {
        require(_MinHold > 0, "Must be more then 0");
        MinHold = _MinHold;
    }

    function AddNewLpCheck(address _Token, address _LpContract)
        public
        onlyOwner
    {
        CheckList[ChecksCount] = BalanceCheckData(false, _Token, _LpContract);
        ChecksCount++;
    }

    function AddNewToken(address _ContractAddress) public onlyOwner {
        CheckList[ChecksCount] = BalanceCheckData(
            true,
            _ContractAddress,
            address(0x0)
        );
        ChecksCount++;
    }

    function AddNewStaking(address _ContractAddress) public onlyOwner {
        CheckList[ChecksCount] = BalanceCheckData(
            false,
            _ContractAddress,
            address(0x0)
        );
        ChecksCount++;
    }

    function RemoveLastBalanceCheckData() public onlyOwner {
        require(ChecksCount > 0, "Can't remove from none");
        ChecksCount--;
    }

    function RemoveAll() public onlyOwner {
        ChecksCount = 0;
    }

    function CheckBalance(address _Token, address _Subject)
        internal
        view
        returns (uint256)
    {
        return ERC20(_Token).balanceOf(_Subject);
    }

    function CheckStaking(address _Contract, address _Subject)
        internal
        view
        returns (uint256)
    {
        return IStaking(_Contract).stakeOf(_Subject);
    }

    function IsPOZHolder(address _Subject) override external view returns (bool) {
        return CalcTotal(_Subject) >= MinHold;
    }

    function CalcTotal(address _Subject) public view returns (uint256) {
        uint256 Total = 0;
        for (uint256 index = 0; index < ChecksCount; index++) {
            if (CheckList[index].LpContract == address(0x0)) {
                Total =
                    Total +
                    (
                        CheckList[index].IsToken
                            ? CheckBalance(
                                CheckList[index].ContractAddress,
                                _Subject
                            )
                            : CheckStaking(
                                CheckList[index].ContractAddress,
                                _Subject
                            )
                    );
            } else {
                Total =
                    Total +
                    _CalcLP(
                        CheckList[index].LpContract,
                        CheckList[index].ContractAddress,
                        _Subject
                    );
            }
        }
        return Total;
    }

    function _CalcLP(
        address _Contract,
        address _Token,
        address _Subject
    ) internal view returns (uint256) {
        uint256 TotalLp = ERC20(_Contract).totalSupply();
        uint256 SubjectLp = ERC20(_Contract).balanceOf(_Subject);
        uint256 TotalTokensOnLp = ERC20(_Token).balanceOf(_Contract);
        //SubjectLp * TotalTokensOnLp / TotalLp
        return SafeMath.div(SafeMath.mul(SubjectLp, TotalTokensOnLp), TotalLp);
    }
}
