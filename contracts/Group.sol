


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./Post.sol";



contract Group{

    struct NewGroup{
        string name;
        address owner;
        address[] members;
        Post[] posts;
    }

    Post private post;

    constructor(){
        post = new Post();
    }

    mapping (address => NewGroup[]) private groups;
    // mapping ()


    function createGroup(string memory name, address owner) external {
        require(owner != address(0), "Address zero");
        NewGroup memory group;
        group.name = name;
        group.owner = owner;
        groups[msg.sender].push(group);
    }

    function onlyGroupOwner(uint index) private view  {
        if (groups[msg.sender][index].owner != msg.sender) revert();
    }

    function addGroupMember(address member, uint index) external {
        onlyGroupOwner(index);
        NewGroup storage group = groups[msg.sender][index];
        group.members.push(member);
    }
}