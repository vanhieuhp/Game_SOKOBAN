create database salaryManagement;
use salaryManagement;



create table CHUCVU(
ma_CV char(10) primary key,
ten_CV nchar(100),
phu_cap float check(phu_cap >= 0));



create table PHONGBAN(
ma_PB char(10) primary key,
ten_PB nchar(100),
dien_thoai char(12));



create table NHANVIEN(
ma_NV char(10) primary key,
ten_NV nchar(40) not null,
he_so_luong float check(he_so_luong >= 0),
ma_CV char(10),
ma_PB char(10),
foreign key (ma_CV) references CHUCVU(ma_CV),
foreign key (ma_PB) references PHONGBAN(ma_PB));

insert into CHUCVU values('CV1', 'Nhan Vien',1)
insert into CHUCVU values('CV2', 'Pho phong',2)
insert into CHUCVU values('CV3', 'Truong Phong',3)
insert into CHUCVU values('CV4', 'Giam Doc',4)

insert into PHONGBAN values('PB1', 'Hanh Chinh',09090000)
insert into PHONGBAN values('PB2', 'Nhan Su',09999)
insert into PHONGBAN values('PB3', 'Ke Toan',0777777)

insert into NHANVIEN values('NV1','Tran Ngoc Anh',3,'CV1','PB1')
insert into NHANVIEN values('NV2','Nguyen Thu Ha',4,'CV1','PB1')
insert into NHANVIEN values('NV3','Tran Ngan',5,'CV2','PB3')
insert into NHANVIEN values('NV4','Le Thu An',3,'CV3','PB1')
insert into NHANVIEN values('NV6','Tran Ha',6,'CV4','PB3')

insert into LUONG values('T1', 'NV1', 1400000, 500000, 0, 0)
insert into LUONG values('T2', 'NV2', 1400000, 0, 0,0)
insert into LUONG values('T3', 'NV3', 1400000, 0, 0,0)
insert into LUONG values('T4', 'NV4', 1400000, 300000, 0,0)

create table LUONG(
ma_luong char(10) primary key,
ma_NV char(10) references NHANVIEN(ma_NV),
luong_co_ban float check(luong_co_ban > 0),
khoan_cong float check(khoan_cong >= 0),
khoan_tru float check(khoan_tru >= 0),thuc_linh float);

Select * from NHANVIEN;
Select * from CHUCVU;
Select * from PHONGBAN;
Select * from LUONG;

--- thuc_linh =  luong_co_ban * (he_so_luong + phu_cap) + khoang_cong - khoan_tru
select * from LUONG;
update LUONG set thuc_linh = luong_co_ban * ( he_so_luong + phu_cap) + khoan_cong - khoan_tru
from LUONG, NHANVIEN, CHUCVU
where LUONG.ma_NV = NHANVIEN.ma_NV and NHANVIEN.ma_CV = CHUCVU.ma_CV;


select * from CHUCVU;
select * from NHANVIEN;
select * from lUONG;
-- write trigger for Luong table
create trigger trg_updateLuong on LUONG after update
as 
begin
update LUONG
	set thuc_linh = inserted.luong_co_ban * (NHANVIEN.he_so_luong + CHUCVU.phu_cap) + inserted.khoan_cong - inserted.khoan_tru
	from LUONG, CHUCVU, NHANVIEN, inserted
	where LUONG.ma_luong = inserted.ma_luong and LUONG.ma_NV = NHANVIEN.ma_NV and NHANVIEN.ma_CV = CHUCVU.ma_CV
end
go

disable trigger trg_updateLuong on LUONG;
enable trigger trg_updateLuong on LUONG;
update LUONG set khoan_cong = 100000 where ma_luong = 'T2';
select * from CHUCVU;
select * from NHANVIEN;
select * from lUONG;

--- create view 
create view V_TongHop as (
select LUONG.ma_luong, luong.ma_NV, NHANVIEN.ten_NV, NHANVIEN.ma_PB, 
LUONG.luong_co_ban, CHUCVU.phu_cap, NHANVIEN.he_so_luong, LUONG.khoan_cong, LUONG.khoan_tru, LUONG.thuc_linh
from CHUCVU, NHANVIEN, LUONG
where LUONG.ma_NV = NHANVIEN.ma_NV and NHANVIEN.ma_CV = CHUCVU.ma_CV);
select * from V_TongHop;
-- write trigger for NHANVIEN table
update LUONG set luong_co_ban = '1700000' where ma_luong = 'T1';
update LUONG set khoan_tru = '300000' where ma_luong = 'T1';
create trigger trg_NHANVIEN_UPDATE on NHANVIEN for update
as
begin
update LUONG
	set thuc_linh = LUONG.luong_co_ban * (inserted.he_so_luong + CHUCVU.phu_cap) + LUONG.khoan_cong - LUONG.khoan_tru
	from LUONG, CHUCVU, NHANVIEN, inserted
	where LUONG.ma_NV = NHANVIEN.ma_NV and NHANVIEN.ma_CV = CHUCVU.ma_CV
end
go

drop trigger trg_NHANVIEN_UPDATE;

select * from V_TongHop;
update NHANVIEN set he_so_luong = '3' where ma_NV = 'NV1';

-- create trigger for CHUCVU
create trigger trg_CHUCVU_UPDATE on CHUCVU for update
as
begin
update LUONG
	set thuc_linh = LUONG.luong_co_ban * (NHANVIEn.he_so_luong + inserted.phu_cap) + LUONG.khoan_cong - LUONG.khoan_tru
	from LUONG, CHUCVU, NHANVIEN, inserted
	where LUONG.ma_NV = NHANVIEN.ma_NV and NHANVIEN.ma_CV = CHUCVU.ma_CV
end
go

select * from V_TongHop;
select * from CHUCVU;
update CHUCVU set phu_cap = 1 where ma_CV = 'CV1';

-- Viết thủ tục thêm, sửa, xóa của bảng Nhân viên, Chức vụ, Phòng ban, Lương
-- Cho biết số lượng nhân viên của từng phòng ban
select * from NHANVIEN;
select NHANVIEN.ma_PB, ten_PB, count(ma_NV) as so_NV from NHANVIEN, PHONGBAN
where NHANVIEN.ma_PB = PHONGBAN.ma_PB
group by NHANVIEN.ma_PB, ten_PB
having count(ma_NV) > 2;
insert into NHANVIEN values('NV9', 'Tran Ha', 6, 'CV4', 'PB2');

