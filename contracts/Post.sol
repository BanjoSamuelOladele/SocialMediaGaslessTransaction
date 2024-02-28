


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

    mapping (address => uint) private userPostCount;
    mapping (address => NewPost[]) private userPosts;

    function createPost(string calldata title, string calldata desc, address user, uint url) external {
        NewPost storage post = userPosts[user][userPostCount[user]];
        post.title = title;
        post.description = desc;
        post.postCreator = user;
        post.url = url;
        post.createdTime = block.timestamp;
        post._id = userPostCount[user];

        userPostCount[user] = userPostCount[user] + 1;
    }
}