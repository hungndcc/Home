USE TestingSystem;

-- 2
SELECT 
*
FROM
department;

-- 3
SELECT 	departmentID
FROM 	department
WHERE 	DepartmentName = 'Sale';

-- 4
SELECT 	*
FROM	`account`
ORDER BY length(FullName) DESC
LIMIT 1;
-- 5
SELECT 	*
FROM		`account`
WHERE		DepartmentID = 3
ORDER BY	length(FullName)
LIMIT 1;
-- 6
SELECT 	GroupName
FROM 	`Group`
WHERE 	CreateDate < 2019-20-12;


