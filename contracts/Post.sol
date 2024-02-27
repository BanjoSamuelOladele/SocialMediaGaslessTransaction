


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./Comment.sol";
import "./Like.sol";


contract Post{

    struct NewPost{
        string title;
        address postCreator;
        string description;
        string url;
        Comment[] comments;
        Like[] likes;
        uint createdTime;
    }

    Comment private comment;
    Like private like;

    constructor(){
        comment = new Comment();
        like = new Like();
    }

    mapping (address => NewPost[]) private userPosts;

    function createPost(string calldata title, string calldata desc, address user, string calldata url) external {
        NewPost memory post;
        post.title = title;
        post.description = desc;
        post.postCreator = user;
        post.url = url;
        post.createdTime = block.timestamp;

        userPosts[user].push(post);
    }


}