create database VeMayBay;
/* CẢ LỚP LÀM BÀI TẬP NÀY NHÉ.



Cho CSDL
HK (Makhach, Tenkhach, Diachi, Dienthoai, SCMT): Hành khách
TB (MaTB, Noidi, Noiden, Thoigian, Giatien_1, Giatien_2): Tuyến bay
VB (Sove, Makhach, MaTB, Loai, Tinhtrang, Ngaydi): Vé bay
Trong đó: Loại vé T (Thường) ứng với giá tiền 1, Loại vé V (Vip) ứng với giá tiền 2.
Tình trạng = H (Huỷ), T (Trả lại), B (Bình thường).



1. Thiết lập cở sở dữ liệu để quản lý thông tin bài toán trên
2. Nhập dữ liệu cho phù hợp với cơ ở dữ liệu đã cho
3. Tạo View thông tin khách hàng đã đi bình thường trong tháng 3 năm 2022
4. Xây dựng thủ tục thêm Số vé, thêm hành khách, thêm tuyến bay
5. Thống kê số tiền các khách hàng trả lại vé trong tháng 3 năm 2022
6. Viết trigger tính tổng số tiền của một tuyến bay khi biết sau khi bổ sung, thay đổi tình trạng vé */

use VeMayBay;

create table HanhKhach (
maKhach char(10) primary key, 
tenKhack char(50),
diaChi char(50),
dienThoai char(50), 
TCC char(50)
);

create table TuyenBay (
maTuyenBay char(10) primary key, 
noiDi char(50), 
noiDen char(50),
thoiGian char(50), 
giaTien_1 int, 
giaTien_2 int);

create table VeBay(
maSoVe char(10) primary key,
maKhach char(10), 
maTuyenBay char(10),
loaiVe char(50),
tinhTrang char(50), 
ngayDi date,
foreign key (maKhach) references HanhKhach(maKhach),
foreign key (maTuyenBay) references TuyenBay(maTuyenBay) 
);

delete from TuyenBay

insert into HanhKhach values ('hk1', 'NguyenVanHieu', 'HaiPhong', '0969087705', '1001');
insert into HanhKhach values ('hk2', 'NguyenTienThinh', 'HoangXa', '0947587705', '1002');
insert into HanhKhach values ('hk3', 'LeThanhPhu', 'TanDan', '0946573844', '1003');
insert into HanhKhach values ('hk4', 'NguyenMinhTuan', 'TienHoi', '0938746112', '1004');
insert into HanhKhach values ('hk5', 'BuiHongNgoc', 'TanDan', '09888746352', '1005');
insert into HanhKhach values ('hk6', 'PhamMinhHuong', 'ThiTran', '0789678456', '1006');
insert into HanhKhach values ('hk7', 'VuThiCamNhung', 'HoangXa', '0972674859', '1007');

insert into TuyenBay values('TB1', 'HaiPhong', 'HoChiMinh', '3 gio', 1000, 2000);
insert into TuyenBay values('TB2', 'HaiPhong', 'HaNoi', '1 gio', 1000, 1800);
insert into TuyenBay values('TB3', 'HaiPhong', 'DaNang', '2 gio', 1000, 1900);

insert into VeBay values('ve1', 'hk1', 'TB1', 'Vip', 'B','03-10-2022');
insert into VeBay values('ve2', 'hk2', 'TB1', 'Thuong', 'B','03-15-2022');
insert into VeBay values('ve3', 'hk3', 'TB2', 'Thuong', 'H','03-10-2022');
insert into VeBay values('ve4', 'hk4', 'TB1', 'Vip', 'T','03-8-2022');
insert into VeBay values('ve5', 'hk5', 'TB2', 'Thuong', 'T','03-8-2022');
insert into VeBay values('ve6', 'hk6', 'TB3', 'Vip', 'BinhThuong','03-22-2022');
insert into VeBay values('ve7', 'hk7', 'TB3', 'Thuong', 'H','03-15-2022');

