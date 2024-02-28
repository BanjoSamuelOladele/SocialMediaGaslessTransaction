


// SPDX-License-Identifier: MIT
pragma solidity ^*;


contract Like{

    mapping ( address => mapping (uint => mapping (uint => mapping (address => bool)))) private commentLikes;
    mapping ( address => mapping (uint => mapping (uint => uint))) private commentLikesCounts;
    mapping (address => mapping (uint => mapping (address => bool))) private postLikes;
    mapping (address => mapping (uint => uint)) private postLikesCounts;

    function likeCommentPost(address postOwner, uint id, uint _id, address user) external {
        commentLikes[postOwner][id][_id][user] = !commentLikes[postOwner][id][_id][user];
        if (commentLikes[postOwner][id][_id][user]) commentLikesCounts[postOwner][id][_id] += 1;
        else commentLikesCounts[postOwner][id][_id] -= 1;
    }
    function likePost(address postOwner, uint id, address user) external {
        postLikes[postOwner][id][user] = !postLikes[postOwner][id][user];
        if (postLikes[postOwner][id][user]) postLikesCounts[postOwner][id] += 1;
        else postLikesCounts[postOwner][id] -= 1;
    }
}