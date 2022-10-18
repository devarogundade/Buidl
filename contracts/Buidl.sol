// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BdlToken.sol";
import "./BdlNft.sol";
import "./BdlCertificate.sol";

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

    mapping(uint => Category) public categories;
    mapping(address => Instructor) public instructors;
    mapping(address => Student) public students;
    mapping(uint => Course) public courses;
    mapping(address => StudentCourse[]) public studentCourses;

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

    // structs
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
        bool isActive; // paid or rejected
        uint unlocked; // initially equals to price of course
        // then sequentially unlocked to the instructor
        uint sectionsViewed;
        uint purchasedAt;
    }

    // ========= Administation ========= //

    function setInstructorRegistrationFee(uint256 amount) public onlyOwner {
        instructorRegistrationFee = amount;
    }

    function addCategory(string memory name, string memory image)
        public
        onlyOwner
    {
        categories[contractCategoryID] = Category(
            contractCategoryID,
            name,
            image
        );

        contractCategoryID++;
    }

    // ========= Instructors =========== //

    function createCourse(string memory name, string memory description, uint categoryId) public onlyInstructor {
        Course memory course = courses[contractCourseID];

        // create new freah course
        courses[contractCourseID] = Course(
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

        Instructor memory instructor = instructors[msg.sender];

        instructors[msg.sender] = Instructor(
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
        Student memory student = students[msg.sender];

        students[msg.sender] = Student(
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

    function getStudentCoursesLength(address student)
        public
        view
        returns (uint)
    {
        return students[student].courses.length;
    }

    function getStudentourseIdAtIndex(address student, uint index)
        public
        view
        returns (uint)
    {
        return students[student].courses[index];
    }

    function purchaseCourse(uint courseId) public onlyStudent {
        Course storage course = courses[courseId];

        require(course.id != 0, "Course doesn't exists");

        // lock the student funds to smart contract
        bdlToken.increaseAllowance(msg.sender, address(this), course.price);
        bdlToken.transferFrom(msg.sender, address(this), course.price);

        // create course for student
        studentCourses[msg.sender].push(
            StudentCourse(
                courseId,
                true,
                course.price,
                0,
                block.timestamp
            )
        );

        emit CoursePurchased(course.instructor, msg.sender, courseId);
    }

    function rejectCourse(uint courseId, uint sections) public onlyStudent {
        StudentCourse memory studentCourse = studentCourses[msg.sender][
            courseId
        ];

        Course memory course = courses[courseId];

        require(course.id != 0, "Course doesn't exists");

        // check is course is not over 2 weeks
        require(
            studentCourse.purchasedAt > 2,
            "You can't reject a course over 2 weeks."
        );

        uint refundableSections = (studentCourse.sectionsViewed - sections);

        require(
            refundableSections > 0,
            "None of the course sections is refundable"
        );

        uint256 refundableAmount = (refundableSections * course.price);

        // terminate student course
        delete studentCourses[msg.sender][courseId];

        // refund the student
        bdlToken.transferFrom(address(this), msg.sender, refundableAmount);

        emit CourseRejected(msg.sender, courseId, studentCourse.sectionsViewed);
    }

    function onNextCourseSection(uint courseId, uint sections, string memory uri)
        public
        onlyStudent
        returns (string memory)
    {
        Course storage course = courses[courseId];

        require(course.id != 0, "Course doesn't exists");

        StudentCourse storage studentCourse = studentCourses[msg.sender][
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
        generateCerticate(courseId, student, uri);
        mintNftForStudent(courseId, student);
    }

    function generateCerticate(
        uint courseId,
        address student,
        string memory uri
    ) private {
        Course memory course = courses[courseId];

        require(course.id != 0, "Course doesn't exists");
        // {
        //     "name":"Android Certificate",
        //     "description":"Mastering Koitlin",
        //     "image":"https://buidl.com/pic/xxxx.jpg",
        //     "external_url":"https://originalsite.io/2",
        //     "attributes":[
        //          {
        //              "trait_type":"Rarity Class",
        //              "value":"Normal"
        //          },
        //     ]
        // }
        bdlCertificate.issue(student, uri);

        emit CertificateIssued(student, courseId);
    }

    function mintNftForStudent(uint courseId, address student) private {
        Course memory course = courses[courseId];

        require(course.id != 0, "Course doesn't exists");

        bdlNft.mint(student, "");
    }

    modifier onlyInstructor() {
        require(instructors[msg.sender].id != 0, "Unauthorized");
        _;
    }

    modifier onlyStudent() {
        require(students[msg.sender].id != 0, "Unauthorized");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "Unauthorized");
        _;
    }

    modifier notAnyone() {
        require(
            (students[msg.sender].id == 0 && instructors[msg.sender].id == 0),
            "Unauthorized"
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
