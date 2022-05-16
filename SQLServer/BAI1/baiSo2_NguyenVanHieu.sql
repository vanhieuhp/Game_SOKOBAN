
--
use test;
select * from sv;
select * from lop;
---- Cả lớp viết thủ tục: Tìm kiếm sinh viên theo Tỉnh, và lớp
---- Cả lớp viết thủ tục: Thêm, Xóa trong bảng Sinh viên
---- Cả lớp viết thủ tục: Thêm, Xóa trong bảng Điểm
---- Cả lớp viết thủ tục: Thêm, Xóa trong bảng Môn học
-- them sv
CREATE PROC sp_ThemSv @masv char(10), @hoten nvarchar(30), @gioitinh nchar(10), @ngaysinh date, @malop char(10), @tinh char(20), @hocbong float
AS 
BEGIN 
	if exists(select MASV from SV where MASV = @masv)
		print 'Sinh vien nay da ton tai trong bang sv'
	else 
		if not exists(SELECT MALOP from LOP where MALOP = @malop)
			print 'Lop nay khong ton tai, vui long nhap lop chinh xac'
	else 
		INSERT INTO sv VALUES(@masv, @hoten, @gioitinh, @ngaysinh, @malop, @tinh, @hocbong)
end;

DROP PROC sp_ThemSv;
EXEC sp_ThemSv 'Sv13', 'Pham Huy Hoang', 'Nam', '2002-11-03', 'TMDT62A','HaiPhong', 10;
EXEC sp_helptext sp_ThemSv;

-- xoa sv
DROP PROC sp_XoaSv;
CREATE PROC sp_XoaSv @masv char(10)
AS 
BEGIN 
	if exists(select MASV from DIEM where MASV = @masv)
		print 'Khong the xoa, Sinh vien nay dang duoc su dung'
	else
		if not exists(select MASV from SV where MASV = @masv)
		print 'Khong the xoa, Sinh vien chua co trong bang du lieu'
	else 
		DELETE FROM SV WHERE MASV = @masv
end;

EXEC sp_XoaSv 'Sv13';

SELECT * FROM MONHOC;
-- Viet thu tuc su dung du lieu --Update
INSERT INTO MONHOC VALUES (''


DROP PROC sp_UpdateMh;
CREATE PROC sp_UpdateMh @subjectCode char(10), @tinchi int
AS 
BEGIN 
	if not exists(select MAMH from MONHOC where MAMH = @subjectCode)
		print 'Mon hoc nay chua ton tai trong bang du lieu'
	else 
		UPDATE MONHOC SET SOTC = @tinchi WHERE MAMH = @subjectCode
end;
EXEC sp_help MONHOC;
EXEC sp_UpdateMh 'TRR', 3;

-- reupdate diem of student which knows studentCode, subjectCodes( Score1, Score2, Score3)
-- diem hp co cap nhat lai khong
SELECT * FROM DIEM;
EXEC sp_help DIEM;

DROP PROC sp_UpdateScore;
CREATE PROC sp_UpdateScore @studentCode char(10), @subjectCode char(10), @Score1 float, @Score2 float, @Score3 float
AS 
BEGIN 
	if not exists(select MAMH from MONHOC where MAMH = @subjectCode)
		print 'Not exist subject in data table'
	else
		if not exists(select MASV from sv where MASV = @studentCode)
		print 'Not exist student in data table'
	else 
		UPDATE DIEM SET DIEM1 = @Score1, DIEM2 =@Score2, DIEM3 = @Score3, DIEMHP = @Score1*0.1 + @Score2 * 0.2 + @Score3 * 0.7
		WHERE MASV = @studentCode AND MAMH = @subjectCode
end;
EXEC sp_UpdateScore 'Sv1', 'GDTC1', 9, 9, 10;

-- look up student by province and class
DROP PROC sp_searchStudent;
CREATE PROC sp_searchStudent @province nvarchar(30), @classCode char(10)
AS
SELECT * FROM sv WHERE TINH = @province AND MALOP = @classCode;

SELECT * FROM lop;
SELECT * FROM sv;
EXEC sp_searchStudent N'Hà Nội', 'CNTT62A';
SELECT * FROM sv
WHERE TINH = N'Hà Nội';
