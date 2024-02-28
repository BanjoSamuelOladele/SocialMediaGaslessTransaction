// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./NFTFactory.sol";
import "./Group.sol";
import "./Post.sol";


contract SocialMedia{

    NFTFactory private nftFactory;
    Group private newGroup;
    Post private  post;


    constructor(){
        nftFactory = new NFTFactory();
        newGroup = new Group();
        post = new Post();
    }

    struct User{
        address addr;
        Role role;
        Details details;
        Group groups;
    }

    enum Role{
        ADMIN, USER
    }

    struct Details{
        string name;
        string username;
    }

    mapping(address => User) private users;
    mapping(address => address) private userNft; 
    mapping(address => bool) private isRegistered;

    mapping(address => bool) private isLoggedIn;

    event RegisterUser(address);

    function registerUser(string memory name, string memory username) external {
        confirmUserAddress();
        bool isAUser = isRegistered[msg.sender];
        if (!isAUser) {
            User storage user = users[msg.sender];
            user.addr = msg.sender;
            user.details = Details(name, username);
            user.role = Role.USER;

            address nftCreated = nftFactory.createNFT(name, username);
            userNft[msg.sender] = nftCreated; 
            isRegistered[msg.sender] = true;
            emit RegisterUser(msg.sender);  
        }
        else revert();
    }

    function loginUser() external returns (bool) {
        confirmUserAddress();
        onlyUser();

        isLoggedIn[msg.sender] = true;

        return true;
    }

    function onlyUser() private view {
        if (users[msg.sender].role != Role.USER) revert();
    }

    function confirmUserAddress() private view {
        if (msg.sender == address(0)) revert();
    }

    function createGroup(string memory name) external {
        confirmUserAddress();
        onlyUser();
        bool checkLogIn = isLoggedIn[msg.sender];
        if (checkLogIn){
            newGroup.createGroup(name, msg.sender);
        }
        else revert();
    }

    function createPost(string calldata title, string calldata desc, string memory _contentURI) external {
        bool checkLogIn = isLoggedIn[msg.sender];
        if (checkLogIn){
            uint id = nftFactory.mintNFT(msg.sender, _contentURI, userNft[msg.sender]);
            post.createPost(title, desc, msg.sender, id);
        }
        else revert();
    }

    function getUser() external view returns (User memory){
        return users[msg.sender];
    }

    function getAllPosts() external view returns(Post.NewPost[] memory) {
        return post.getAllPosts();
    }
}