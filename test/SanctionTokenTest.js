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

    it('should transfer tokens correctly', async () => {
        const amount = 100;
        await myToken.connect(wallet).transfer(recipient.address, amount);
        const expectedSenderBalance = 900;
        const expectedRecipientBalance = 100;
        const senderBalance = await myToken.balanceOf(wallet.address);
        const recipientBalance = await myToken.balanceOf(recipient.address);
        expect(senderBalance).to.equal(expectedSenderBalance, 'Sender balance should be 900 tokens');
        expect(recipientBalance).to.equal(expectedRecipientBalance, 'Recipient balance should be 100 tokens');
      });

});