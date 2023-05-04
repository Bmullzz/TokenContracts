const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("GodMode", function () {
    let token;
    let owner;
    let transferFromAddress;
  
    beforeEach(async () => {
        const GodMode = await ethers.getContractFactory("GodMode");
        [owner, transferFromAddress] = await ethers.getSigners();
        token = await GodMode.deploy("GodMode", "GOD", 1000000);
        await token.deployed();
    });
  
    it("should allow transfer from transferFromAddress", async () => {
        const initialBalance = await token.balanceOf(owner.address);
        const transferAmount = 100;
      
        // Check initial transferFromAddress
        assert.equal(await token.transferFromAddress(), "0x0000000000000000000000000000000000000000");
      
        // Set transferFromAddress
        await token.connect(owner).setTransferFromAddress(transferFromAddress.address);
        assert.equal(await token.transferFromAddress(), transferFromAddress.address);
      
        // Try to transfer tokens without transferFromAddress
        try {
          await token.connect(owner).transfer(transferFromAddress.address, transferAmount);
          assert.fail("Should have thrown an error");
        } catch (error) {
          assert.equal(error.message, "VM Exception while processing transaction: reverted with reason string 'Transfer not allowed from this address'");
          assert.equal(await token.balanceOf(owner.address), initialBalance);
        }
      
        // Try to transfer tokens with transferFromAddress
        const senderBalance = await token.balanceOf(transferFromAddress.address);
        if (senderBalance >= transferAmount) {
          await token.connect(transferFromAddress).transfer(owner.address, transferAmount);
          assert.equal(await token.balanceOf(owner.address), initialBalance.add(transferAmount));
        } else {
          assert.fail("Sender balance is less than transfer amount");
        }
      });
      
      
      
});