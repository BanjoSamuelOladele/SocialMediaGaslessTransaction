


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./UserNFT.sol";
import "./IUserNFT.sol";

contract NFTFactory {

    function createNFT(string memory name, string memory symbol) external returns(address) {
        UserNFT nft = new UserNFT(name, symbol);
        return address(nft);
    }

    function mintNFT(address _to, string memory _contentURI, address contractAddr) external returns (uint){
        return IUserNFT(contractAddr).safeMint(_to, _contentURI);
    }

    function viewIdURI(uint256 id, address contractAddr) external view returns (string memory idUri){
        return IUserNFT(contractAddr).viewIdURI(id);
    }
}