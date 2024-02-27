


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./UserNFT.sol";
import "./IUserNFT.sol";

contract NFTFactory {

    function createNFT(string memory name, string memory symbol) external returns(address) {
        UserNFT nft = new UserNFT(name, symbol);
        return address(nft);
    }

    function tokenURI(
        address contractAddr,
        uint256 tokenId
    ) external  view returns (string memory){
        return IUserNFT(contractAddr).tokenURI(tokenId);
    }

    function supportsInterface(
        address contractAddr, 
        bytes4 interfaceId
    ) external  view returns (bool) {
        return IUserNFT(contractAddr).supportsInterface(interfaceId);
    }
}