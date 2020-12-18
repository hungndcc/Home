DROP DATABASE if exists TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;


CREATE TABLE Department (
	DepartmentID 		INT 			AUTO_INCREMENT,
    DepartmentName 		VARCHAR(50) 	NOT NULL,
    PRIMARY KEY (DepartmentID)
);  

CREATE TABLE `Position`(
	PositionID 			INT UNSIGNED 	AUTO_INCREMENT,
    PositionName 		VARCHAR(55) 	NOT NULL,
    PRIMARY KEY (PositionID)
);

CREATE TABLE `Account`(
	AccountID 			INT 		NOT NULL,
    Email 				VARCHAR(255) 	NOT NULL		UNIQUE,
    Username 			VARCHAR(50) 	NOT NULL		UNIQUE		CHECK (length(Username) > 6),
    Fullname 			VARCHAR(50) 	NOT NULL,
    DepartmentID 		INT,
    PositionID 			INT ,
    CreateDate 			DATE,
    FOREIGN KEY (DepartmentID) 			REFERENCES Department(DepartmentID),
    PRIMARY KEY (AccountID)
);

CREATE TABLE `Group`(
	GroupID 			INT 			AUTO_INCREMENT,
	GroupName 			VARCHAR(50)		NOT NULL,
	CreatorID 			INT 			NOT NULL,
	CreateDate 			DATE,
    FOREIGN KEY (CreatorID) 			REFERENCES `Account`(AccountID),
    PRIMARY KEY (GroupID)
);

