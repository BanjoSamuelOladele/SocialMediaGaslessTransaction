


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./Comment.sol";
import "./Like.sol";


contract Post{
    uint private id;

    struct NewPost{
        uint _id;
        string title;
        address postCreator;
        string description;
        uint url;
        uint createdTime;
    }

    Comment private comment;
    Like private like;

    constructor(){
        comment = new Comment();
        like = new Like();
    }
    mapping (address => NewPost[]) private userPosts;
    NewPost[] private allPosts;

    function createPost(string calldata title, string calldata desc, address user, uint url) external {
        NewPost memory post = NewPost(id++, title, user, desc, url, block.timestamp);
        userPosts[user].push(post);
        allPosts.push(post);
    }

    function getUserPost(address user) external view returns(NewPost[] memory){
        return userPosts[user];
    }

    function getPostByIndex(uint index) external view returns(NewPost memory) {
        return allPosts[index];
    }

    function getAllPosts() external view returns(NewPost[] memory) {
        return allPosts;
    }

    function likePost(uint postId, address user) external returns (bool){
        return like.toggleLikePost(postId, user);
    }

    function getPostLikesCounts(uint postId) external view returns (uint){
        return like.getPostLikesCounts(postId);
    }

    function commentOnPost(address commenter, uint postId, string calldata _comment) external {
        comment.createComment(commenter, postId, _comment);
    }

    function likeCommentOnPost(uint postId, uint commentId, address user) external returns (bool) {
        return comment.togglePostCommentLike(postId, commentId, user);
    }

    function getNumberOfPostCommentLikes(uint postId, uint commentId) external view returns (uint) {
        return like.getPostCommentLikesCount(postId, commentId);
    }
}