# 1.
select * from NHANVIEN where month(NGSINH) > 8;

# 2.
select * from NHANVIEN where PHG = 4 and PHAI = "Nam";

# 3.
select * from NHANVIEN where DCHI like "%Tp HCM" and LUONG >= 40000;

# 4.
select count(MADA) as "So_Luong_Cong_Viec" from CONGVIEC where MADA = 1 or MADA = 2;

# 5.
select TENPHG, PHONGBAN.MAPHG, DIADIEM from PHONGBAN, DIADIEM_PHG where PHONGBAN.MAPHG = DIADIEM_PHG.MAPHG and DIADIEM like "%Tp HCM";

# 6.
select MA_NVIEN, MADA, STT from PHANCONG where MA_NVIEN = "005";

# 7.
select TENTN, year(now()) - year(NGSINH) as Tuoi from THANNHAN where MA_NVIEN = "005";

# 8.
select TENDA from DEAN where DDIEM_DA like "Hà Nội";