CREATE TABLE GroupAccount(
	GroupID 			INT 		NOT NULL,
    AccountID 			INT 		NOT NULL,
    JoinDate 			DATE,
	FOREIGN KEY (GroupID) 				REFERENCES `Group`(GroupID),
	FOREIGN KEY (AccountID) 			REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion(
	TypeID 				INT  		NOT NULL,
    TypeName 			VARCHAR(50),
    PRIMARY KEY (TypeID)
);

CREATE TABLE CategoryQuestion(
	CategoryID 			INT 		NOT NULL,
    CategoryName 		VARCHAR(55),
    PRIMARY KEY (CategoryID) 
) ;
CREATE TABLE Question(
	QuestionID 			INT 		NOT NULL,
    Content 			VARCHAR(255),
    CategoryID 			INT 		NOT NULL,
    TypeID 				INT			NOT NULL,
    CreatorID 			INT 		NOT NULL,
    CreateDate 			DATE,
	FOREIGN KEY (CategoryID) 			REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (TypeID) 				REFERENCES TypeQuestion(TypeID),
	FOREIGN KEY (CreatorID) 			REFERENCES `Account`(AccountID),
    PRIMARY KEY (QuestionID)
);
CREATE TABLE	Answer(
	AnswerID			INT			NOT NULL,
    Content				VARCHAR(255),
    QuestionID			INT			NOT NULL,
    isCorrect			INT			NOT NULL,
    PRIMARY KEY	(AnswerID),
    FOREIGN KEY	(QuestionID)			REFERENCES Question(QuestionID)
);

CREATE TABLE Exam(
	ExamID 				CHAR(5)			NOT NULL,
    `Code`				VARCHAR(50),
    Title 				VARCHAR(50),
    CategoryID 			INT 		NOT NULL,
    Duration 			INT,
    CreatorID 			INT 		NOT NULL,
    CreateDate 			DATE,
	FOREIGN KEY (CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (CreatorID) 	REFERENCES `Account`(AccountID),
	PRIMARY KEY (ExamID)
);

CREATE TABLE ExamQuestion(
	ExamID 				CHAR(5),
    QuestionID 			INT,
	FOREIGN KEY (ExamID) 		REFERENCES Exam(ExamID),
	FOREIGN KEY (QuestionID) 	REFERENCES Question(QuestionID)
);

INSERT INTO Department 
VALUES		('1',		'Marketing'		),
			('2',		'Sale'			),
            ('3',		'Bảo vệ'		),
            ('4',		'Nhân sự'		),
            ('5',		'Kỹ thuật'		),
            ('6',		'Tài chính'		),
            ('7',		'Phó giám đốc'	),
            ('8',		'Giám đốc'		),
            ('9',		'Thư kí'		),
            ('10',		'Bán hàng'		);
            
INSERT INTO Position
VALUES 		('1',	'Dev'			),
			('2',	'Test'			),
			('3',	'Sctrum Master'	),
			('4',	'PM'			);
            
INSERT INTO `account` 	(AccountID   	,Username      				,Email      						,Fullname      			,DepartmentID		,PositionID		,CreateDate		)

VALUES 					
                        (1,      		'hungndcc',   				'hungndcc@gmail.com',      				'Nguyễn Quốc Hùng',		'1',				4,    			'2020-03-05'),      
						(2,      		'phucndcc',   				'minhphuc18@gmail.com',      			'Đoàn Minh Phúc'  ,   	'2',				1,				'2020-03-06'),                         
						(3,      		'phuongk',   				'vuongducphuong@gmail.com',     		'Vương Đức Phương',   	'3',				3,				'2020-04-02'),                         
						(4,				'ninhdelta',  				'ninh.delta@gmail.com',      			'Lê Quang Ninh'   ,   	'4',				2,				'2020-05-05'),                         
						(5,      		'nvhvt1992',  				'nvhvt1992@gmail.com',      			'Nguyễn Vĩnh Hà',    	'5',				1,				'2020-06-15'),                         
						(6,      		'chuong9',   				'chuongcao99@gmail.com',     			'Cao Thế Chương',    	'6',				2,				'2020-03-23'),                         
						(7,      		'kaidinh97',  				'vudk97@gmail.com',       				'Vũ Đình Khải',     	'7',				3,				'2020-07-05'),                         
						(8,      		'tintin',   				'tintintin@gmail.com',      			'Đặng Đức Tin',     	'8',				1,				'2020-01-05'),                         
						(9,      		'phuong2k',   				'phuong2k@gmail.com',      				'Nguyễn Thu Phương',  	'1',				2,				'2020-02-12'),                         
						(10,     		'caixedap',   				'xuanteo@gmail.com',      				'Cao Xuan Dao',  		'2',				3,				'2020-06-1'	);
                        
INSERT INTO `Group`	( GroupName				,CreatorID		,CreateDate)
VALUES				(N'Testing System'		,'5'			,'2019-03-05'),
					(N'Developement'		,'1'			,'2020-03-07'),
                    (N'VTI Sale 01'			,'2'			,'2020-03-09'),
                    (N'VTI Sale 02'			,'3'			,'2020-03-10'),
                    (N'VTI Sale 02'			,'4'			,'2020-03-28'),
                    (N'VTI Creator'			,'6'			,'2020-04-06'),
                    (N'VTI Marketing 01'	,'7'			,'2020-07-07'),
                    (N'Management'			,'8'			,'2020-04-08'),
                    (N'Chat with love'		,'9'			,'2020-04-09'),
                    (N'Vi Ti Ai'			,'10'			,'2020-04-10');
INSERT INTO GroupAccount	(	GroupID		,AccountID		,JoinDate		)
VALUES						(		'1'		,	'1'			,'2019-03-05'	),
							(		'2'		,	'2'			,'2019-03-07'	),
                            (		'3'		,	'3'			,'2019-03-09'	),
                            (		'4'		,	'4'			,'2019-03-10'	),
                            (		'5'		,	'5'			,'2019-03-28'	),
                            (		'6'		,	'6'			,'2019-04-06'	),
                            (		'7'		,	'7'			,'2019-04-07'	),
                            (		'8'		,	'8'			,'2019-04-08'	),
                            (		'9'		,	'9'			,'2019-04-09'	),
                            (		'10'	,	'10'		,'2019-04-10'	);
                            
INSERT INTO typequestion 	(TypeID 		,TypeName			)
VALUES						('1'			,'Essay'			),
							('2' 			,'Multiple-Choice'	);
INSERT INTO	categoryquestion(CategoryID				,CategoryName		)
VALUES						('1'					,'Java'				),                    
							('2'					,'ASP.NET'			),
                            ('3'					,'ADO.NET'			),
                            ('4'					,'SQL'				),
                            ('5'					,'Postman'			),
                            ('6'					,'Ruby'				),
                            ('7'					,'C Sharp'			),
                            ('8'					,'PHP'				);
INSERT INTO Question 		(QuestionID				,Content				,CategoryID		,TypeID		,CreatorID		,CreateDate		)
VALUES						('1'					,'Câu hỏi về Java'		,	'1'			,	'1'		,	'1'			,'2020-04-05'	),
							('2'					,'Câu hỏi về PHP'		,	'8'			,	'2'		,	'2'			,'2020-04-05'	),
							('3'					,'Câu hỏi về Ruby'		,	'6'			,	'1'		,	'4'			,'2020-04-06'	),
                            ('4'					,'Câu hỏi về Postman'	,	'5'			,	'1'		,	'5'			,'2020-04-06'	),
                            ('5'					,'Câu hỏi về ADO.NET'	,	'3'			,	'2'		,	'6'			,'2020-04-06'	),
                            ('6'					,'Câu hỏi về ASP.NET'	,	'2'			,	'1'		,	'7'			,'2020-04-06'	),
                            ('7'					,'Câu hỏi về SQL'		,	'4'			,	'2'		,	'9'			,'2020-04-07'	),
                            ('8'					,'Câu hỏi về Python'	,	'7'			,	'1'		,	'10'		,'2020-04-07'	);

INSERT INTO Answer			(AnswerID			,Content			,QuestionID			,isCorrect	)
VALUES						('1'				,'Trả lời 01'		,	1				,	0		),
                            ('2'				,'Trả lời 02'		,	1				,	1		),
                            ('3'				,'Trả lời 03'		,	1				,	0		),
                            ('4'				,'Trả lời 04'		,	1				,	1		),
                            ('5'				,'Trả lời 05'		,	2				,	1		),
                            ('6'				,'Trả lời 06'		,	3				,	1		),
                            ('7'				,'Trả lời 07'		,	4				,	0		),
                            ('8'				,'Trả lời 08'		,	8				,	0		),
                            ('9'				,'Trả lời 09'		,	7				,	1		),
                            ('10'				,'Trả lời 10'		,	5				,	1		); 

INSERT INTO	Exam			(ExamID			,`Code`			,Title				,CategoryID		,Duration		,CreatorID		,CreateDate			)
VALUES						('E1'			,'VTIQ001'		,'Đề thi Java'		,	'1'			,	60			,	'5'			,'2019-04-05'		),
                            ('E2'			,'VTIQ002'		,'Đề thi SQL'		,	'7'			,	60			,	'1'			,'2019-04-05'		),
                            ('E3'			,'VTIQ003'		,'Đề thi Ruby'		,	'6'			,	60			,	'3'			,'2020-04-08'		),
                            ('E4'			,'VTIQ004'		,'Đề thi Postman'	,	'5'			,	120			,	'4'			,'2020-04-10'		),
                            ('E5'			,'VTIQ005'		,'Đề thi ADO.NET'	,	'3'			,	60			,	'6'			,'2020-04-05'		),
                            ('E6'			,'VTIQ006'		,'Đề thi ASP.NET'	,	'2'			,	60			,	'7'			,'2020-04-05'		),
                            ('E7'			,'VTIQ007'		,'Đề thi PHP'		,	'8'			,	60			,	'8'			,'2020-04-07'		),
                            ('E8'			,'VTIQ008'		,'Đề thi Postman'	,	'4'			,	90			,	'9'			,'2020-04-07'		);
INSERT INTO ExamQuestion	(ExamID			,QuestionID)
VALUES						('E1'			,'1'),
							('E2'			,'2'),
                            ('E3'			,'3'),
                            ('E4'			,'4'),
                            ('E5'			,'5'),
                            ('E6'			,'6'),
                            ('E7'			,'7'),
                            ('E8'			,'8');
                            
						
                            
                            


