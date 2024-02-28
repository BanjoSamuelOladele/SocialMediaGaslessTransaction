


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./Like.sol";


contract Comment{

    struct NewComment{
        uint id;
        address user;
        string comment;
        uint commentedTime;
    }

    Like private like;

    constructor(){
        like = new Like();
    }

    mapping (address => mapping (uint => uint)) private postCounts;
    mapping (address => mapping (uint => NewComment[])) private comments;


    function createComment(address postOwner, address commenter, uint id, string calldata _comment) external {
        NewComment storage comment = comments[postOwner][id][postCounts[postOwner][id]];
        comment.comment = _comment;
        comment.commentedTime = block.timestamp;
        comment.user = commenter;
        comment.id = postCounts[postOwner][id];

        postCounts[postOwner][id] = postCounts[postOwner][id] + 1;
    }
}