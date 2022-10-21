// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Models {
    struct Category {
        uint id;
        string name;
        string image;
    }

    struct Instructor {
        uint id;
        string firstName;
        string lastName;
        string location;
        uint gender;
        bool isVerified;
        string ipfsPhoto;
        string twitter;
        string linkedin;
        uint[] courses;
        uint createdAt;
    }

    struct Course {
        uint id;
        string name;
        string description;
        uint categoryId;
        string ipfsPhoto;
        address instructor;
        address[] students;
        uint[] ratings;
        uint256 price;
        string metadata; // course metadata
        bool isPublished;
        uint createdAt;
        uint updatedAt;
    }

    struct Student {
        uint id;
        string name;
        string emailAddress;
        uint gender;
        string ipfsPhoto;
        string country;
        uint createdAt;
        uint[] courses;
    }

    struct StudentCourse {
        uint courseId;
        uint purchasedAt;
    }

    struct CourseSection {
        uint id;
        string title;
        string src; // ipfs source
        string content;
    }
}
