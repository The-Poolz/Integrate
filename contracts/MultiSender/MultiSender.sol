// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "poolz-helper-v2/contracts/Array.sol";
import "./MultiManageable.sol";

/// @title main multi transfer settings
/// @author The-Poolz contract team
contract MultiSender is MultiManageable {
    constructor() {
        UserLimit = 500;
    }

    modifier checkArrLength(uint256 _userLength, uint256 _balancesLength) {
        require(_userLength == _balancesLength, "invalid input data!");
        _;
    }

    modifier checkUserLimit(uint256 _userLength) {
        require(UserLimit >= _userLength, "Invalid user limit");
        _;
    }

    function MultiSendEth(
        address payable[] calldata _users,
        uint256[] calldata _balances
    )
        public
        payable
        whenNotPaused
        checkArrLength(_users.length, _balances.length)
        checkUserLimit(_users.length)
    {
        uint256 fee = _calcFee();
        uint256 value = msg.value;
        PayFee(fee);
        if (fee > 0 && FeeToken == address(0)) value -= fee;
        require(
            value >= Array.getArraySum(_balances),
            "Insufficient eth value sent!"
        );
        for (uint256 i; i < _users.length; i++) {
            _users[i].transfer(_balances[i]);
        }
    }

    function MultiSendERC20(
        address _token,
        address payable[] memory _users,
        uint256[] calldata _balances
    )
        public
        payable
        whenNotPaused
        checkArrLength(_users.length, _balances.length)
        checkUserLimit(_users.length)
    {
        require(_token != address(0), "Invalid token address");
        PayFee(_calcFee());
        for (uint256 i; i < _users.length; i++) {
            IERC20(_token).transferFrom(msg.sender, _users[i], _balances[i]);
        }
    }

    function _calcFee() internal returns (uint256) {
        if (WhiteListAddress == address(0)) return 0;
        uint256 discount = IWhiteList(WhiteListAddress).Check(
            msg.sender,
            WhiteListId
        );
        if (discount < Fee) {
            IWhiteList(WhiteListAddress).Register(
                msg.sender,
                WhiteListId,
                discount
            );
            return Fee - discount;
        }
        IWhiteList(WhiteListAddress).Register(msg.sender, WhiteListId, Fee);
        return 0;
    }
}
