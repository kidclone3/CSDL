# create database QuanLySinhVien character set utf8 collate utf8_vietnamese_ci;;
# use QuanLySinhVien;
# drop table khoa;
# create table KHOA(
#     MAKHOA char(4) not null primary key,
#     TENKHOA varchar(30) not null,
#     NAMTHANHLAP int not null
# );

# create table SVIEN(
#     TEN varchar(30) not null,
#     MASV int not null primary key,
#     NAM tinyint not null,
#     MAKH char(4) not null,
#     check ( NAM >= 1 and NAM <=4 )
# );

# create table MHOC(
#     TENMH varchar(30) not null,
#     MAMH char(8) not null primary key,
#     TINCHI int not null,
#     MAKH char(4) not null
# );

# create table DKIEN(
#     MAMH char(8) not null,
#     MAMH_TRUOC char(8) not null,
#     primary key (MAMH, MAMH_TRUOC)
# );
# drop table HPHAN;
# create table HPHAN(
#     MAHP int not null primary key ,
#     MAMH char(8) not null,
#     HOCKY tinyint not null,
#     NAM int not null,
#     GV varchar(30) not null
# );

# create table KQUA(
#     MASV int not null,
#     MAHP int not null,
#     DIEM float not null,
#     primary key (MASV, MAHP),
#     check ( diem >= 0 and diem <= 10 )
# );

# insert into SVIEN (TEN, MASV, NAM, MAKH)
# values ('Sơn', 17, 1, 'CNTT'), ('Bảo', 8, 2, 'CNTT'), ('Trang', 5, 3, 'TOAN');

# insert into DKIEN (MAMH, MAMH_TRUOC)
# values ('COSC3380', 'COSC3320'), ('COSC3380', 'MATH2410'), ('COSC3320', 'COSC1310');

# insert into KHOA (MAKHOA, TENKHOA, NAMTHANHLAP)
# values ('CNTT', 'Công Nghệ Thông tin', 1995), ('VL', 'Vật lý', 1976), ('TOAN', 'Toán', 1976);

# insert into MHOC (TENMH, MAMH, TINCHI, MAKH)
# values ('Nhập môn Tin học', 'COSC1310', 4, 'CNTT'),
# ('Cấu trúc dữ liệu', 'COSC3320', 4, 'CNTT'),
# ('Toán rời rạc', 'MATH2410', 3, 'TOAN'),
# ('Cơ sở dữ liệu', 'COSC3380', 3, 'CNTT'),
# ('Vật lý đại cương', 'PHYS3332', 3, 'VL');

# insert into HPHAN (MAHP, MAMH, HOCKY, NAM, GV)
# values (85, 'MATH2410', 1, 1996, 'Kim'),
# (92, 'COSC1310', 1, 1996, 'An'),
# (102, 'COSC3320', 2, 1997, 'Nhiên'),
# (112, 'MATH2410', 1, 1997, 'Vân'),
# (119, 'COSC1310', 1, 1997, 'An'),
# (135, 'COSC3380', 1, 1997, 'Sơn');

# insert into KQUA (MASV, MAHP, DIEM)
# values (17, 102, 8),
# (17, 119, 6),
# (5, 85, 10),
# (8, 92, 10),
# (8, 102, 8),
# (8, 135, 10);

alter table SVIEN add foreign key (MAKH) references KHOA(MAKHOA) on update no action on delete cascade;
alter table MHOC add foreign key (MAKH) references KHOA(MAKHOA) on update no action on delete cascade;
alter table DKIEN add foreign key (MAMH) references MHOC(MAMH) on update no action on delete cascade;
# DKIEN.MAMH_TRUOC can be space, but not null (primary key)
alter table KQUA add (
    foreign key (MASV) references SVIEN(MASV) on update no action on delete cascade,
    foreign key (MAHP) references HPHAN(MAHP) on update no action on delete cascade
    );

 
