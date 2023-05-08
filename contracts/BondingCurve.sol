// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

///@title Token sale and buyback with bonding curve.
///@author Brian Mullin

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC1363/IERC1363Receiver.sol";
import "erc-payable-token/contracts/token/ERC1363/IERC1363Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BondingCurve is IERC1363Receiver, Ownable {

    ERC20 public token;
    uint256 public reserve;
    uint256 public rate;
    uint256 public scale;

    event Bought(address indexed buyer, uint256 amount, uint256 cost);
    event Sold(address indexed seller, uint256 amount, uint256 gain);

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

    function sell(uint256 amount) public {
        uint256 gain = getGain(amount);
        require(token.balanceOf(address(this)) >= gain, "Insufficient Funds");
        require(token.transferFrom(address(this), msg.sender, gain), "Transfer Failed");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer Failed");
        reserve -= gain;
        emit Sold(msg.sender, amount, gain);
    }

    function getCost(uint256 amount) public view returns (uint256) {
        return reserve + (rate * amount / scale);
    }

    function getGain(uint256 amount) public view returns (uint256) {
        return reserve - (rate * amount / scale);
    }

    function onTransferReceived(address operator, address from, uint256 amount, bytes calldata data) public override returns (bytes4) {
        buy(amount);
        return this.onTransferReceived.selector;
    }

    function setRate(uint256 _rate) public onlyOwner {
        rate = _rate;
    }

    function setScale(uint256 _scale) public onlyOwner {
        scale = _scale;
    }

    function withdraw() public onlyOwner {
        token.transfer(owner(), token.balanceOf(address(this)));
    }

}