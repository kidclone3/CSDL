# Danh sách những nhân viên (HONV, TENLOT, TENNV) làm việc trong mọi đề án do phòng “Nghiên cứu” phụ trách. (chú ý: Làm theo ba cách)
# Cách 1 (NOT EXISTS, NOT EXISTS): 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (select * from dean join phongban on dean.phong = phongban.maphg where phongban.tenphg = "Nghiên cứu" and not exists (select * from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));

# Cách 2 (NOT EXISTS, NOT IN)
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (select * from dean join phongban on dean.phong = phongban.maphg where phongban.tenphg = "Nghiên cứu" and dean.mada not in (select phancong.mada from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));

# Cách 3 (GROUP BY, HAVING): 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where nhanvien.manv in (select phancong.ma_nvien from phancong join dean on phancong.mada = dean.mada join phongban on dean.phong = phongban.maphg where phongban.tenphg = "Nghiên cứu" group by phancong.ma_nvien having count(distinct phancong.mada) = (select count(mada) from dean join phongban on dean.phong = phongban.maphg where phongban.tenphg = "Nghiên cứu"));

# Danh sách những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả đề án do phòng số 4 chủ trì.
# Cách 1 (NOT EXISTS, NOT EXISTS): 

select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (select * from dean where dean.PHONG= 4 and not exists (select * from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));

# Cách 2 (NOT EXISTS, NOT IN) 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (select * from dean where dean.PHONG= 4 and dean.mada not in (select phancong.mada from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));

# Cách 3 (GROUP BY, HAVING): 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten 
from nhanvien where nhanvien.manv in (
    select phancong.ma_nvien from phancong join dean on phancong.mada = dean.mada where dean.PHONG= 4  
    group by phancong.ma_nvien having count(distinct phancong.mada) = (select count(mada) from dean where dean.PHONG= 4));

# Tìm những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả đề án mà nhân viên ‘Đinh Bá Tiến’ làm việc.
# Cách 1 (NOT EXISTS, NOT EXISTS): 

select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select dean.MADA from dean JOIN phancong on phancong.MADA= dean.MADA JOIN nhanvien nv on phancong.MA_NVIEN = nv.MANV where nv.HONV ="Đinh" and nv.TENLOT= "Bá" and nv.TENNV = "Tiên" 
    and not exists (
        select phancong.MADA from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));
#Cách 2 (NOT EXISTS, NOT IN) 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select dean.MADA from dean JOIN phancong on phancong.MADA= dean.MADA JOIN nhanvien nv on phancong.MA_NVIEN = nv.MANV where nv.HONV ="Đinh" and nv.TENLOT= "Bá" and nv.TENNV = "Tiên" 
    and phancong.MADA not in (
        select phancong.MADA from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));
# Cho biết những nhân viên được phân công cho tất cả các công việc trong đề án ‘Sản phẩm X’
#Cách 1 (NOT EXISTS, NOT EXISTS): 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select congviec.MADA, congviec.STT from dean JOIN congviec on congviec.MADA= dean.MADA where dean.TENDA= "San pham X"
    and not exists (
        select phancong.MADA from phancong where phancong.mada = congviec.mada  and phancong.STT = congviec.STT and phancong.ma_nvien = nhanvien.manv));
# Cách 2 (NOT EXISTS, NOT IN) 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select congviec.MADA, congviec.STT from dean JOIN congviec on congviec.MADA= dean.MADA where dean.TENDA= "Cap Quang"
    and congviec.MADA not in (
        select phancong.MADA from phancong where phancong.mada = congviec.mada  and phancong.STT = congviec.STT and phancong.ma_nvien = nhanvien.manv));
# Cách 3(GROUP BY, HAVING):
SELECT  concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien WHERE manv in (SELECT ma_nvien from phancong WHERE phancong.mada = 
(SELECT dean.mada from dean WHERE dean.tenda = "San pham X") GROUP BY ma_nvien HAVING COUNT(stt) = 
(SELECT count(*) from congviec WHERE congviec.mada in(SELECT dean.mada from dean WHERE dean.tenda = "San pham X")));
 
#Cho biết danh sách nhân viên tham gia vào tất cả các đề án ở TP HCM
# Cách 1 (NOT EXISTS, NOT EXISTS): 
select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select MADA from dean WHERE DDIEM_DA LIKE "%TP HCM"
    and not exists (
        select phancong.MADA from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));
#Cách 2 (NOT EXISTS, NOT IN) 

select concat(nhanvien.honv, " ", nhanvien.tenlot, " ", nhanvien.tennv) as hoten from nhanvien where not exists (
    select MADA from dean WHERE DDIEM_DA LIKE "%TP HCM"
    and dean.MADA not in (
        select phancong.MADA from phancong where phancong.mada = dean.mada and phancong.ma_nvien = nhanvien.manv));

#Cho biết phòng ban chủ trì tất cả các đề án ở TP HCM.
#Cách 1 (NOT EXISTS, NOT EXISTS): 
select tenphg from phongban where not exists (
    select MADA from dean WHERE DDIEM_DA LIKE "%TP HCM"
    and not exists (
        SELECT dean.MADA where phongban.MAPHG= dean.PHONG));
# Cách 2 (NOT EXISTS, NOT IN)
select tenphg from phongban where not exists (
    select MADA from dean WHERE DDIEM_DA LIKE "%TP HCM"
    and dean.MADA not in (
        SELECT dean.MADA where phongban.MAPHG= dean.PHONG));
