// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Models} from "./base/Models.sol";

contract BdlCourse {
    /* all ecosystem courses */
    mapping(uint => Models.Course) public courses;

    /* creator => course id */
    mapping(address => uint[]) public createdCourses;

    /* holds all course subscriptions */
    mapping(uint => Models.Subscription[]) public subscriptions;

    /* learner => course id */
    mapping(address => uint[]) public subscribeds;

    /* 2 weeks */
    uint private refundableDuration = 10000;

    uint private categoryCount = 0;

    address private deployer;

    constructor() {
        deployer = msg.sender;
    }

    // == learner related functions == //

    /* function to subscribe to a course */
    function subscribe(uint id, address learner)
        external
        returns (uint256, address)
    {
        Models.Course memory course = courses[id];

        require(course.id != 0, "!exists");
        require(course.creator != learner, "!can_subscribe_to_own_course");

        uint[] memory viewed;

        subscriptions[id].push(
            Models.Subscription(
                id,
                block.timestamp,
                course.price,
                learner,
                viewed,
                course.sections
            )
        );

        subscribeds[learner].push(id);

        emit Subscription(id, learner, true);
        return (course.price, course.creator);
    }

    /* function to unsubscribe from a course */
    function unSubscribe(
        uint id,
        uint sId,
        address learner
    ) external returns (uint256, address, uint) {
        Models.Subscription memory subscription = subscriptions[id][sId];
        Models.Course memory course = courses[id];

        require(course.id != 0, "!exists");
        require(subscription.owner == learner, "!authorized");

        uint dueTime = (block.timestamp + refundableDuration);
        require(subscription.time < dueTime, ">2weeks");

        uint weight = (subscription.viewed.length / subscription.sections);

        delete subscriptions[id][sId];
        delete subscribeds[learner][id];

        emit Subscription(id, learner, false);
        return (subscription.price, course.creator, weight);
    }

    // == creator related functions == //

    // testing purpose
    function mintCategories() public onlyOwner {
        createCategory("Web Developent", "web-development.webp");
        createCategory("Gaming", "gaming.webp");
        createCategory("Cooking", "cooking.webp");
        createCategory("Animation", "animation.webp");
        createCategory("Marketing", "marketing.webp");
        createCategory("Data Science", "data-science.webp");
        createCategory("Photography", "photography.webp");
        createCategory("Music", "music.webp");
        createCategory("Speaking", "speaking.webp");
        createCategory("UI/UX Designing", "ui-ux.webp");
    }

    function createCategory(string memory name, string memory image)
        public
        onlyOwner
    {
        categoryCount++;
        emit Category(categoryCount, name, image);
    }

    /* create a new course */
    function createCourse(
        uint id,
        uint category,
        uint256 price,
        /* course metadata */
        string memory name,
        string memory description,
        string memory thumbnail,
        string memory previewSrc
    ) external {
        require(courses[id].id == 0, "exists");

        courses[id] = Models.Course(
            id,
            category,
            msg.sender,
            price,
            block.timestamp,
            block.timestamp,
            courses[id].sections
        );

        createdCourses[msg.sender].push(id);

        emit Course(
            id,
            name,
            description,
            category,
            thumbnail,
            previewSrc,
            msg.sender,
            price,
            block.timestamp
        );
    }

    /* updates existing course */
    function updateCourse(
        uint id,
        uint category,
        uint256 price,
        /* course metadata */
        string memory name,
        string memory description,
        string memory thumbnail,
        string memory previewSrc
    ) external {
        require(courses[id].creator == msg.sender, "!unathorized");

        courses[id] = Models.Course(
            id,
            category,
            msg.sender,
            price,
            courses[id].createdAt,
            block.timestamp,
            courses[id].sections
        );

        emit Course(
            id,
            name,
            description,
            category,
            thumbnail,
            previewSrc,
            msg.sender,
            price,
            block.timestamp
        );
    }

    /* creates a course section */
    function createCourseSection(
        uint id,
        string memory title,
        string memory content,
        string memory src
    ) public {
        require(courses[id].creator == msg.sender, "!unathorized");
        courses[id].sections++;
        emit CourseSection(id, title, content, src);
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
    event Subscription(uint courseId, address learner, bool status);
    event CourseTransfer(uint id, address creator, address receiver);
    event Category(uint id, string name, string image);
    event Course(
        uint id,
        string name,
        string description,
        uint category,
        string thumbnail,
        string previewSrc,
        address creator,
        uint256 price,
        uint updatedAt
    );
    event CourseSection(uint id, string title, string content, string src);

    // == modifiers == //
    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
