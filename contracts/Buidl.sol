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

    uint256 contractInstructorID = 1;
    uint256 contractStudentID = 1;
    uint256 contractCourseID = 1;

    // minimum to stake for a duration of 1year
    uint256 instructorRegistrationFee = 10000;

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
    }

    // structs
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
        address instructor;
        address[] students; // students offering the course
        uint256 price; // price in bdl token
        string level; // begginer, intermediate...
        string ipfsHash; // course metadata
        bool isPublished;
        uint sections; // number of course sections
        uint category;
        uint createdAt;
        uint updatedAt;
    }

    struct Student {
        uint id;
        string name;
        string emailAddress;
        string gender;
        string ipfsPhoto;
        string country;
        uint createdAt;
        uint[] courses;
    }

    struct StudentCourse {
        uint id;
        uint courseId;
        bool isActive; // paid or rejected
        uint unlocked; // initially equals to price of course
        // then sequentially unlocked to the instructor
        uint sectionsViewed;
        uint purchasedAt;
    }

    // ========= Administation ========= //

    function setInstructorRegistrationFee(uint256 amount) public {
        instructorRegistrationFee = amount;
    }

    // ========= Instructors =========== //

    function createCourse(
        string memory ipfsHash,
        string memory level,
        uint courseCategory
    ) public onlyInstructor {
        Course memory course = courses[contractCourseID];

        // create new freah course
        courses[contractCourseID] = Course(
            contractCourseID,
            msg.sender,
            course.students,
            0,
            level,
            ipfsHash,
            false,
            0,
            courseCategory,
            block.timestamp,
            block.timestamp
        );

        // assign course ownership to intructor
        instructors[msg.sender].courses.push(contractCourseID);

        // increment id
        contractCourseID++;
    }

    function createInstructorAccount(
        string memory firstName,
        string memory lastName,
        string memory location,
        uint gender
    ) public notAnyone {
        // stake instruction fee
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
        string memory gender
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

    function purchaseCourse(uint courseId) public onlyStudent {
        Course storage course = courses[courseId];

        // lock the student funds to smart contract
        bdlToken.transferFrom(msg.sender, address(this), course.price);

        // create course for student
        studentCourses[msg.sender].push(
            StudentCourse(
                courseId,
                courseId,
                true,
                course.price,
                0,
                block.timestamp
            )
        );

        emit CoursePurchased(course.instructor, msg.sender, courseId);
    }

    function rejectCourse(uint courseId) public onlyStudent {
        StudentCourse memory studentCourse = studentCourses[msg.sender][courseId];

        Course memory course = courses[courseId];

        // check is course is not over 2 weeks
        require(
            studentCourse.purchasedAt > 2,
            "You can't reject a course over 2 weeks."
        );

        uint refundableSections = (studentCourse.sectionsViewed -
            course.sections);
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

    function onNextCourseSection(uint courseId)
        public
        onlyStudent
        returns (string memory)
    {
        Course storage course = courses[courseId];
        StudentCourse storage studentCourse = studentCourses[msg.sender][courseId];

        // students moved to another section of the course
        // unlock part payment to the instructor (conditionally)
        uint pricePerSection = (course.price / course.sections);
        if (studentCourse.unlocked >= pricePerSection) {
            studentCourse.unlocked -= pricePerSection;
            bdlToken.transferFrom(
                address(this),
                course.instructor,
                pricePerSection
            );
        }

        // checks if students has completed the course
        uint progress = (studentCourse.sectionsViewed / course.sections);

        if (progress >= 1) {
            onCompletedCourse(msg.sender, courseId);
            return "course_completed";
        } else {
            studentCourse.sectionsViewed++;
            return "course_next_section";
        }
    }

    function onCompletedCourse(address student, uint courseId) private {
        generateCerticate(courseId, student);
        mintNftForStudent(courseId, student);
    }

    function generateCerticate(uint courseId, address student) private {
        Course memory course = courses[courseId];
        string memory uri = course.level;
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
}
