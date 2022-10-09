// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Models {

    struct User {
        uint id;
        string name;
        string username;
        string bio;
        string phone;
        string gender;
        uint createdAt;
        uint updatedAt;
    }

    struct UserInfo {
        uint[] talents;
        uint256 trustedWith;
        address[] trustedBy;
        string projects;
        string socials;
        string experiences;
        string certificates;
        string awards;
        string blogs;
    }

    struct Project {
        uint id;
        string name;
        string description;
        address[] members;
        uint[] contracts;
        uint[] tasks;
        bool isPublic;
        uint createdAt;
    }

    struct Task {
        uint id;
        string name;
        string description;
        uint256 reward;
        address[] assigned;
        uint progress;
        bool isConfirmed;
    }

    struct Talent {
        uint id;
        string name;
        string description;
    }

}