DROP DATABASE if exists TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;


CREATE TABLE Department (
	DepartmentID 		TINYINT 		AUTO_INCREMENT,
    DepartmentName 		VARCHAR(50) 	NOT NULL,
    PRIMARY KEY (DepartmentID)
);  

CREATE TABLE `Position`(
	PositionID 			INT UNSIGNED 	AUTO_INCREMENT,
    PositionName 		VARCHAR(55) 	NOT NULL,
    PRIMARY KEY (PositionID)
);

CREATE TABLE `Account`(
	AccountID 			TINYINT 		NOT NULL,
    Email 				VARCHAR(255) 	NOT NULL		UNIQUE,
    Username 			VARCHAR(50) 	NOT NULL		UNIQUE		CHECK (length(Username) > 6),
    Fullname 			VARCHAR(50) 	NOT NULL,
    DepartmentID 		TINYINT,
    PositionID 			TINYINT 		DEFAULT(1),
    CreateDate 			DATE,
    FOREIGN KEY (DepartmentID) 			REFERENCES Department(DepartmentID),
    PRIMARY KEY (AccountID)
);

CREATE TABLE `Group`(
	GroupID 			TINYINT 		AUTO_INCREMENT,
	GroupName 			VARCHAR(50)		NOT NULL,
	CreatorID 			TINYINT 		NOT NULL,
	CreateDate 			DATE,
    FOREIGN KEY (CreatorID) 			REFERENCES `Account`(AccountID),
    PRIMARY KEY (GroupID)
);

CREATE TABLE GroupAccount(
	GroupID 			TINYINT 		NOT NULL,
    AccountID 			TINYINT 		NOT NULL,
    JoinDate 			DATE,
	FOREIGN KEY (GroupID) 				REFERENCES `Group`(GroupID),
	FOREIGN KEY (AccountID) 			REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion(
	TypeID 				TINYINT  		NOT NULL,
    TypeName 			VARCHAR(50),
    PRIMARY KEY (TypeID)
);

CREATE TABLE CategoryQuestion(
	CategoryID 			TINYINT 		NOT NULL 		AUTO_INCREMENT,
    CategoryName 		ENUM('Java','.NET','SQL','Postman','Ruby'),
    PRIMARY KEY (CategoryID) 
) ;
CREATE TABLE Question(
	QuestionID 			TINYINT 		NOT NULL 		AUTO_INCREMENT,
    Content 			VARCHAR(255),
    CategoryID 			TINYINT 		NOT NULL,
    TypeID 				TINYINT			NOT NULL,
    CreatorID 			TINYINT 		NOT NULL,
    CreatrDate 			DATE,
	FOREIGN KEY (CategoryID) 			REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (TypeID) 				REFERENCES TypeQuestion(TypeID),
	FOREIGN KEY (CreatorID) 			REFERENCES `Account`(AccountID),
    PRIMARY KEY (QuestionID)
);

CREATE TABLE Exam(
	ExamID 				TINYINT ,
    `Code`				VARCHAR(50),
    Title 				VARCHAR(50),
    CategoryID 			TINYINT 		NOT NULL,
    Duration 			TIME,
    CreatorID 			TINYINT 		NOT NULL,
    CreateDate 			DATE,
	FOREIGN KEY (CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (CreatorID) 	REFERENCES `Account`(AccountID),
	PRIMARY KEY (ExamID)
);

CREATE TABLE ExamQuestion(
	ExamID 				TINYINT,
    QuestionID 			TINYINT,
	FOREIGN KEY (ExamID) 		REFERENCES Exam(ExamID),
	FOREIGN KEY (QuestionID) 	REFERENCES Question(QuestionID)
);


