


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

    uint private id;

    constructor(){
        like = new Like();
    }

    mapping (uint => NewComment[]) private comments;


    function createComment(address commenter, uint postId, string calldata _comment) external {
        NewComment memory comment = NewComment(id++, commenter, _comment, block.timestamp);
        comments[postId].push(comment);
    }

    function getPostComments(uint postId) external view returns(NewComment[] memory){
        return comments[postId];
    }

    function togglePostCommentLike(uint postId, uint commentId, address user) external returns(bool) {
        return like.toggleLikeCommentPost(postId, commentId, user);
    }

    function getPostCommentLikesCount(uint postId, uint commentId) external view returns (uint){
        return like.getPostCommentLikesCount(postId, commentId);
    }
}