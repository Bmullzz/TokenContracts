const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('SanctionsToken contract', () => {

    let myToken;
    let wallet;
    let recipient;

    beforeEach(async () => {
        [wallet, recipient] = await ethers.getSigners();
        const MyToken = await ethers.getContractFactory('SanctionsToken');
        myToken = await MyToken.connect(wallet).deploy('Sanctions Token', 'SANK', 1000);
        await myToken.deployed();
    });

    it('should have initial balance of 1000 tokens', async () => {
        const expectedBalance = 1000;
        const balance = await myToken.balanceOf(wallet.address);
        expect(balance).to.equal(expectedBalance, 'Initial balance should be 1000 tokens');
    });

});