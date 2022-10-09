// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Models.sol";
import "./BdlToken.sol";
// import "./utils/Array.sol";

contract User {

    // tracks the id to be assigned to a user
    uint256 public userIDtrack = 1;

    address deployer;
    mapping(address => Models.User) public users;
    mapping(address => Models.UserInfo) public usersinfo;
    BdlToken bdlToken;

    constructor(address _bdlToken) {
        deployer = msg.sender;
        bdlToken = BdlToken(_bdlToken);
    }

    struct UserModel {
        uint id;
        string name;
        string username;
        string bio;
        string phone;
        string gender;
        uint[] talents;
        address[] trustedWith;
        string projects;
        string socials;
        string experiences;
        string certificates;
        string awards;
        string blogs;
        uint createdAt;
        uint updatedAt;
    }

    // creates a new user if not existing
    function createUser(address _address, string memory name, string memory username, string memory gender) public {
        require(users[_address].id == 0, "You already have an account");
        
        Models.User memory user = users[_address];
        users[_address] = Models.User(
            userIDtrack,
            name,
            username,
            user.bio,
            user.phone,
            gender,
            block.timestamp,
            block.timestamp            
        );

        userIDtrack++;
    }

    // creates a user info if user exists
    function createUserInfo(address _address, string memory projects, string memory socials, string memory experiences, string memory certificates, string memory awards, string memory blogs) public {
        require(users[_address].id != 0, "You don't have an account");
        
        Models.UserInfo memory userInfo = usersinfo[_address];
        usersinfo[_address] = Models.UserInfo(
            userInfo.talents,
            userInfo.trustedWith,
            userInfo.trustedBy,
            projects,
            socials,
            experiences,
            certificates,
            awards,
            blogs
        );
    }

    // trust another user with tokens
    function trustUser(address _address, uint256 amount) public {
        require(users[msg.sender].id != 0, "You don't have an account");
        require(users[_address].id != 0, "User don't have an account");

        Models.UserInfo storage userInfo = usersinfo[_address];
        
        require(!trustExists(userInfo.trustedBy, msg.sender), "You already trusted this user");

        userInfo.trustedBy.push(msg.sender);
        userInfo.trustedWith += amount;

        bdlToken.charge(msg.sender, amount);
    }

    // checks if the user has aleady trusted user
    function trustExists(address[] memory _addresses, address _address) public pure returns (bool){
        for (uint i; i < _addresses.length; i++){
            if (_addresses[i] == _address)
            return true;
        }
        return false;
    }

    function addTalents(uint[] memory ids) public {
        for(uint i; i < ids.length; i++) {
            addTalent(ids[i]);
        }
    }

    function addTalent(uint id) public {
        require(users[msg.sender].id != 0, "You don't have an account");

        Models.UserInfo storage userInfo = usersinfo[msg.sender];

        require(!uintExists(userInfo.talents, id), "You already added this talent");
        userInfo.talents.push(id);
    }
            
    function uintExists(uint[] memory array, uint id) public pure returns (bool){
        for (uint i; i < array.length; i++){
            if (array[i] == id)
            return true;
        }
        return false;
    }
}
