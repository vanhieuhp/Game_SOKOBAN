CREATE DATABASE QLKTX2022;
USE QLKTX2022
GO


create table NhanVien(
maNV char(10) primary key,
hoTen nvarchar(40) not null,
ngaySinh date not null,
gioiTinh nvarchar(3),
dienThoai char(12))



create table NhaKTX(
maNha char(10) primary key,
tenNha nvarchar(32) not null,
maNV char(10) references NhanVien(maNV),
soLuongPhong int check(soLuongPhong >= 0))



create table PhongO(
maPhong char(10) primary key,
maNha char(10) references NhaKTX(maNha),
soLuongCho int check(soLuongCho>=0))



create table SinhVien(
maSV char(10) primary key,
hoTen nvarchar(40) not null,
lop nchar(60),
khoa nchar(60),
ngaySinh date not null,
gioiTinh nvarchar)


create table PhanPhongO(
namHoc int check(namHoc>0),
maPhong char(10) references PhongO(maPhong),
maSV char(10) references SinhVien(maSV),
tuNgay date,
denNgay date)

select * from nhanvien;
select * from NhaKTX;
select * from PhongO;
select * from SinhVien;
select * from PhanPhongO;

drop table nhanvien;
drop table NhaKTX;
drop table PhongO;
drop table SinhVien;
drop table PhanPhongO;



-- nhap co so du lieu
insert into NhanVien values('Nv1', N'Nguyễn Văn Hiếu', '10-01-2002', N'Nam', 0); 
insert into NhanVien values('Nv2', N'Nguyễn Văn Nam', '10-05-2002', N'Nam', 0); 
insert into NhanVien values('Nv3', N'Nguyễn Văn Hoàng', '09-09-2000', N'Nam', 0); 
insert into NhanVien values('Nv4', N'Nguyễn Minh Quang', '02-08-1999', N'Nam', 0); 
insert into NhanVien values('Nv5', N'Nguyễn Thái Ngọc', '10-06-2002', N'Nam', 0); 
insert into NhanVien values('Nv6', N'Phạm Minh Hường', '01-11-2002', N'Nữ', 0); 
insert into NhanVien values('Nv7', N'Trịnh Thu Phương', '12-02-2002', N'Nữ', 0); 
insert into NhanVien values('Nv8', N'Phạm Trung Anh', '11-03-2000', N'Nữ', 0); 
insert into NhanVien values('Nv9', N'Nguyễn Phương Thảo', '05-10-2002', N'Nữ', 0); 

select * from NhanVien;


insert into NhaKTX values('nha1', N'ktx1', 'Nv1', 10);
insert into NhaKTX values('nha2', N'ktx2', 'Nv2', 7);
insert into NhaKTX values('nha3', N'ktx3', 'Nv3', 5);
insert into NhaKTX values('nha4', N'ktx4', 'Nv4', 8);
insert into NhaKTX values('nha5', N'ktx5', 'Nv5', 8);
insert into NhaKTX values('nha6', N'ktx6', 'Nv6', 10);
insert into NhaKTX values('nha7', N'ktx7', 'Nv7', 15);
insert into NhaKTX values('nha8', N'ktx8', 'Nv8', 9);
insert into NhaKTX values('nha9', N'ktx9', 'Nv9', 9);

select * from NhaKTX;

create table PhongO(
maPhong char(10) primary key,
maNha char(10) references NhaKTX(maNha),
soLuongCho int check(soLuongCho>=0))

insert into PhongO values ('103', 'nha1', 4);
insert into PhongO values ('101', 'nha1', 4);
insert into PhongO values ('102', 'nha1', 2);
insert into PhongO values ('201', 'nha1', 3);
insert into PhongO values ('202', 'nha1', 4);
insert into PhongO values ('203', 'nha1', 5);

insert into PhongO values ('105', 'nha2', 4);
insert into PhongO values ('204', 'nha2', 4);
insert into PhongO values ('205', 'nha2', 2);
insert into PhongO values ('301', 'nha3', 3);
insert into PhongO values ('301', 'nha3', 4);
insert into PhongO values ('206', 'nha2', 5);

insert into PhongO values ('401', 'nha4', 4);
insert into PhongO values ('502', 'nha5', 4);
insert into PhongO values ('503', 'nha5', 2);
insert into PhongO values ('504', 'nha5', 3);
insert into PhongO values ('505', 'nha5', 4);
insert into PhongO values ('402', 'nha4', 5);

insert into PhongO values ('601', 'nha6', 4);
insert into PhongO values ('602', 'nha6', 4);
insert into PhongO values ('603', 'nha6', 2);
insert into PhongO values ('604', 'nha6', 3);
insert into PhongO values ('605', 'nha6', 4);
insert into PhongO values ('606', 'nha6', 5);

