// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "base64-sol/base64.sol";

contract OnchainNFT is ERC721URIStorage {
    event CreatedNFT(uint256 indexed tokenId, string tokenURI);
    uint256 private tokenId;

    constructor() ERC721("Onchain Zombie", "OBIE") {
        tokenId = 0;
    }

    function createNFT(string memory _svg) public {
        _safeMint(msg.sender, tokenId);
        string memory imageURI = SVGToImageURI(_svg);
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenId, tokenURI);
        emit CreatedNFT(tokenId, tokenURI);
        tokenId++;
    }

    function SVGToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64, ";
        string memory SVGBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        string memory imageURI = string(
            abi.encodePacked(baseURL, SVGBase64Encoded)
        );
        return imageURI;
    }

    function formatTokenURI(
        string memory imageURI
    ) public pure returns (string memory) {
        string memory baseURL = "data:application/json;base64";
        return
            string(
                abi.encodePacked(
                    baseURL,
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                "{",
                                '"name": "Onchain Zombie",',
                                '"description": "A green zombie head with goo.",',
                                '"attributes": "",',
                                '"image": "',
                                imageURI,
                                '"',
                                "}"
                            )
                        )
                    )
                )
            );
    }
}
