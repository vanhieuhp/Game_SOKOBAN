
create database QLBANHANG2022B;
use QLBANHANG2022B;

create table DMHANGHOA(
MaHang char(10) not null primary key,
TenHang nchar(50) not null,
Soluongton int not null,
Dongia int);

create table HANGBAN(
MaBan char(10) not null primary key,
MaHang char(10) references DMHANGHOA(MaHang),
NgayBan datetime,
NguoiBan char(50),
Soluongban int not null, thanhtien int)

insert into DMHANGHOA values('HH1','Bia 33', 200, 100)
insert into DMHANGHOA values('HH2','Bia HN', 600, 150)
insert into DMHANGHOA values('HH3','Ruou 123', 200, 40)
insert into DMHANGHOA values('HH4','Coca Cola 1', 30, 10)
insert into DMHANGHOA values('HH5','Nuoc ngot 1', 400, 50)

insert into HANGBAN values('MB1','HH1','12/12/2020',' Hong',20,0)
insert into HANGBAN values('MB2','HH2','11/12/2020',' Ha',20,0)
insert into HANGBAN values('MB3','HH2','15/12/2020',' Nga',10,0)
insert into HANGBAN values('MB4','HH3','10/12/2020',' Minh',20,0)
insert into HANGBAN values('MB5','HH1','09/12/2020',' Hung',30,0)

create trigger trg_DatHang on HANGBAN after insert as
begin
	update DMHANGHOA
		set Soluongton = Soluongton - (
			select soluongban from inserted 
			where inserted.MaHang = DMHANGHOA.MaHang )
		from DMHANGHOA, inserted where dmhanghoa.MaHang = inserted.MaHang
	update hangban set thanhtien = Soluongban * Dongia
	from DMHANGHOA, HANGBAN where DMHANGHOA.MaHang = HANGBAN.MaHang
end
go

ALTER TRIGGER trg_DatHang ON HANGBAN AFTER INSERT AS
BEGIN
UPDATE DMHANGHOA
SET SoLuongTon = SoLuongTon - (
SELECT Soluongban FROM inserted
WHERE inserted.MaHang = DMHANGHOA.MaHang )
FROM DMHANGHOA,inserted WHERE DMHANGHOA.MaHang = inserted.MaHang

UPDATE HANGBAN SET thanhtien = Soluongban* Dongia
FROM DMHANGHOA,HANGBAN WHERE DMHANGHOA.MaHang = HANGBAN.MaHang
END
GO

create proc SP_HANGBAN @MaBan char(10), @MaHang char(10), @NgayBan dateTime, @NguoiBan char(50), @Soluong int
as 
	if exists (select * from HANGBAN where MaBan = @MaBan)
		print 'Thong bao: ma ban hangnay da co'
	else
		if not exists (Select * from DMHANGHOA where MaHang = @MaHang)
		print 'Thong bao: Ma hang nay chua co trong danh muc'
	else
		if exists (select MaHang, Soluongton from DMHANGHOA where MaHang = @MaHang and Soluongton < @Soluong)
		print 'Thong bao: so luong mat hang nay khong du de ban'
	else
		insert into HANGBAN(MaBan, MaHang, NgayBan, NguoiBan, Soluongban) values(@MaBan, @MaHang, @NgayBan, @NguoiBan, @Soluong)
GO

SP_HANGBAN 'MB77', 'HH1', '09/12/2021', 'Ngoc', 70;
select* from HANGBAN;

/*Viet thu tuc them hang hoa moi chua co trong danh muc */
create proc sp_DMHANGHOA @MaHang char(50), @TenHang nvarchar(30), @SoLuong int, @Dongia int
as
	if exists (select * from DMHANGHOA where MaHang = @MaHang)
		print 'Thong bao: ma hang nay da co trong danh muc'
	else 
		insert into DMHANGHOA values(@MaHang, @TenHang, @SoLuong, @Dongia)	
Go

exec sp_DMHANGHOA 'HH7', 'Bia333', 200, 300; 

/* cap nhat them so luong hang hoa da co trong danh muc*/
create proc SP_DMHANGHOA_SL @MaHang char(10), @SoLuong int
as
	if exists (select * from DMHANGHOA where MaHang =  @MaHang)
		update DMHANGHOA set Soluongton = Soluongton + @SoLuong where MaHang = @MaHang
	else
		print 'Thong bao: ma hang chua co trong danh muc'
Go

exec SP_DMHANGHOA_SL 'HH7', 20;f