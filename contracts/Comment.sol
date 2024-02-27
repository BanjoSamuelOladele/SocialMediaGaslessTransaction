


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./Like.sol";


contract Comment{

    struct NewComment{
        address user;
        Like[] likes;
        string comment;
        uint commentedTime;
    }

    Like private like;

    constructor(){
        like = new Like();
    }

    mapping (uint => NewComment[]) private comments;

    function createComment(address commenter, uint id, string calldata _comment) external {
        NewComment memory comment;
        comment.comment = _comment;
        comment.commentedTime = block.timestamp;
        comment.user = commenter;

        comments[id].push(comment);
    }


}