/* 3. tao view thong tin khach hang da di binh thuong trong thang 3 nam 2022 */
create view view_khachHangT3 as
select tenKhack, tinhTrang, ngayDi 
from HanhKhach, VeBay
where Hanhkhach.maKhach = VeBay.MaKhach and tinhTrang = 'B'
group by tenKhack, tinhTrang, ngayDi;


select * from view_khachHangT3;

/* Xay dung thu tuc them so ve, them hanh khach, them tuyen bay */
create proc proc_themHanhKhach @maKhach char(10), @tenKhach char(50), @diaChi char(50), @dienThoai char(50), @tcc char(50)
as 
begin
	if exists(select maKhach from HanhKhach where maKhach = @maKhach)
		print 'Khach Hang nay da book lich bay'
	else insert into HanhKhach values(@maKhach, @tenKhach, @diaChi, @dienThoai, @tcc)
end;

proc_themHanhkhach 'hk8', 'LeKienCuong', 'QuangHung', '0989888999','1008';
select * from HanhKhach;
update HanhKhach set dienThoai = '0987789999' where maKhach = 'hk5';

create proc proc_themTuyenBay @maTuyenBay char(10), @noiDi char(50), @noiDen char(50), @thoiGian char(50), @giaTien_1 int, @giaTien_2 int
as 
begin
	if exists(select maTuyenBay from TuyenBay where maTuyenBay = @maTuyenBay)
		print 'Khong the them tuyen bay, tuyen bay nay da ton tai'
	else if @giaTien_1 > @giaTien_2
		print 'Khong the them tuyen bay, gia tien Ve Vip phai lon hon gia tien Ve Thuong'
	else if @noiDen = @noiDi
		print'Noi den trung voi Noi di, Khong the them tuyen bay'
	else 
	begin
		print'Them tuyen bay tu ' + @noiDi + ' den ' + @noiDen +' thanh cong!'
		insert into TuyenBay values(@maTuyenBay, @noiDi, @noiDen, @thoiGian, @giaTien_1, @giaTien_2)
		end
end;

drop proc proc_themTuyenBay;
select * from TuyenBay;
delete from TuyenBay where maTuyenBay = 'TB4';
proc_themTuyenBay 'TB6', 'HaNoi', 'Manchester', '12 gio', '5000', '4500';
proc_themTuyenBay 'TB4', 'HaNoi', 'Manchester', '12 gio', '5000', '6000';
proc_themTuyenBay 'TB5', 'HaiPhong', 'London', '12 gio', '5000', '8000';

create proc proc_themVeBay @maSoVe char(10), @maKhach char(50), @maTuyenBay char(50), @loai char(50), @tinhTrang char(50), @ngayDi date
as 
begin
	if exists(select maSoVe from VeBay where maSoVe = @maSoVe)
		print 'Khong the them Ve Bay, loai ve bay nay da ton tai'
	else if not exists(select maKhach from HanhKhach where maKhach = @maKhach)
		print 'Khong the them Ve Bay, khong ton tai hanh khach nay'
	else if not exists(select maTuyenBay from TuyenBay where maTuyenBay = @maTuyenBay)
		print'Khong the them ve bay, tuyen bay nay khong ton tai'
	else
		begin
			print'Them ve bay thanh cong!'
			insert into VeBay values(@maSoVe, @maKhach, @maTuyenBay, @loai, @tinhTrang, @ngayDi)
		end
end;

/* Thong ke so tien cac khach hang tra ai ve trong thang 3 nam 2022 */
select SUM(giaTien_1) as tien 
if loaiVe = 'Thuong'
	SUM += giaTien_1
	else tien += giaTien_2
from HanhKhach, TuyenBay, VeBay
where HanhKhach.maKhach = VeBay.maKhach and TuyenBay.maTuyenBay = VeBay.maTuyenBay and tinhTrang = 'T';
