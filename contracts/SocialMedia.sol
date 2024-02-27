// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "./NFTFactory.sol";
import "./Group.sol";


contract SocialMedia{

    NFTFactory private nftFactory;
    Group private newGroup;

    constructor(){
        nftFactory = new NFTFactory();
        newGroup = new Group();
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

    mapping(address => bool) private isLoggedIn;

    event RegisterUser(address);

    function registerUser(string memory name, string memory symbol) external {
        confirmUserAddress();
        User storage user = users[msg.sender];
        user.addr = msg.sender;
        user.details = Details(name, symbol);
        user.role = Role.USER;

        address nftCreated = nftFactory.createNFT(name, symbol);
        userNft[msg.sender] = nftCreated;


        emit RegisterUser(msg.sender);
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
            newGroup.createGroup(name);
        }
        else revert();
    }

}