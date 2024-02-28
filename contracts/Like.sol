


// SPDX-License-Identifier: MIT
pragma solidity ^*;


contract Like{

    mapping (uint => mapping (uint => mapping (address => bool))) private commentLikes;
    mapping (uint => mapping (uint => uint)) private commentLikesCounts;

    mapping (uint=> mapping (address => bool)) private postLikes;
    mapping (uint => uint) private postLikesCounts;

    function toggleLikeCommentPost(uint postId, uint commentId, address user) external returns (bool) {
        commentLikes[postId][commentId][user] = !commentLikes[postId][commentId][user];
        if (commentLikes[postId][commentId][user]) commentLikesCounts[postId][commentId] += 1;
        else commentLikesCounts[postId][commentId] -= 1;

        return commentLikes[postId][commentId][user];
    }

    function toggleLikePost(uint postId, address user) external returns (bool) {
        postLikes[postId][user] = !postLikes[postId][user];
        if (postLikes[postId][user]) postLikesCounts[postId] = postLikesCounts[postId] + 1;
        else postLikesCounts[postId] = postLikesCounts[postId] - 1;

        return postLikes[postId][user];
    }

    function getPostLikesCounts(uint postId) external view returns (uint){
        return postLikesCounts[postId];
    }

    function getPostCommentLikesCount(uint postId, uint commentId) external view returns (uint) {
        return commentLikesCounts[postId][commentId];
    }
}