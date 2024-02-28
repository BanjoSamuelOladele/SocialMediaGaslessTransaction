


// SPDX-License-Identifier: MIT
pragma solidity ^*;

interface IUserNFT {
    function safeMint(address _to, string memory _contentURI) external returns (uint);

    function viewIdURI(uint256 id) external view returns (string memory idUri);
}
