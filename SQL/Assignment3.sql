USE TestingSystem;

-- 1.  Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW view_NV_Sale
AS
		SELECT		a.*
		FROM		`Account` a
		INNER JOIN	Department d ON	a.DepartmentID = d.DepartmentID
		WHERE		d.DepartmentName = 'Sale';

SELECT	*
FROM	view_NV_Sale;
-- 2. Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW view_InfAccountMaxGroup
AS
SELECT		a.*
FROM		`Account` a
INNER JOIN	GroupAccount ga
ON			a.AccountID = ga.AccountID
ORDER BY	ga.GroupID ASC
LIMIT 1;

SELECT 	* 
FROM 	view_InfAccountMaxGroup;

-- 3.  Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi

CREATE OR REPLACE VIEW view_InfAccountMaxGroup
AS
SELECT	QuestionID as qid
FROM	Question 
HAVING	length(Content) > 30;

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Question
WHERE QuestionID IN (	SELECT qid FROM (	SELECT	QuestionID as qid
												FROM	Question 
												HAVING	length(Content) > 30
											) as q
						);

-- 4. Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

CREATE OR REPLACE VIEW	view_DepMaxEmp
AS
SELECT	d.DepartmentName,count(a.AccountID) as so_nhan_vien
FROM	Department d
INNER JOIN	`Account` a ON d.DepartmentID = a.DepartmentID
GROUP BY	d.DepartmentID;
SELECT *
FROM	view_DepMaxEmp
HAVING	max(so_nhan_vien);

-- 5.  Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW	view_Question_Nguyen
AS
SELECT	q.*,a.FullName
FROM	Question q
INNER JOIN	`Account` a	ON q.CreatorID = a.AccountID
WHERE	a.FullName LIKE	'Nguyễn%';

SELECT *
FROM	view_Question_Nguyen;