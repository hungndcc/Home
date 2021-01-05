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

DELIMITER $$
CREATE PROCEDURE Show_Number_Account (IN GroupName_in VARCHAR(50) )
	BEGIN
		SELECT	g.GroupName, count(a.AccountID) as so_thanh_vien
		FROM	(GroupAccount ga
		JOIN	`Account` a ON  a.AccountID =ga.AccountID)
        JOIN	`Group` g ON g.GroupID = ga.GroupID
		GROUP BY	ga.GroupID;
	END$$
DELIMITER ;