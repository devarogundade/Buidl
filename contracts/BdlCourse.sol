// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Models} from "./base/Models.sol";

contract BdlCourse {
    /* all ecosystem courses */
    mapping(uint => Models.Course) public courses;

    // creator => course id
    mapping(address => uint[]) public createdCourses;

    /* holds all course subscriptions */
    mapping(uint => Models.Subscription[]) public subscriptions;

    // learner => course id
    mapping(address => uint[]) public subscribeds;

    // == learner related functions == //

    /* function to subscribe to a course */
    function subscribe(uint id, address learner) external {
        Models.Course memory course = courses[id];

        require(course.id != 0, "!exists");
        require(course.creator != learner, "!can_subscribe_to_own_course");

        subscriptions[id].push(
            Models.Subscription(id, block.timestamp, course.price, learner)
        );

        subscribeds[learner].push(id);

        emit CourseSubscribe(id, course.creator, learner);
    }

    /* function to unsubscribe from a course */
    function unSubscribe(
        uint id,
        uint sId,
        address learner
    ) external {
        require(subscriptions[id][sId].owner == learner, "!authorized");
        delete subscriptions[id][sId];
        delete subscribeds[learner][id];

        emit CourseUnSubscribe(id, sId, learner);
    }

    // == creator related functions == //

    /* create a new course */
    function createCourse(
        uint id,
        uint category,
        uint256 price,
        address creator
    ) external {
        require(courses[id].id == 0, "exists");

        courses[id] = Models.Course(
            id,
            category,
            price,
            creator,
            block.timestamp
        );

        createdCourses[creator].push(id);
    }

    /* updates an existing course */
    function updateCourse(
        uint id,
        uint category,
        uint256 price,
        address creator
    ) external {
        Models.Course memory course = courses[id];

        require(course.id != 0, "!exists");
        require(course.creator == creator, "!authorized");

        courses[id] = Models.Course(
            id,
            category,
            price,
            creator,
            block.timestamp
        );
    }

    /* transfer course onwership */
    function tranfersCourse(
        uint id,
        address creator,
        address receiver
    ) external {
        require(courses[id].creator == creator, "!authorized");
        courses[id].creator = receiver;

        delete createdCourses[creator][id];
        createdCourses[receiver].push(id);

        emit CourseTransfer(id, creator, receiver);
    }

    // == events == //
    event CourseSubscribe(uint id, address creator, address learner);
    event CourseUnSubscribe(uint id, uint sId, address learner);
    event CourseTransfer(uint id, address creator, address receiver);
}
