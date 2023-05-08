// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

///@title Token sale and buyback with bonding curve.
///@author Brian Mullin

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC1363/IERC1363Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BondingCurve {

    ERC20 public token;
    uint256 public reserve;
    uint256 public rate;
    uint256 public scale;

    constructor(address _token, uint256 _reserve, uint256 _rate, uint256 _scale) {
        token = ERC20(_token);
        reserve = _reserve;
        rate = _rate;
        scale = _scale;
    }

    function buy(uint256 amount) public {
        uint256 cost = getCost(amount);
        require(token.balanceOf(msg.sender) >= cost, "Insufficient Funds");
        require(token.transferFrom(msg.sender, address(this), cost), "Transfer Failed");
        reserve += cost;
        emit Bought(msg.sender, amount, cost);
    }

    function sell() {
        
    }

    function getCost() {

    }

    function getGain() {

    }

    function onTransferRecieved() {

    }

    function setRate() {

    }

    function setScale() {

    }

    function withdraw() {

    }
}