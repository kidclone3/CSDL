create table CONGVIEC
(
    MADA          int                                       not null,
    STT           int                                       not null,
    TEN_CONG_VIEC varchar(50) collate utf8mb3_vietnamese_ci not null,
    primary key (MADA, STT)
)
    charset = utf8mb4;

create table DEAN
(
    TENDA    varchar(15) collate utf8mb3_vietnamese_ci not null,
    MADA     int                                       not null
        primary key,
    DDIEM_DA varchar(15) collate utf8mb3_vietnamese_ci not null,
    PHONG    int                                       not null,
    constraint DEAN_ibfk_1
        foreign key (MADA) references CONGVIEC (MADA)
            on update cascade
)
    charset = utf8mb4;

create table DIADIEM_PHG
(
    MAPHG   int                                       not null,
    DIADIEM varchar(15) collate utf8mb3_vietnamese_ci not null,
    primary key (MAPHG, DIADIEM)
)
    charset = utf8mb4;

create table NHANVIEN
(
    HONV   varchar(15) collate utf8mb3_vietnamese_ci not null,
    TENLOT varchar(15) collate utf8mb3_vietnamese_ci not null,
    TENNV  varchar(15) collate utf8mb3_vietnamese_ci not null,
    MANV   char(9)                                   not null
        primary key,
    NGSINH date                                      not null,
    DCHI   varchar(30) collate utf8mb3_vietnamese_ci not null,
    PHAI   varchar(3) collate utf8mb3_vietnamese_ci  not null,
    LUONG  float                                     not null,
    MA_NQL text                                      null,
    PHG    int                                       not null
)
    charset = utf8mb4;

create table PHANCONG
(
    MA_NVIEN char(9)     not null,
    MADA     int         not null,
    STT      int         not null,
    THOIGIAN float(5, 1) null,
    primary key (MA_NVIEN, MADA, STT)
)
    charset = utf8mb4;

create table PHONGBAN
(
    TENPHG      varchar(15) collate utf8mb3_vietnamese_ci not null,
    MAPHG       int                                       not null
        primary key,
    TRPHG       tinytext                                  not null,
    NG_NHANCHUC date                                      null,
    constraint PHONGBAN_ibfk_1
        foreign key (MAPHG) references DIADIEM_PHG (MAPHG)
            on update cascade
)
    charset = utf8mb4;

create table THANNHAN
(
    MA_NVIEN char(9)                                   not null,
    TENTN    varchar(15) collate utf8mb3_vietnamese_ci not null,
    PHAI     tinytext collate utf8mb3_vietnamese_ci    not null,
    NGSINH   date                                      null,
    QUANHE   varchar(15) collate utf8mb3_vietnamese_ci not null,
    primary key (MA_NVIEN, TENTN)
)
    charset = utf8mb4;

insert into DeAnCongTy.CONGVIEC (MADA, STT, TEN_CONG_VIEC)
values  (1, 1, 'Thiet ke san pham X '),
        (1, 2, 'Thu nghiem san pham X '),
        (2, 1, 'San xuat san pham Y '),
        (2, 2, 'Quang cao san pham Y '),
        (3, 1, 'Khuyen mai san pham Z'),
        (10, 1, 'Tin hoc hoa nhan su tien luong'),
        (10, 2, 'Tin hoc hoa phong Kinh doanh'),
        (20, 1, 'Lap dat cap quang'),
        (30, 1, 'Dao tao nhan vien Marketing'),
        (30, 2, 'Dao tao chuyen vien vien thiet ke');

insert into DeAnCongTy.DEAN (TENDA, MADA, DDIEM_DA, PHONG)
values  ('San pham X ', 1, 'Vũng Tàu ', 5),
        ('San pham Y ', 2, 'Nha Trang ', 5),
        ('San pham Z ', 3, 'TP HCM', 5),
        ('Tin hoc hoa', 10, 'Hà Nội', 4),
        ('Cap quang', 20, 'TP HCM', 1),
        ('Dao tao', 30, 'Hà Nội', 4);
        
insert into DeAnCongTy.DIADIEM_PHG (MAPHG, DIADIEM)
values  (1, 'TP HCM'),
        (4, 'Hà Nội'),
        (5, 'NHA TRANG'),
        (5, 'TAU'),
        (5, 'TP HCM');

insert into DeAnCongTy.NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
values  ('Lê', 'Quỳnh', 'Như', '1', '1967-02-01', '291 Hồ Văn Huê, Tp HCM', 'Nữ', 43000, '6', 4),
        ('Trần', 'Thanh', 'Tâm', '3', '1957-05-04', '34 Mai Thị Lự, Tp HCM ', 'Nam', 25000, '5', 5),
        ('Nguyễn', 'Mạnh', 'Hùng', '4', '1967-03-04', '95 Bà Rịa, Vũng Tàu', 'Nam', 38000, '5', 5),
        ('Nguyễn', 'Thanh', 'Tùng', '5', '1962-08-20', '222 Nguyễn Văn Cừ, Tp HCM ', 'Nam', 40000, '6', 5),
        ('Phạm', 'Văn', 'Vinh', '6', '1965-01-01', '45 Trưng Vương, Hà Nội', 'Nữ', 55000, null, 1),
        ('Bùi', 'Ngọc', 'Hằng', '7', '1954-03-11', '332 Nguyễn Thái Học, Tp HCM ', 'Nam', 25000, '1', 4),
        ('Trần', 'Hồng', 'Quang', '8', '1967-09-01', '80 Lê Hồng Phong, Tp HCM', 'Nam', 25000, '1', 4),
        ('Đinh', 'Bá', 'Tiên', '9', '1960-02-11', '119 Cống Quỳnh, Tp HCM ', 'Nam', 30000, '5', 5);
        
insert into DeAnCongTy.PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
values  ('1', 20, 1, 15),
        ('1', 30, 1, 20),
        ('3', 1, 2, 20),
        ('3', 2, 1, 20),
        ('4', 3, 1, 40),
        ('5', 3, 1, 10),
        ('5', 10, 2, 10),
        ('5', 20, 1, 10),
        ('6', 20, 1, 30),
        ('7', 10, 2, 10),
        ('7', 30, 2, 30),
        ('8', 10, 1, 35),
        ('8', 30, 2, 5),
        ('9', 1, 1, 32),
        ('9', 2, 2, 8);
        
insert into DeAnCongTy.PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
values  ('Quản lý ', 1, '6', '1971-06-19'),
        ('Điều hành ', 4, '8', '1985-01-01'),
        ('Nghiên cứu ', 5, '5', '1978-05-22');
        
insert into DeAnCongTy.THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
values  ('001', 'Minh', 'Nam', '1932-02-29', 'Vợ chồng '),
        ('005', 'Khang', 'Nam', '1973-10-25', 'Con trai '),
        ('005', 'Phương', 'Nữ', '1948-05-03', 'Vợ chồng '),
        ('005', 'Trinh', 'Nữ', '1976-04-05', 'Con gái '),
        ('009', 'Châu', 'Nữ', '1978-12-30', 'Con gái '),
        ('009', 'Phương', 'Nữ', '1957-05-05', 'Vợ chồng '),
        ('009', 'Tiến', 'Nam', '1978-01-01', 'Con trai ');