insert into PhongO values ('701', 'nha7', 4);
insert into PhongO values ('702', 'nha7', 4);
insert into PhongO values ('801', 'nha8', 2);
insert into PhongO values ('802', 'nha8', 3);
insert into PhongO values ('803', 'nha8', 4);
insert into PhongO values ('804', 'nha8', 5);

insert into PhongO values ('901', 'nha9', 4);
insert into PhongO values ('902', 'nha9', 4);
insert into PhongO values ('903', 'nha9', 2);
insert into PhongO values ('703', 'nha7', 3);
insert into PhongO values ('704', 'nha7', 4);
insert into PhongO values ('705', 'nha7', 5);


insert into SinhVien values('Vs1', N'Nguyen Van A', 'CnttA', '62', '10-01-2002', 'm');
insert into SinhVien values('Vs2', N'Nguyen Van B', 'CnttA', '62', '10-02-2002', 'm');
insert into SinhVien values('Vs3', N'Nguyen Van C', 'CnttA', '62', '10-03-2002', 'm');
insert into SinhVien values('Vs4', N'Nguyen Van d', 'CnttA', '62', '10-04-2002', 'm');
insert into SinhVien values('Vs5', N'Nguyen Thi A', 'CnttB', '62', '10-05-2002', 'f');
insert into SinhVien values('Vs6', N'Nguyen Thi B', 'CnttB', '62', '10-06-2002', 'f');
insert into SinhVien values('Vs7', N'Nguyen Thi C', 'CnttC', '62', '10-07-2002', 'f');
insert into SinhVien values('Vs8', N'Nguyen Thi D', 'CnttB', '62', '10-08-2002', 'f');

create table PhanPhongO(
namHoc int check(namHoc>0),
maPhong char(10) references PhongO(maPhong),
maSV char(10) references SinhVien(maSV),
tuNgay date,
denNgay date)

insert into PhanPhongO values (3,  '101' , 'Sv3', '2021', '2022');

delete from PhanPhongO where namHoc = 3;
select * from PhanPhongO;

CREATE PROC spThemSinhVien (@masv varchar(10), @hoTen varchar(100),
@lop varchar(100), @khoa varchar(100),
@ngaySinh date, @gioiTinh varchar(3))
AS
BEGIN
	IF exists (SELECT @masv FROM SinhVien WHERE @masv = masv)
		print 'Thong tin sinh vien nay da cos trong he thong'
	else 
		INSERT INTO SinhVien values(@masv, @hoTen, @lop, @khoa, @ngaySinh, @gioiTinh)
END;

DROP PROC spThemSinhVien;
SELECT * FROM SinhVien; 
EXEC spThemSinhVien 'sv9', 'Van Hieu', 'CNTT62B','62','10-01-2002', 'm';

//* create build proc them phong*/

CREATE PROC spThemPhongO(@maPhong varchar(100), @maNha varchar(10), @soLuong int)
AS
Begin
	if exists(SELECT maPhong FROM phongO WHERE @maPhong = maPhong)
		print 'Thong tin ma phong nay da co trong he thong'
	else 
		if not exists(SELECT maNha FROM NhaKTX WHERE @maNha = maNha)
			print 'Chua co thong tin ma nha KTX trong he thong'
	else 
		INSERT INTO PhongO VALUES(@maPhong, @maNha, @soLuong)
END;

SELECT * FROM PhongO;
EXEC spThemPhongO '104', 'nha1', 4;
DELETE FROM PhongO WHERE maNha = 'nha3';

UPDATE PhongO SET soLuongCho = 15;
/* creat build add phanPhong */
CREATE PROC spThemPhanPhong(@namHoc int, @maPhong varchar(100), @maSV varchar(100), @tuNgay date, @denNgay date)
AS
BEGIN if exists (SELECT maSV FROM PhanPhongO where maSV = @maSV)
			print 'Sinh vien nay da thue phong roi'
	  else
		if ((SELECT count(*) from PhanPhongO where maPhong = @maPhong) >= 15)
			print 'Phong nay da dat gioi han so sinh vien - 15 sinh vien'
	 else
		INSERT INTO PhanPhongO VALUES(@namHoc, @maPhong, @maSV, @tuNgay, @denNgay)
		print 'dang ki phong o thanh cong'
END;

DROP PROC spThemPhanPhong;
SELECT * FROM PhanPhongO;
exec spThemPhanPhong('3', '201', 'Sv4', '12-02-2022', '06-06-2024');