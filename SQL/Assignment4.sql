USE TestingSystem;
-- =================================================================

-- 1. : Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS Show_Department;
DELIMITER $$
CREATE PROCEDURE Show_Department (IN DepartmentName_in VARCHAR(50) )
	BEGIN
		SELECT	a.*
		FROM	`Account` a
		JOIN	Department d ON a.DepartmentID = d.DepartmentID
		WHERE	d.DepartmentName = DepartmentName_in;
	END$$
DELIMITER ;

CALL Show_Department ('Sale');

-- 2. Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS Show_Number_Account
DELIMITER $$
CREATE PROCEDURE Show_Number_Account (IN GroupName_in VARCHAR(50) )
	BEGIN
		SELECT	g.GroupName, count(a.AccountID) as so_thanh_vien
		FROM	((GroupAccount ga
		JOIN	`Account` a ON  a.AccountID =ga.AccountID)
        JOIN	`Group` g ON g.GroupID = ga.GroupID)
		GROUP BY ga.GroupID
        HAVING	g.GroupName = GroupName_in;
	END$$
DELIMITER ;

CALL Show_Number_Account ('Testing System');

-- 3. Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS statistic_typequestion
DELIMITER $$
CREATE PROCEDURE statistic_typequestion ()
    BEGIN
		SELECT	tq.TypeName,count(q.TypeID) as Number_Of_Question
        FROM	TypeQuestion tq
        JOIN	Question q	ON tq.TypeID = q.TypeID
        GROUP BY tq.TypeName
		HAVING	MONTH(CreateDate) = Month(NOW()) ;
	END $$
DELIMITER ;

CALL statistic_typequestion;

-- 4. Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS Show_ID_Max_Question;
DELIMITER  $$
CREATE PROCEDURE Show_ID_Max_Question ()
	BEGIN
		WITH Max_Count_TypeID AS(
			SELECT	TypeID,count(TypeID) as Number_Of_Question
			FROM	Question
			GROUP BY TypeID
			ORDER BY Number_Of_Question DESC
			LIMIT 1
            )
			SELECT 	* FROM MAX_Count_TypeID;
	END $$
DELIMITER  ;

CALL Show_ID_Max_Question;
-- --------------------------------------------------------------

-- 5.  Sử dụng store ở question 4 để tìm ra tên của type question


DROP PROCEDURE IF EXISTS Show_TypeName_Question;
DELIMITER  $$
CREATE PROCEDURE Show_TypeName_Question ()
	BEGIN
		WITH Max_Count_TypeID AS(
			SELECT	TypeID
			FROM	Question
			GROUP BY TypeID
			ORDER BY count(TypeID) DESC
			LIMIT 1
            )
			SELECT 	tq.TypeName
            FROM	Question q 
            JOIN	TypeQuestion tq ON q.TypeID = tq.TypeID
            GROUP BY q.TypeID
            HAVING	tq.TypeID = (SELECT * FROM Max_Count_TypeID)
            ;
	END $$
DELIMITER  ;

CALL Show_TypeName_Question;

-- 6. Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
--    chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
--    chuỗi của người dùng nhập vào

DROP PROCEDURE IF EXISTS Show_GroupName;

DELIMITER $$
CREATE PROCEDURE Show_GroupName (IN String_in NVARCHAR(50))
BEGIN
		SELECT 	GroupName as GroupName_Or_UserName
		FROM	`Group` 
        WHERE	GroupName LIKE CONCAT('%', String_in, '%')
        UNION
        SELECT	UserName
        FROM	`Account`
        WHERE	UserName LIKE CONCAT('%', String_in, '%');
	
END $$
DELIMITER ;

CALL Show_Groupname('VTI');

-- 7.  Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công


DROP PROCEDURE IF EXISTS Create_Account;

DELIMITER $$
CREATE PROCEDURE Create_Account (IN in_fullname NVARCHAR(50) ,IN in_email NVARCHAR(50)) 
BEGIN
	DECLARE UserName VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email,'@',1); 
    DECLARE PositionID TINYINT DEFAULT 1;
    DECLARE DepartmentID TINYINT DEFAULT 10;
    DECLARE CreateDate DATETIME DEFAULT NOW();
    INSERT INTO `Account` 	(Email			,Username			,FullName				,DepartmentID		,PositionID			,CreateDate)
	VALUES					(in_email		,UserName			,in_fullname			,DepartmentID		,PositionID			,CreateDate);
    
    SELECT * FROM `Account` a WHERE a.email = in_email;
END $$
DELIMITER ;

CALL Create_Account ('Ngyen Ba Vuong' ,'bavuong@gmail.com');

-- 8. Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS Longest_Content_Question;

DELIMITER $$
CREATE PROCEDURE Longest_Content_Question (IN in_TypeQuestion ENUM('Essay','Multiple-Choice'))
BEGIN
	SELECT 	q.Content,tq.TypeName,max(length(q.Content))
    FROM	Question q
    JOIN	TypeQuestion tq ON q.TypeID = tq.TypeID
    WHERE	tq.TypeName = in_TypeQuestion;
    
END $$
DELIMITER ;

CALL Longest_Content_Question ('Essay');
CALL Longest_Content_Question ('Multiple-Choice');

