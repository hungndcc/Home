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
			SELECT	count(TypeID) as Number_Of_Question
			FROM	Question
			GROUP BY TypeID
			ORDER BY Number_Of_Question DESC
			LIMIT 1
            )
			SELECT 		TypeID
			FROM		Question
			GROUP BY 	TypeID
			HAVING		COUNT(TypeID) = (SELECT * FROM MAX_Count_TypeID);
	END $$
DELIMITER  ;

CALL Show_ID_Max_Question;
-- --------------------------------------------------------------

-- 5.  Sử dụng store ở question 4 để tìm ra tên của type question


SELECT * FROM Show_ID_Max_Question;






