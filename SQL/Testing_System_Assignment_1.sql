DROP DATABASE if exists TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

INSERT INTO `User` ('Username',    'Email',      'Password',       'FullName',      '')

CREATE TABLE Department (
	DepartmentID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName 		VARCHAR(50) NOT NULL
);  

CREATE TABLE `Position`(
	PositionID 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName 		VARCHAR(55) NOT NULL
);

CREATE TABLE `Account`(
	AccountID 			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email 				VARCHAR(255) UNIQUE,
    Username 			VARCHAR(50) UNIQUE NOT NULL CHECK (length(Username) > 6),
    Fullname 			VARCHAR(50) NOT NULL,
    DepartmentID 		TINYINT UNSIGNED,
    PositionID 			TINYINT UNSIGNED DEFAULT(1),
    CreateDate 			DATE,
						FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE `Group`(
	GroupID 			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupName 			VARCHAR(50),
	CreatorID 			TINYINT UNSIGNED,
	CreateDate 			DATE,
						FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE GroupAccount(
	GroupID 			TINYINT UNSIGNED,
    AccountID 			TINYINT UNSIGNED,
    JoinDate 			DATE,
						FOREIGN KEY (GroupID) 	REFERENCES `Group`(GroupID),
						FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion(
	TypeID 				TINYINT PRIMARY KEY AUTO_INCREMENT,
    TypeName 			VARCHAR(50) 
);

CREATE TABLE CategoryQuestion(
	CategoryID 			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName 		ENUM('Java','.NET','SQL','Postman','Ruby')
);
CREATE TABLE Question(
	QuestionID 			TINYINT PRIMARY KEY AUTO_INCREMENT,
    Content 			VARCHAR(255),
    CategoryID 			TINYINT UNSIGNED,
    TypeID 				TINYINT,
    CreatorID 			TINYINT UNSIGNED,
    CreatrDate 			DATE,
						FOREIGN KEY (CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
						FOREIGN KEY (TypeID) 		REFERENCES TypeQuestion(TypeID),
						FOREIGN KEY (CreatorID) 	REFERENCES `Account`(AccountID)
);

CREATE TABLE Exam(
	ExamID 				TINYINT PRIMARY KEY,
    `Code`				VARCHAR(50),
    Title 				VARCHAR(50),
    CategoryID 			TINYINT UNSIGNED,
    Duration 			TIME,
    CreatorID 			TINYINT UNSIGNED,
    CreateDate 			DATE,
						FOREIGN KEY (CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
						FOREIGN KEY (CreatorID) 	REFERENCES `Account`(AccountID)
);

CREATE TABLE ExamQuestion(
	ExamID 				TINYINT,
    QuestionID 			TINYINT,
						FOREIGN KEY (ExamID) 		REFERENCES Exam(ExamID),
						FOREIGN KEY (QuestionID) 	REFERENCES Question(QuestionID)
);
account


