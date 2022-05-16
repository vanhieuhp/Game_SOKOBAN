create database itemManagement;
use itemManagement;

create table itemOptions(
itemCode char(10) not null primary key,
itemName char(50) not null,
quantityRemain int not null,
price int);

create table items(
saleCode char(10) not null primary key,
itemCode char(10) references itemOptions(itemCode),
saleDate datetime,
seller char(50),
quantitySale int not null,
intoMoney int)

insert into itemOptions values('1', 'keo', '15', '200');
insert into itemOptions values('2', 'banh', '7', '1200');
insert into itemOptions values('3', 'ao', '9', '2500');
insert into itemOptions values('4', 'quan', '11', '1200');
insert into itemOptions values('5', 'mu', '3', '2200');

insert into items values('s2', '1', '01/12/2022', 'Micheal', '3', '600');
insert into items values('s1', '3', '01/11/2022', 'Harry', '1', '2500');
insert into items values('s4', '2', '01/13/2022', 'Mine', '3', '3600');
insert into items values('s3', '5', '01/19/2022', 'Harry', '1', '2200');

select * from items;
delete from items;
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

create trigger trg_order on items after insert as
begin 
	update itemOptions
		set quantityRemain = quantityRemain - (
			select quantitySale from inserted 
			where inserted.itemCode = )



;
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