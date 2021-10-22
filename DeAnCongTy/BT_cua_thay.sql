# 1
select * from NHANVIEN where PHG = 4;

# 2
select * from NHANVIEN where LUONG >= 30000;

# 3
select * from NHANVIEN where (LUONG >= 25000 and PHG = 4) or (LUONG >= 30000 and PHG = 5);

# 4
select * from NHANVIEN where DCHI like "%Tp HCM";

# 5
select HONV, TENLOT, TENNV from NHANVIEN where HONV like "N%";

# 6
select NGSINH, DCHI from NHANVIEN where HONV = "Đinh" and TENLOT = "Bá" and TENNV = "Tiến";

# 7
select * from NHANVIEN where year(NGSINH) >= 1960 and year(NGSINH) <= 1965;

# 8
select HONV, TENLOT, TENNV, year(NGSINH) as "NAMSINH" from NHANVIEN;

# 9
select HONV, TENLOT, TENNV, year(now()) - year(NGSINH) as TUOI from NHANVIEN;
