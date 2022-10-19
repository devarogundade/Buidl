// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BdlToken.sol";
import "./BdlNft.sol";
import "./BdlCertificate.sol";
import "./Models.sol";

contract Buidl {
    // state variables
    address deployer;

    BdlToken bdlToken;
    BdlNft bdlNft;
    BdlCertificate bdlCertificate;

    uint256 public contractInstructorID = 1;
    uint256 public contractStudentID = 1;
    uint256 public contractCourseID = 1;
    uint256 public contractCategoryID = 1;

    // minimum to stake for a duration of 1year
    uint256 instructorRegistrationFee = 2000 * 10**18;

    mapping(uint => Models.Category) public categories;
    mapping(address => Models.Instructor) public instructors;
    mapping(address => Models.Student) public students;
    mapping(uint => Models.Course) public courses;
    mapping(address => Models.StudentCourse[]) public studentCourses;
    mapping(uint => Models.CourseSection[]) public courseSections;

    // contructor
    constructor(
        address _bdlToken,
        address _bdlNft,
        address _bdlCertificate
    ) {
        deployer = msg.sender;
        bdlToken = BdlToken(_bdlToken);
        bdlNft = BdlNft(_bdlNft);
        bdlCertificate = BdlCertificate(_bdlCertificate);

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
            course.metadata,
            false,
            block.timestamp,
            block.timestamp
        );

        // assign course ownership to intructor
        instructors[msg.sender].courses.push(contractCourseID);

        // increment id
        contractCourseID++;
    }

    function addSectionToCourse(
        uint courseId,
        string memory title,
        string memory src
    ) public onlyInstructor {
        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");
        require(course.instructor == msg.sender, "!authorized");

        courseSections[courseId].push(
            Models.CourseSection(courseSections[courseId].length + 1, title, src)
        );
    }

    function updateCourseSection(
        uint courseId,
        uint sectionIndex,
        string memory title,
        string memory src
    ) public onlyInstructor {
        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");
        require(course.instructor == msg.sender, "!authorized");
        require(
            courseSections[courseId][sectionIndex].id != 0,
            "!exists"
        );

        courseSections[courseId][sectionIndex] = Models.CourseSection(
            sectionIndex,
            title,
            src
        );
    }

    function deleteCourseSection(uint courseId, uint sectionIndex)
        public
        onlyInstructor
    {
        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");
        require(course.instructor == msg.sender, "!authorized");
        require(
            courseSections[courseId][sectionIndex].id != 0,
            "!exists"
        );

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
        bdlToken.increaseAllowance(
            msg.sender,
            address(this),
            instructorRegistrationFee
        );

        bdlToken.transferFrom(
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

    function purchaseCourse(uint courseId) public onlyStudent {
        Models.Course storage course = courses[courseId];

        require(course.id != 0, "!exists");

        // lock the student funds to smart contract
        bdlToken.increaseAllowance(msg.sender, address(this), course.price);
        bdlToken.transferFrom(msg.sender, address(this), course.price);

        // create course for student
        studentCourses[msg.sender].push(
            Models.StudentCourse(courseId, true, course.price, 0, block.timestamp)
        );

        emit CoursePurchased(course.instructor, msg.sender, courseId);
    }

    function rejectCourse(uint courseId, uint sections) public onlyStudent {
        Models.StudentCourse memory studentCourse = studentCourses[msg.sender][
            courseId
        ];

        Models.Course memory course = courses[courseId];

        require(course.id != 0, "!exists");

        // check is course is not over 2 weeks
        require(
            studentCourse.purchasedAt > 2,
            ">2weeks."
        );

        uint refundableSections = (studentCourse.sectionsViewed - sections);

        require(
            refundableSections > 0,
            "!refunable"
        );

        uint256 refundableAmount = (refundableSections * course.price);

        // terminate student course
        delete studentCourses[msg.sender][courseId];

        // refund the student
        bdlToken.transferFrom(address(this), msg.sender, refundableAmount);

        emit CourseRejected(msg.sender, courseId, studentCourse.sectionsViewed);
    }

    function onNextCourseSection(
        uint courseId,
        uint sections,
        string memory uri
    ) public onlyStudent returns (string memory) {
        Models.Course storage course = courses[courseId];

        require(course.id != 0, "!exists");

        Models.StudentCourse storage studentCourse = studentCourses[msg.sender][
            courseId
        ];

        // students moved to another section of the course
        // unlock part payment to the instructor (conditionally)
        uint pricePerSection = (course.price / sections);

        if (studentCourse.unlocked >= pricePerSection) {
            studentCourse.unlocked -= pricePerSection;
            bdlToken.transferFrom(
                address(this),
                course.instructor,
                pricePerSection
            );
        }

        // checks if students has completed the course
        uint progress = (studentCourse.sectionsViewed / sections);

        if (progress >= 1) {
            onCompletedCourse(msg.sender, courseId, uri);
            return "course_completed";
        } else {
            studentCourse.sectionsViewed++;
            return "course_next_section";
        }
    }

    function onCompletedCourse(
        address student,
        uint courseId,
        string memory uri
    ) private {
        require(courses[courseId].id != 0, "!exists");
        generateCerticate(courseId, student, uri);
        mintNftForStudent(student);
    }

    function generateCerticate(
        uint courseId,
        address student,
        string memory uri
    ) private {
        bdlCertificate.issue(student, uri);
        emit CertificateIssued(student, courseId);
    }

    function mintNftForStudent(address student) private {
        bdlNft.mint(student, "");
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

    // ========== events ========== //
    event CourseCompletion(address student, uint courseId);
    event CertificateIssued(address student, uint courseId);
    event CoursePurchased(address intructor, address student, uint courseId);
    event CourseRejected(address student, uint courseId, uint sectionsViewed);

    // ========== test =========== //
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
