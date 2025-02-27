// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
using Strings for uint256;
import "@openzeppelin/contracts/utils/Base64.sol";

contract OnchainNFT is ERC721URIStorage {
    event CreatedNFT(uint256 indexed tokenId, string tokenURI);
    uint256 private tokenId;

    constructor() ERC721("Onchain NFT", "ONFT") {
        tokenId = 0;
    }

    function createNFT() public {
        _safeMint(msg.sender, tokenId);
        string memory tokenURI = getTokenURI(tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit CreatedNFT(tokenId, tokenURI);
        tokenId++;
    }

    function generateCharacter() public pure returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg width="150" height="100" xmlns="http://www.w3.org/2000/svg">'
            '<rect width="100%" height="100%" fill="green" />'
            '<circle cx="75" cy="50" r="40" fill="yellow" />'
            '<text x="75" y="60" font-size="24" text-anchor="middle" fill="red">ONFT</text>'
            '</svg>'
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getTokenURI(uint256 _tokenId) public pure returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Onchain NFT #',
            _tokenId.toString(),
            '",',
            '"description": "A pictorial representation of an Onchain SVG NFT image.",',
            '"image": "',
            generateCharacter(),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }
}
