# SAMPLE FOR A TOKEN ERC1155 with EIP2981 STANDART 

for this example I used,

## FOR ERC1155
I used a Opensea contract for methods of ERC1155 https://github.com/ProjectOpenSea/opensea-creatures/tree/df8baafd8e8cb60f847b3ede640105f0bad6d057

## FOR EIP2981
I used a contract from manifold.xyz -> RoyaltyRegistrySolidity  https://github.com/manifoldxyz/royalty-registry-solidity/tree/f7ab884983506301a353684ccd112ef97bf8b6f5
I am also based on official documentation https://eips.ethereum.org/EIPS/eip-2981


# REQUIRE
npm
truffle

# INSTALLATION
NPM INSTALL

# EXEMPLE

1. truffle develop // Launch truffle console in dev

2. migrate // COMPILE + DEPLOY ON YOUR DEV BLOCKCHAIN

3. myNFT = await MyNFT.deployed() // SET YOUR DEPLOYED CONTRACT AT VAR

4. myNFT.create(accounts[0],12,10,"",[]) // CREATE (MINT) a NFT ID 12 with 10 supply

5. myNFT.mint(accounts[0],28,1,[]) // ADD 1 supply for ID 12

6. myNFT.royaltyInfo(12, 100) //IF id 12 BUY FOR 100ETH

7. myNFT.setTokenRoyalty(12, accoutns[0], 2000) //IF id 12 have 20% of royalty

8. myNFT.royaltyInfo(12, 100) //IF id 12 BUY FOR 100ETH

9. myNFT.supportsInterface("0xd9b67a26") // RETURN TRUE IF SUPPORT ERC1155

10. myNFT.supportsInterface("0x2a55205a") // RETURN TRUE IF SUPPORT EIP2981
