// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Models {
    struct User {
        uint id;
        bool verified;
        string photo;
        uint[] courses;
        uint createdAt;
    }

    struct Course {
        uint id;
        uint category;
        address creator;
        address[] leaners;
        uint256 price;
        uint createdAt;
        uint updatedAt;
    }

    struct Subscription {
        uint course; // id of course
        uint time; // time of subscription
        uint price; // price of subscription at the time of subscription
        address owner; // owner of subscription (learner)
    }

    struct Revenue {
        uint256 unclaimed; // total tokens that are locked
        uint256 claimable; // total tokens that are available
        uint256 claimed; // total tokens claimed
        int96 flowRate; // amount of token user receives per second
    }
}
