USE TestingSystem;

-- 2.	 lấy ra tất cả các phòng ban
SELECT 
*
FROM
department;

-- 3.	lấy ra id của phòng ban "Sale"
SELECT 	departmentID
FROM 	department
WHERE 	DepartmentName = 'Sale';

-- 4.	lấy ra thông tin account có full name dài nhất
SELECT 	*
FROM	`account`
ORDER BY length(FullName) DESC
LIMIT 1;
-- 5.	Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3

SELECT 	*
FROM		`account`
WHERE		DepartmentID = 3
ORDER BY	length(FullName)
LIMIT 1;
-- 6.	Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT 	GroupName
FROM 	`Group`
WHERE 	CreateDate < '2019-12-20';

-- 7.	Lấy ra ID của question có >= 4 câu trả lời
SELECT 		QuestionID
FROM 		`Answer`
GROUP BY	QuestionID
HAVING		count(QuestionID) >=4;

-- 8.	 Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT		ExamID
FROM		exam
WHERE		Duration >= 60 AND CreateDate < '2019-12-20';

-- 9.	Lấy ra 5 group được tạo gần đây nhất
SELECT		*
FROM		`Group`
ORDER BY	CreateDate	ASC
LIMIT 5;

-- 10.	Đếm số nhân viên thuộc department có id = 2
SELECT		count(accountid)	AS 'So nhan vien '
FROM		`account`
WHERE		DepartmentID = 2;

-- 11.	Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT	*
FROM	`Account`
WHERE	(substring_index(FullName, ' ', -1)) LIKE	'D%o';

-- 12.	Xóa tất cả các exam được tạo trước ngày 20/12/2019
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM	Exam
WHERE	CreateDate < '2019-12-20';

-- 13.	 Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"	

DELETE FROM	Question
WHERE		Content LIKE 'Câu hỏi%';

-- 14.	Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn

UPDATE		`Account`
SET			FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn'
WHERE		AccountID = 5;

-- 15.	update account có id = 5 sẽ thuộc group có id = 4

UPDATE		`Account`
SET			GroupID = 4
WHERE		AccountID = 5;

