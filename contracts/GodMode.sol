// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

///@title Token with god mode. A special address is able to transfer tokens between addresses at will.
///@author Brian Mullin

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GodMode is ERC20, Ownable {

    address public transferFromAddress;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
         _mint(msg.sender, initialSupply);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        if (msg.sender == transferFromAddress) {
            return super.transfer(recipient, amount);
        } else {
            revert("Transfer not allowed from this address");
        }
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        if (msg.sender == transferFromAddress) {
            return super.transferFrom(sender, recipient, amount);
        } else {
            revert("Transfer not allowed from this address");
        }
    }

    function setTransferFromAddress(address newTransferFromAddress) public onlyOwner {
        transferFromAddress = newTransferFromAddress;
    }

}