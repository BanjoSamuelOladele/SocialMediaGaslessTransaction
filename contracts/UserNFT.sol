// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract UserNFT is ERC721URIStorage {
    address private owner;
    uint256 private tokenId;

    mapping(uint256 => string) private uris;

    constructor(string memory name_, string memory username_)
        ERC721(name_, username_)
    {
        owner = tx.origin;
    }

    function safeMint(address _to, string memory _contentURI) external returns (uint) {
        uint toks = tokenId;
        _safeMint(_to, toks);
        _setTokenURI(toks, _contentURI);
        uris[toks] = _contentURI;
        tokenId++;
        return toks;
    }

    function viewIdURI(uint256 id) external view returns (string memory idUri) {
        idUri = uris[id];
    }
}