DROP DATABASE IF EXISTS DB;
CREATE DATABASE DB;
USE DB;

/*============================== CREATE TABLE=== =======================================*/
/*==========================student============================================================*/

-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table

DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
	ID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Name` 		NVARCHAR(30) NOT NULL UNIQUE KEY,
    Age			TINYINT UNSIGNED NOT NULL,
    Gender		TINYINT
);

DROP TABLE IF EXISTS `Subject`;
CREATE TABLE `Subject`(
	ID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Name` 		NVARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS StudentSubject;
CREATE TABLE StudentSubject(
	StudentID	TINYINT UNSIGNED ,
    SubjectID	TINYINT UNSIGNED ,
    Mark		TINYINT UNSIGNED ,
    `Date`		DATETIME DEFAULT NOW(),
    PRIMARY KEY (StudentID,SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Student(ID),
	FOREIGN KEY (SubjectID) REFERENCES `Subject`(ID)
);

INSERT INTO Student (`Name`					,Age		,Gender		)
VALUES				('Nguyen Quoc Hung'		,24			,0			),
					('Le Quang Ninh'		,23			,NULL		),
                    ('Tran Thi Thu Ha'		,23			,1			);
                    
 INSERT INTO `Subject` (`Name`			)
VALUES					('Toan'			),
						('Tieng Viet'	),
						('Tin'			);                   

 INSERT INTO StudentSubject (StudentID		,SubjectID			,Mark		,`Date`	)
VALUES						(1				,1					,10			,now()	),
							(1				,2					,NULL		,now()	),
							(2				,2					,NULL		,now()	),
                            (3				,1					,NULL		,now()	),
                            (1				,3					,9			,now()	),
                            (3				,3					,6			,now()	);
                            
-- Viết lệnh để
-- a) Lấy tất cả các môn học không có bất kì điểm nào

SELECT * FROM `Subject` sj
WHERE sj.ID NOT IN (SELECT ss.SubjectID
					FROM	StudentSubject ss);


-- b) Lấy danh sách các môn học có ít nhất 2 điểm
SELECT sj.`Name` 
FROM 	`Subject` sj
WHERE	sj.ID IN (
					SELECT ss.SubjectID AS ID
                    FROM	StudentSubject ss
                    GROUP BY ss.SubjectID
                    HAVING	count(ss.SubjectID) >= 2);


/* 3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,
Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
'Unknow' thay thế cho null) */

CREATE OR REPLACE VIEW StudentInfo 
AS
		SELECT		st.ID AS StudentID 
					,sj.ID AS SubjectID 
                    ,st.`Name` AS StudentName 
                    ,st.Age AS StudentAge 
                    ,CASE
						WHEN Gender = 0 THEN 'Male'
						WHEN Gender = 1 THEN 'Female'
						ELSE 'Unknow'
						END AS Gender
                    ,sj.`Name` AS SubjectName
                    ,ss.Mark AS Mark
                    ,ss.`Date`
		FROM		((StudentSubject ss
		INNER JOIN	Student st ON	ss.StudentID = st.ID)
        INNER JOIN	`Subject` sj ON ss.SubjectID = sj.ID);
-- -------------------------------------------------------------------



/*5. Viết 1 store procedure (có 2 parameters: student name) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter
Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
các học sinh
*/ 

DROP PROCEDURE IF EXISTS Delete_Info;
DELIMITER $$
CREATE PROCEDURE Delete_Info (IN in_StudentName VARCHAR(50) )
	BEGIN
		SET FOREIGN_KEY_CHECKS=0;
		IF in_StudentName = '*' THEN DELETE FROM Student;
		ELSE 	DELETE FROM Student
				WHERE Student.`Name` = in_StudentName;
		END IF;
	END $$
DELIMITER ;

CALL Delete_Info ('Nguyen Quoc Hung')