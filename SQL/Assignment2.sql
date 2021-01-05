USE TestingSystem;
-- 1.  lấy ra tất cả các phòng ban
SELECT	*
FROM	department;

-- 2.	lấy ra id của phòng ban "Sale"
SELECT 	departmentID
FROM 	department
WHERE 	DepartmentName = 'Sale';

-- 3.	lấy ra thông tin account có full name dài nhất
SELECT 	*
FROM	`account`
ORDER BY length(FullName) DESC
LIMIT 1;

-- 4. Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT 	GroupName
FROM   	`Group`
WHERE	CreateDate < '2019-12-20';

-- 5. Lấy ra ID của question có >= 4 câu trả lời
SELECT	QuestionID
FROM	`Answer`
HAVING	count(AnswerID) >= 4;

-- 6. : Lấy ra 5 group được tạo gần đây nhất
SELECT	*
FROM	`Group`
ORDER BY	CreateDate
Limit 5;

-- 8. Xóa tất cả các exam được tạo trước ngày 20/12/2019
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Exam
WHERE	CreateDate < '2019-12-20';

-- 9. Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn

UPDATE	`Account`
SET		FullName = 'Nguyễn Bá Lộc', email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;

-- 10. Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT  a.FullName ,d.DepartmentID ,d.DepartmentName 
FROM `Account` a
INNER JOIN department d
ON d.DepartmentID = a.DepartmentID;
-- 11. Viết lệnh để lấy ra tất cả các developer

SELECT 		*
FROM		`Account` a
INNER JOIN	Position p
ON 			p.PositionID = a.PositionID
WHERE		PositionName = 'Dev';

-- 12. Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT	d.DepartmentID, d.DepartmentName
FROM	department  d
INNER JOIN `Account` a
ON d.DepartmentID = a.DepartmentID
GROUP BY 	A.DepartmentID
HAVING	count(AccountID) > 3;

-- 13. Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT 		q.*,count(eq.QuestionID)
FROM		Question q
INNER JOIN 	ExamQuestion eq 
ON			q.QuestionID = eq.QuestionID
GROUP BY	eq.QuestionID
ORDER BY	count(eq.QuestionID) DESC
LIMIT 1;

-- 14. Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT		cq.*, count(q.CategoryID) as so_Question_duoc_su_dung
FROM		CategoryQuestion cq
INNER JOIN	Question q
ON			cq.CategoryID = q.CategoryID
GROUP BY 	q.CategoryID;

-- 15. Lấy ra Question có nhiều câu trả lời nhất

SELECT		q.*,count(a.QuestionID) as so_cau_tra_loi
FROM		Answer a
INNER JOIN	Question q
ON			a.QuestionID = q.QuestionID
GROUP BY	a.QuestionID
LIMIT 1;

-- 16. Tìm chức vụ có ít người nhất

SELECT		p.*,count(a.PositionID) as so_nguoi
FROM		`Account` a
INNER JOIN	Position p
ON			a.PositionID = p.PositionID
GROUP BY	a.PositionID 
ORDER BY so_nguoi ASC
LIMIT 1;

-- 17. Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM 

-- 18. Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …

SELECT		q.QuestionID, tq.TypeName,q.Content, an.Content, an.Iscorrect, FullName

FROM		Question q
INNER JOIN	TypeQuestion tq ON tq.TypeID = q.TypeID
INNER JOIN	Answer	an 		ON q.QuestionID = an.QuestionID
INNER JOIN 	`Account` ac	ON q.CreatorID = ac.AccountID;

-- 19.  Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT		tq.*, count(q.TypeID) as so_cau_hoi
FROM 		TypeQuestion tq
INNER JOIN	Question q 
ON			tq.TypeID = q.TypeID
GROUP BY	tq.TypeID




