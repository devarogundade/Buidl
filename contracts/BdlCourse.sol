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

    /* 2 weeks */
    uint private refundableDuration = 10000;

    uint private categoryCount = 0;
    uint private sectionsCount = 0;

    uint private salesFee = 8; // eight percent

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

        emit Subscription(id, learner, true);
        return (course.price, course.creator);
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
        string memory previewSrc,
        bool publish
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
            publish,
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
        string memory previewSrc,
        bool publish
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
            publish,
            block.timestamp
        );
    }

    /* creates a course section */
    function createCourseSection(
        uint id,
        string memory title,
        string memory content,
        string memory src,
        uint duration
    ) public {
        require(courses[id].creator == msg.sender, "!unathorized");
        courses[id].sections++;
        sectionsCount++;
        emit CourseSection(id, title, content, src, duration, sectionsCount);
    }

    /* updates a course section */
    function updateCourseSection(
        uint id,
        string memory title,
        string memory content,
        string memory src,
        uint duration,
        uint sectionId
    ) public {
        require(courses[id].creator == msg.sender, "!unathorized");
        emit CourseSection(id, title, content, src, duration, sectionId);
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

    /* view section */
    function viewSection(uint id, uint sectionId) public {
        int index = getSubscriptionIndex(id, msg.sender);
        subscriptions[id][uint(index)].viewed.push(sectionId);
        emit SectionViewed(id, sectionId);
    }

    function unSubscribe(uint id, address owner)
        external
        returns (
            uint256,
            uint256,
            address,
            uint256,
            uint256
        )
    {
        int index = getSubscriptionIndex(id, owner);

        Models.Subscription memory subscription = subscriptions[id][
            uint(index)
        ];
        Models.Course memory course = courses[id];

        require(subscription.time < (block.timestamp + 2 weeks), ">2weeks");

        uint payableSections = (subscription.sections -
            subscription.viewed.length);

        require(payableSections > 0, "!you_cant_refund_this_course");

        /* user has unsubscribe */
        delete subscriptions[id][uint(index)];

        uint256 payableAmount = ((payableSections / subscription.sections) *
            subscription.price);

        uint256 netEarnings = (payableAmount - subscription.price);

        uint256 earnings;
        uint256 platformEarnings;
        if (netEarnings > 0) {
            earnings = (netEarnings * (salesFee / 100));
            platformEarnings = netEarnings - earnings;
        }

        emit Subscription(id, owner, false);

        return (
            payableAmount,
            earnings,
            course.creator,
            subscription.price,
            platformEarnings
        );
    }

    function getSubscriptionIndex(uint courseId, address owner)
        private
        view
        returns (int)
    {
        Models.Subscription[] memory _subscriptions = subscriptions[courseId];
        int _index = -1;

        for (int index = 0; uint(index) < _subscriptions.length; index++) {
            if (_subscriptions[uint(index)].owner == owner) {
                _index = index;
                break;
            }
        }

        require(_index >= 0, "!you_are_not_subscribed_to_this_course");
        return _index;
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
        bool publish,
        uint updatedAt
    );
    event CourseSection(
        uint id,
        string title,
        string content,
        string src,
        uint duration,
        uint sectionId
    );
    event SectionViewed(uint id, uint sectionId);

    // == modifiers == //
    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
