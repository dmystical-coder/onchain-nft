import {
  loadFixture
} from "@nomicfoundation/hardhat-toolbox/network-helpers";

import hre from "hardhat";


describe("OnchainNFT", () => {
  async function nftFixture() {
      const [owner, addr1] = await hre.ethers.getSigners();

      const tokenFactory = await hre.ethers.getContractFactory("OnchainNFT")
      const token = await tokenFactory.deploy();

      // const token = await hre.ethers.deployContract("OnChainNFT", [""]);
      // await token.waitForDeployment();

      return { owner, addr1, token }
  }

  describe("Deployment", () => {
      it("should deploy the contract", async () => {
          const { owner, token } = await loadFixture(nftFixture);
          const uri = await token.getTokenURI(1);
          console.log(uri)
      })
  })
})