# 1)
alter table phu_huynh add foreign key (masv) references sinh_vien(masv);
alter table lop add foreign key (maloptruong) references sinh_vien(masv);
alter table sinh_vien add foreign key (malop) references lop(malop);
alter table ket_qua add foreign key (masv) references sinh_vien(masv);
alter table ket_qua add foreign key (mamonhoc) references mon_hoc(mamonhoc);

# 2)
select * from sinh_vien where noisinh like "%Quảng Ninh%";

# 3)
select * from sinh_vien where noisinh like "%Hà Nội%" and phai = "Nữ";

# 4)
select hotensv from sinh_vien natural join ket_qua natural join mon_hoc where tenmonhoc like "%Mạng máy tính%";

# 5)
select count(masv) as sosv from sinh_vien where hotensv like "Ngô%";

# 6)
select masv, hotensv, count(mamonhoc) as soluong from sinh_vien natural join ket_qua group by masv;

# 7)
select malop, tenlop, count(masv) as siso from lop natural join sinh_vien
group by malop;

# 8)
select distinct sinh_vien.masv, hotensv
from sinh_vien
         join phu_huynh on phu_huynh.masv = sinh_vien.masv
where year(phu_huynh.ngaysinh) between 1980 and 1982;

# 9)
select sinh_vien.masv, count(hotenphuhuynh) as soph from sinh_vien
left join phu_huynh ph on sinh_vien.masv = ph.masv
group by sinh_vien.masv

# 10)
select masv, hotensv from sinh_vien natural join ket_qua
group by masv
having count(mamonhoc) = (select count(*) from mon_hoc);

# 11)
select masv, hotensv, diem
from ket_qua
         natural join mon_hoc
         natural join sinh_vien
where tenmonhoc like "%Tin cơ sở%"
  and diem = (select max(diem)
              from ket_qua
                       natural join mon_hoc
              where tenmonhoc like "%Tin cơ sở%") 
