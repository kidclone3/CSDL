create database QuanLy2;
use QuanLy2;
create table sinhvien(
    HOSV varchar(15) not null,
    TEN varchar(15) not null,
    MASV char(9) not null,
    NGAYSINH date not null,
    PHAI char(3) not null,
    MAKHOA char(9) not null,
    primary key (MASV)
);
create table khoa(
    MAKHOA char(9) not null,
    TENKHOA varchar(50) not null,
    primary key (MAKHOA)
);

create table monhoc(
    STT int not null,
    TENMH varchar(50) not null,
    MAMH char(9) not null,
    SOTIET int not null,
    primary key (MAMH),
    index (STT)
);
create table ketqua(
    MASV char(9) not null,
    MAMH char(9) not null ,
    LANTHI int not null,
    DIEM int not null,
    primary key (MASV, MAMH, DIEM)
);

insert into monhoc (STT, TENMH, MAMH, SOTIET)
values (1, 'Anh van', 'AV', 45), (2, 'Co so du lieu', 'CSDL', 45),
(3, 'Ki thuat lap trinh', 'KTLT', 60), (4, 'Ke toan tai chinh', 'KTTC', 45),
(5, 'Toan cao cap', 'TCC', 60), (6, 'Tri tue nhan tao', 'TTNT', 50),
(7, 'Tin hoc van phong', 'THVP', 30);
insert into khoa (makhoa, tenkhoa)
values ('AVAN', 'Khoa anh van'), ('CNTT', 'Cong nghe thong tin'), ('DTVT', 'Khoa dien tu vien thong'), ('QTKD', 'KHoa quan tri kinh doanh');

insert into ketqua (MASV, MAMH, LANTHI, DIEM)
values ('S001', 'CSDL', 1, 4), ('S001', 'TCC', 1, 6), ('S002', 'CSDL', 1, 3), ('S002', 'CSDL', 2, 6),
('S003', 'KTTC', 1, 5), ('S004', 'AV', 1, 8), ('S004', 'THVP', 1, 4), ('S004', 'THVP', 2, 8),
('S006', 'TCC', 1, 5), ('S007', 'AV', 1, 2), ('S007', 'AV', 2, 9), ('S007', 'KTLT', 1, 6), ('S008', 'AV', 1, 7);

insert into sinhvien (HOSV, TEN, MASV, NGAYSINH, PHAI, MAKHOA)
values  ('Tran Minh', 'Son', 'S001', '1985-05-01', 'NAM', 'CNTT'),
        ('Nguyen Quoc', 'Bao', 'S002', '1986-05-16', 'NAM', 'CNTT'),
        ('Phan Anh', 'Tung', 'S003', '1983-12-20', 'NAM', 'QTKD'),
        ('Bui thi Anh', 'Thu', 'S004', '1985-02-01', 'Nu', 'QTKD'),
        ('Nguyen Thanh', 'Son', 'S005', '1987-07-03', 'Nam', 'DTVT'),
        ('Nguyen Thi', 'Lam', 'S006', '1984-11-11', 'Nu', 'CNTT'),
        ('Phan Thi', 'Ha', 'S007', '1988-07-03', 'Nu', 'CNTT'),
        ('Tran The', 'Dung', 'S008', '1985-10-21', 'Nam', 'CNTT');

# alter table ketqua drop foreign key ketqua_ibfk_1;
alter table ketqua add foreign key (MASV) references sinhvien(MASV) on delete no action on update cascade;
alter table ketqua add foreign key (MAMH) references monhoc(MAMH) on delete no action on update cascade;
alter table sinhvien add foreign key (MAKHOA) references khoa(MAKHOA) on delete no action on update no action;

# drop database QuanLy2;