# Practice: Markdown File 1
- Create a markdown file about what problems ERC777 and ERC1363 solves. Why was ERC1363 introduced, and what issues are there with ERC777?

# ERC20 Issues
- ERC20's have been around since 2015 and became the defacto standard in the crypto space.
- Not every aspect of ERC20 was well thought out in the origional proposal.
- There are also many extensions which complicate the situation even more.
- ERC20 was designed in simple way which has lead to several issues and flaws that affect the implementation when building smart contracts.

## Resources detailing ERC20 Security issues:
-Read items 101-110
-https://secureum.substack.com/p/security-pitfalls-and-best-practices-201
-https://medium.com/@deliriusz/ten-issues-with-erc20s-that-can-ruin-you-smart-contract-6c06c44948e0

## Issues that ERC777 was created to address
4

# ERC777
EIP URL: https://eips.ethereum.org/EIPS/eip-777

## Summary from EIP
- ERC-777 is an Ethereum Improvement Proposal (EIP) which defines standard interfaces and behaviors for token contracts.

## Abstract from EIP
- This standard defines a new way to interact with a token contract while remaining backward compatible with the ERC-20 token standard.
- It defines advanced features to interact with a tokens.
	- It provides *operators* to send tokens on behalf of another address (contract or regular accounts).
	- It also provides send/recieve hooks to offer token holders more control over their tokens.
- It takes advantage of ERC-1820 to find out whether and where to notify contracts and regular addresses when they recieve tokens as well as to allow compatibility with already-deployed contracts.

## 

