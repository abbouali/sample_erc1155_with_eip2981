// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

import "./IERC1155WithRoyalty.sol";
import "./IEIP2981.sol";

contract ERC1155WithRoyalty is ERC1155, IERC1155WithRoyalty, IEIP2981, Ownable {
  event TokenRoyaltySet(uint256 tokenId, address recipient, uint16 bps);
    event DefaultRoyaltySet(address recipient, uint16 bps);

    struct TokenRoyalty {
        address recipient;
        uint16 bps;
    }

    TokenRoyalty public defaultRoyalty;
    mapping(uint256 => TokenRoyalty) private _tokenRoyalties;

    constructor(
        string memory _uri,
        address _royaltyRecipient,
        uint16 _royaltyBPS
    ) ERC1155(_uri) {
        defaultRoyalty = TokenRoyalty(_royaltyRecipient, _royaltyBPS);
    }

    /**
    * @dev Define the fee for the token specify
    * @param tokenId uint256 token ID to specify
    * @param recipient address account that receives the royalties
    */
    function setTokenRoyalty(uint256 tokenId, address recipient, uint16 bps) public override onlyOwner {
        _tokenRoyalties[tokenId] = TokenRoyalty(recipient, bps);
        emit TokenRoyaltySet(tokenId, recipient, bps);
    }

    /**
    * @dev Define the default amount of fee and receive address
    * @param recipient address ID account receive royalty
    * @param bps uint256 amount of fee (1% == 100)
    */
    function setDefaultRoyalty(address recipient, uint16 bps) public override onlyOwner {
        defaultRoyalty = TokenRoyalty(recipient, bps);
        emit DefaultRoyaltySet(recipient, bps);
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155) returns (bool) {
        return interfaceId == type(IEIP2981).interfaceId || interfaceId == type(IERC1155WithRoyalty).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
    * @dev Returns royalty info (address to send fee, and fee to send)
    * @param tokenId uint256 ID of the token to display information
    * @param value uint256 sold price 
    */
    function royaltyInfo(uint256 tokenId, uint256 value) public override view returns (address, uint256) {
        if (_tokenRoyalties[tokenId].recipient != address(0)) {
            return (_tokenRoyalties[tokenId].recipient, value*_tokenRoyalties[tokenId].bps/10000);
        }
        if (defaultRoyalty.recipient != address(0) && defaultRoyalty.bps != 0) {
            return (defaultRoyalty.recipient, value*defaultRoyalty.bps/10000);
        }
        return (address(0), 0);
    }
}