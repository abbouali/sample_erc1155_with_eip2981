const MyNFT = artifacts.require("MyNFT")

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(MyNFT, "MyNFT 1155 EIP2981", "MNFT", "https://example.com/{id}", 1000); // 1000/10000 == 10%   
  myNFT = await MyNFT.deployed();
}