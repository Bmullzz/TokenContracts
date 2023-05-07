# TokenContracts
RareSkills Week 1 contracts - ERC20, ERC777, ERC1363

# ERC-777
EIP URL: https://eips.ethereum.org/EIPS/eip-777

## Summary
- ERC-777 is an Ethereum Improvement Proposal (EIP) which defines standard interfaces and behviors for token contracts.

## Abstract
- This standard defines a new way to interact with a token contract while remaining backward compatible with the ERC-20 token standard.
- It defines advanced features to interact with a tokens.
	- It provides *operators* to send tokens on behalf of another address (contract or regular accounts).
	- It also provides send/recieve hooks to offer token holders more control over their tokens.
- It takes advantage of ERC-1820 to find out whether and where to notify contracts and regular addresses when they recieve tokens as well as to allow compatibility with already-deployed contracts.

## Motivation
- This standard tries to improve upon the widely used ERC-20 token standard.
- The main advantages of this standard are:
	1. Uses both the same philosophy as Ether in that tokens are sent with `send(dest, value, data)`.
	2. Both contracts and regular addresses can control and reject which token they send by registering a `tokensToSend` hook. (Rejection is done by `revert`ing in the hook function).
	3. Both contracts and regular addresses can control and reject which token they receive by registering a `tokensReceived` hook. (Rejection is done by `revert`ing in the hook function).
	4. The `tokensReceived` hook allows to send tokens to a contract and notify it in a single transaction, unlike ERC-20 which requires a double call ( `approve` / `transferFrom` ) to acheive this.
	5. The holder can "authorize" and "revoke" operators which can send tokens on their behalf.  These operators are intended to be verified contracts such as an exchange, a cheque processor, or an automatic charging system.
	6. Every token transaction contains `data` and `operatorData` bytes fields to be used freely to pass data from the holder and the operator, respectively.
	7. It is backwards compatible with wallets that do not contain the `tokensReceived` hook function by deploying a proxy contract implementing the `tokensReceived` hook for the wallet.

