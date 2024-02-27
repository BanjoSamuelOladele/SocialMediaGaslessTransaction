


// SPDX-License-Identifier: MIT
pragma solidity ^*;

interface IUserNFT {
    function tokenURI(
        uint256 tokenId
    ) external  view returns (string memory);

    function supportsInterface(
        bytes4 interfaceId
    ) external  view  returns (bool);
}
