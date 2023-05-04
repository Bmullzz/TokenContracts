// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

///@title A fungible token that allows an admin to ban specified addresses from sending and receiving tokens.
///@author Brian Mullin

contract SanctionsToken is ERC20, Ownable {
    
    mapping(address => bool) private bannedAddresses;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }

    ///@dev the transfer() function checks to see if either the msg.sender address or the recipient address are 
    /// in the banned list before initiating the transaction.
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(!bannedAddresses[msg.sender], "Sender is banned from sending tokens");
        require(!bannedAddresses[recipient], "Recipient is banned from recieving tokens");
        return super.transfer(recipient, amount); 
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(!bannedAddresses[sender], "Sender is banned from sending tokens");
        require(!bannedAddresses[recipient], "Recipient is banned from recieving tokens");
        return super.transferFrom(sender, recipient, amount);
    }

    function banAddress(address account) public onlyOwner {
        bannedAddresses[account] = true;
    }

    function unbanAddress(address account) public onlyOwner {
        bannedAddresses[account] = false;
    }

    function isBanned(address account) public view returns (bool) {
        return bannedAddresses[account];
    }

}