// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.7.0;

import "./Manageable.sol";
import "poolz-helper/contracts/IWhiteList.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract WhiteListConvertor is Manageable {
    using SafeMath for uint256;

    constructor(address _WhiteListAddress) public {
        WhiteListAddress = _WhiteListAddress;
    }

    function Register(
        address _Subject,
        uint256 _Id,
        uint256 _Amount
    ) external {
        require(
            msg.sender == Identifiers[_Id].Contract,
            "Only the Contract can call this"
        );
        IWhiteList(WhiteListAddress).Register(
            _Subject,
            _Id,
            Convert(_Amount, _Id, !Identifiers[_Id].Operation)
        );
    }

    function LastRoundRegister(address _Subject, uint256 _Id) external {
        require(
            msg.sender == Identifiers[_Id].Contract,
            "Only the Contract can call this"
        );
        IWhiteList(WhiteListAddress).LastRoundRegister(_Subject, _Id);
    }

    function Check(address _Subject, uint256 _Id)
        external
        view
        returns (uint256)
    {
        uint256 convertAmount = IWhiteList(WhiteListAddress).Check(
            _Subject,
            _Id
        );
        return Convert(convertAmount, _Id, Identifiers[_Id].Operation);
    }

    function Convert(
        uint256 _AmountToConvert,
        uint256 _Id,
        bool _Operation
    ) internal view zeroAmount(Identifiers[_Id].Price) returns (uint256) {
        uint256 amount = _AmountToConvert;
        bool operation = _Operation;
        uint256 price = Identifiers[_Id].Price;
        return operation ? amount.mul(price) : amount.div(price);
    }
}
