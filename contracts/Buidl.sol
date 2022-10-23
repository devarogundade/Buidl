// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./BdlNft.sol";
import "./BdlCertificate.sol";
import "./Models.sol";
import {PaymentFlow} from "./PaymentFlow.sol";
import {BdlToken} from "./BdlToken.sol";

contract Buidl {
    // state variables
    address deployer;

    PaymentFlow private _paymentFlow;
    BdlToken private _bdlToken;
    BdlNft private _bdlNft;
    BdlCertificate private _bdlCertificate;

    uint256 private contractInstructorID = 1;
    uint256 private contractStudentID = 1;
    uint256 private contractCourseID = 1;
    uint256 private contractCategoryID = 1;

    // minimum to stake for a duration of 1year
    uint256 private instructorRegistrationFee = 2000 * 10**18;

    mapping(uint => Models.Category) public categories;
    mapping(address => Models.Instructor) public instructors;
    mapping(address => Models.Student) public students;
    mapping(uint => Models.Course) public courses;
    mapping(address => Models.StudentCourse[]) public studentCourses;
    mapping(uint => Models.CourseSection[]) public courseSections;

    // contructor
    constructor(
        address bdlToken,
        address bdlNft,
        address bdlCertificate,
        address paymentFlow
    ) {
        deployer = msg.sender;

        _bdlToken = BdlToken(bdlToken);
        _bdlNft = BdlNft(bdlNft);
        _bdlCertificate = BdlCertificate(bdlCertificate);
        _paymentFlow = PaymentFlow(paymentFlow);

        addTestCategories();
    }

    // ========= Administation ========= //

    function setInstructorRegistrationFee(uint256 amount) public onlyOwner {
        instructorRegistrationFee = amount;
    }

    function addCategory(string memory name, string memory image)
        public
        onlyOwner
    {
        categories[contractCategoryID] = Models.Category(
            contractCategoryID,
            name,
            image
        );

        contractCategoryID++;
    }

    // ========= Instructors =========== //

    function createCourse(
        string memory name,
        string memory description,
        uint categoryId
    ) public onlyInstructor {
        Models.Course memory course = courses[contractCourseID];

        // create new freah course
        courses[contractCourseID] = Models.Course(
            contractCourseID,
            name,
            description,
            categoryId,
            course.ipfsPhoto,
            msg.sender,
            course.students,
            course.ratings,
            0,
            false,
            block.timestamp,
            block.timestamp
        );

        // assign course ownership to intructor
        instructors[msg.sender].courses.push(contractCourseID);

        // increment id
        contractCourseID++;
    }

    function updateCourse(
        string memory name,
        string memory description,
        string memory ipfsPhoto,
        uint categoryId,
        uint price,
        uint courseId,
        bool publish
    ) public onlyInstructor {
        courses[courseId] = Models.Course(
            courseId,
            name,
            description,
            categoryId,
            ipfsPhoto,
            msg.sender,
            courses[courseId].students,
            courses[courseId].ratings,
            price,
            publish,
            courses[courseId].createdAt,
            block.timestamp
        );
    }

    function addSectionToCourse(
        uint courseId,
        string memory title,
        string memory src,
        string memory content,
        uint updateFor
    ) public onlyInstructor {
        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");
        require(course.instructor == msg.sender, "!authorized");

        if (updateFor == 0) {
            courseSections[courseId].push(
                Models.CourseSection(
                    courseSections[courseId].length + 1,
                    title,
                    src,
                    content
                )
            );
        } else {
            courseSections[courseId][updateFor] = Models.CourseSection(
                updateFor,
                title,
                src,
                content
            );
        }
    }

    function deleteCourseSection(uint courseId, uint sectionIndex)
        public
        onlyInstructor
    {
        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");
        require(course.instructor == msg.sender, "!authorized");
        require(courseSections[courseId][sectionIndex].id != 0, "!exists");

        delete courseSections[courseId][sectionIndex];
    }

    function getInstructorCoursesLength(address instructor)
        public
        view
        returns (uint)
    {
        return instructors[instructor].courses.length;
    }

    function getInstructorCourseIdAtIndex(address instructor, uint index)
        public
        view
        returns (uint)
    {
        return instructors[instructor].courses[index];
    }

    function createInstructorAccount(
        string memory firstName,
        string memory lastName,
        string memory location,
        uint gender
    ) public notAnyone {
        // stake instruction fee
        _bdlToken.increaseAllowance(
            msg.sender,
            address(this),
            instructorRegistrationFee
        );

        _bdlToken.transferFrom(
            msg.sender,
            address(this),
            instructorRegistrationFee
        );

        Models.Instructor memory instructor = instructors[msg.sender];

        instructors[msg.sender] = Models.Instructor(
            contractInstructorID,
            firstName,
            lastName,
            location,
            gender,
            false,
            instructor.ipfsPhoto,
            instructor.twitter,
            instructor.linkedin,
            instructor.courses,
            block.timestamp
        );

        contractInstructorID++;
    }

    // function getUnclaimableRevenue() public returns(uint256) {
    //   uint256 unclaimed = 0;

    //   for (uint index = 0; index < studentCourses.length; index++) {
    //       if (studentsCourse[])
    //   }

    // }

    // ========= Students ========== //

    function createStudentAccount(
        string memory name,
        string memory email,
        uint gender
    ) public notAnyone {
        Models.Student memory student = students[msg.sender];

        students[msg.sender] = Models.Student(
            contractStudentID,
            name,
            email,
            gender,
            student.ipfsPhoto,
            student.country,
            block.timestamp,
            student.courses
        );

        contractStudentID++;
    }

    function purchaseCourse(uint courseId, uint nftId, uint discount) public onlyStudent {
        Models.Course storage course = courses[courseId];

        require(course.id != 0, "!exists");
        uint price = course.price;

        if (nftId != 0 && discount != 0) {
            require(_bdlNft.ownerOf(nftId) == msg.sender, "!owner");

            _bdlNft.burn(nftId);
            price -= discount;
        }

        // lock the student funds to smart contract
        _bdlToken.increaseAllowance(msg.sender, address(this), price);
        _bdlToken.transferFrom(msg.sender, address(this), price);

        // create course for student
        studentCourses[msg.sender].push(
            Models.StudentCourse(courseId, block.timestamp, price)
        );

        emit CoursePurchased(course.instructor, msg.sender, courseId);
    }

    function rejectCourse(
        uint courseId,
        uint sections,
        uint sectionsViewed
    ) public onlyStudent {
        // check is course is not over 2 weeks
        uint expireTime = studentCourses[msg.sender][courseId].purchasedAt +
            (20160 * 60000);
        uint priceBought = studentCourses[msg.sender][courseId].priceBought;

        require(block.timestamp < expireTime, ">2weeks");

        uint refundableSections = (sections - sectionsViewed);

        require(refundableSections > 0, "!refundable");

        uint256 refundableAmount = (refundableSections * priceBought);

        // terminate student course
        delete studentCourses[msg.sender][courseId];

        // refund the student
        _bdlToken.transferFrom(address(this), msg.sender, refundableAmount);

        emit CourseRefunded(msg.sender, courseId, sectionsViewed);
    }

    function onCompletedCourse(
        uint courseId,
        string memory certificateUri,
        string memory nftUri
    ) public onlyStudent {
        require(courses[courseId].id != 0, "!exists");
        // check if student has purchase the course
        // require(studentCourses[msg.sender][] != 0, "!exists");
        _bdlCertificate.issue(msg.sender, certificateUri);
        _bdlNft.mint(msg.sender, nftUri);
    }

    modifier onlyInstructor() {
        require(instructors[msg.sender].id != 0, "!authorized");
        _;
    }

    modifier onlyStudent() {
        require(students[msg.sender].id != 0, "!authorized");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }

    modifier notAnyone() {
        require(
            (students[msg.sender].id == 0 && instructors[msg.sender].id == 0),
            "!authorized"
        );
        _;
    }

    // ========== Events ========== //

    event CourseCompletion(address student, uint courseId);
    event CoursePurchased(address intructor, address student, uint courseId);
    event CourseRefunded(address student, uint courseId, uint sectionsViewed);

    // ========== Development ========== //

    function faucetMint() public {
        _bdlToken.mint(msg.sender, 5000);
    }

    function addTestCategories() private {
        addCategory(
            "Web Development",
            "/images/categories/web-development.webp"
        );
        addCategory("Cooking", "/images/categories/cooking.webp");
        addCategory("UI/UX Designing", "/images/categories/ui-ux.webp");
        addCategory("3D Animation", "/images/categories/animation.webp");
        addCategory("Illustration", "/images/categories/illustration.webp");
        addCategory("Data Science", "/images/categories/data-science.webp");
        addCategory("Speaking", "/images/categories/speaking.webp");
        addCategory("Music", "/images/categories/music.webp");
        addCategory("Photography", "/images/categories/photography.webp");
        addCategory("Marketing", "/images/categories/marketing.webp");
    }
}
