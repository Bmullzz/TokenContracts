const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('BondingCurve', () => { 

    let token;
    let tokenSale;
    let owner;
    let buyer;

    beforeEach(async () => {
        const BCToken = await ethers.getContractFactory("BCToken");
        token = await BCToken.deploy("BCToken", "BCT", ethers.utils.parseEther("1000"));
        await token.deployed();

        const BondingCurve = await ethers.getContractFactory("BondingCurve");
        [owner, buyer] = await ethers.getSigners();
        tokenSale = await BondingCurve.deploy(token.address, ethers.utils.parseEther("1"), 100);
        await tokenSale.deployed();

        await token.connect(owner).approve(tokenSale.address, ethers.utils.parseEther("1000"));
    });

    it("should allow a buyer to purchase tokens", async () => {
        const initialBuyerBalance = await token.balanceOf(buyer.address);
        const initialTokenSaleBalance = await token.balanceOf(tokenSale.address);
        const purchaseAmount = ethers.utils.parseEther("0.5");
    
        await tokenSale.connect(buyer).buyTokens({ value: purchaseAmount });
    
        expect(await token.balanceOf(buyer.address)).to.equal(initialBuyerBalance.add(50));
        expect(await token.balanceOf(tokenSale.address)).to.equal(initialTokenSaleBalance.sub(50));
    });
});