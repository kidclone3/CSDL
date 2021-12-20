# 1) Với mỗi sân bay(SBDEN), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó. Kêt
# quả được sắp xếp theo thứ tự tăng dần của số chuyến bay đến.
delimiter $$
drop procedure so_chuyenbay_sbden;
create procedure so_chuyenbay_sbden()
begin
    select SBDEN, count(MACB) as soluong
    from CHUYENBAY
    group by SBDEN
    order by soluong desc;
end $$
delimiter ;;

call so_chuyenbay_sbden();

# 2) Với mỗi sân bay đi(SBDI), cho biết số lượng sân bay xuất phát từ sân bay đó , sắp xếp
# theo thứ tự tăng dần của chuyến bay xuất phát

delimiter $$
drop procedure so_chuyenbay_sbdi;
create procedure so_chuyenbay_sbdi()
begin
    select SBDI, count(MACB) as soluong
    from CHUYENBAY
    group by SBDI
    order by soluong;
end $$
delimiter ;;

call so_chuyenbay_sbdi();

# 3) Với mỗi sân bay(SBDI), cho biết số lượng chuyến bay xuất phát theo từng ngày. Xuất ra
# mã sân bay, ngày và số lượng.
delimiter $$
drop procedure so_chuyenbaydi_theo_ngay;
create procedure so_chuyenbaydi_theo_ngay()
begin
    select SBDI, NGAYDI, count(MACB) as soluong
    from CHUYENBAY
             natural join LICHBAY
    group by SBDI, NGAYDI;
end $$
delimiter ;;

call so_chuyenbaydi_theo_ngay();

# 4) Với mỗi sân bay đến(SBDEN), cho biết số lượng chuyến bay hạ cánh theo từng ngày.
# Xuất ra mã sân bay đến, ngày và số lượng.

delimiter $$
drop procedure so_chuyenbayden_theo_ngay;
create procedure so_chuyenbayden_theo_ngay()
begin
    select SBDEN, NGAYDI, count(MACB) as soluong
    from CHUYENBAY
             natural join LICHBAY
    group by SBDEN, NGAYDI;
end $$
delimiter ;;

call so_chuyenbayden_theo_ngay();

# 5) Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi, cùng số lượng nhân viên không phải
# là phi công của chuyến bay đó
delimiter $$
create procedure cau5()
begin
    select qlchuyenbay.CHUYENBAY.MACB, NGAYDI, count(qlchuyenbay.NHANVIEN.MANV) as soluong
    from CHUYENBAY
             join qlchuyenbay.PHANCONG on PHANCONG.MACB = CHUYENBAY.MACB
             join qlchuyenbay.NHANVIEN on qlchuyenbay.PHANCONG.MANV = qlchuyenbay.NHANVIEN.MANV
    where LOAINV = false
    group by qlchuyenbay.CHUYENBAY.MACB;
end $$
delimiter ;

call cau5();

# 6) Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000
delimiter $$
create procedure cau6()
begin
    select count(*) as soluong
    from CHUYENBAY
             natural join LICHBAY
    where SBDI = "MIA"
      and NGAYDI = "2000-01-11";
end $$
delimiter ;

call cau6();

# 7) Với mỗi chuyến bay cho biết mã chuyến bay, ngày đi, số lượng nhân viên được phân
# công trên chuyến bay đó, sắp theo thứ tự giảm dần số lượng.
delimiter $$
create procedure cau7()
begin
    select MACB, NGAYDI, count(MANV) as soluong
    from CHUYENBAY
             natural join qlchuyenbay.PHANCONG
    group by MACB, NGAYDI
    order by soluong desc;
end $$
delimiter ;
call cau7();

# 8) Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã
# đặt chỗ của chuyến bay đó, sắp xếp theo thứ tự giảm dần của số lượng.

delimiter $$
create procedure cau8()
begin
    select MACB, NGAYDI, count(MAKH) as soluong
    from CHUYENBAY
             natural join DATCHO
    group by MACB, NGAYDI
    order by soluong desc;
end $$
delimiter ;
call cau8();

# 9) Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của phi hành đoàn. sắp
# tăng dần tổng lương

delimiter $$
create procedure cau9()
begin
    select MACB, NGAYDI, sum(LUONG) as tongchiphi
    from CHUYENBAY
             natural join qlchuyenbay.PHANCONG
             natural join qlchuyenbay.NHANVIEN
    group by MACB, NGAYDI
    order by tongchiphi;
end $$
delimiter ;

# 10) Cho biết lương trung bình của các nhân viên không là phi công
delimiter $$
create procedure cau10()
begin
    select avg(LUONG) from qlchuyenbay.NHANVIEN where LOAINV = false;
end $$
delimiter ;

# 11) Cho biết tên phi công đã từng lái máy bay 747.
delimiter $$
drop procedure if exists cau11;
drop view if exists mb747;
create view mb747
as
select MACB
from LICHBAY
where MALOAI like "%747%";
create procedure cau11()
begin
    select *
    from qlchuyenbay.NHANVIEN
             natural join qlchuyenbay.PHANCONG
    where MACB in (select * from mb747)
      and LOAINV = true;
end $$
delimiter ;
call cau11();

# 12) Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay đó hạ cánh
# xuống sân bay ORD/ Xuất mã loại máy bay và số lượng chuyến bay.

delimiter $$
create procedure cau12()
begin
    select MALOAI, count(MACB)
    from LICHBAY
             natural join CHUYENBAY
    where SBDEN = "ORD"
    group by MALOAI;
end $$
delimiter ;
call cau12();

# 13) Cho biết sân bay(SBDI) và số lượng chuyến bay có nhiều hơn hai chuyến bay xuất phát
# trong khoảng 10h đến 22h.

delimiter $$
create procedure cau13()
begin
    select SBDI, count(MACB) as soluong
    from CHUYENBAY
    where hour(GIODI) between 10 and 22
    group by SBDI
    having soluong >= 2;
end $$
delimiter ;

call cau13();

# 14) Cho biết tên phi công đã được phân công vào ít nhất 2 chuyến bay trong cùng một ngày.

delimiter $$
create procedure cau14()
begin
    select TEN
    from qlchuyenbay.NHANVIEN
             natural join qlchuyenbay.PHANCONG
    where LOAINV = true
    group by MANV, day(NGAYDI)
    having count(day(NGAYDI)) > 1;
end $$
delimiter ;

call cau14();

# 15) Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất

delimiter $$
drop procedure if exists cau15;
create procedure cau15()
begin
    select MANV, count(MACB) as totalCount
    from qlchuyenbay.PHANCONG
    group by MANV
    having totalCount = (
        select count(MACB) as soluong
        from qlchuyenbay.PHANCONG
        group by MANV
        order by soluong desc
        limit 1
    );
end $$
delimiter ;
call cau15();

# 16) Cho biết sân bay(SBDEN) và số lượng chuyến bay của sân bay có ít chuyến bay đáp
# xuống nhất.
delimiter $$
create procedure cau16()
begin
    select SBDEN, count(MACB) as totalCount
    from CHUYENBAY
    group by SBDEN
    having totalCount = (
        select count(MACB)
        from CHUYENBAY
        group by SBDEN
        limit 1
    );
end $$
delimiter ;
call cau16();

# 17) Cho biết sân bay(SBDI) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất
# phát nhất

delimiter $$
create procedure cau17()
begin
    select SBDI, count(MACB) as totalCount
    from CHUYENBAY
    group by SBDI
    having totalCount = (
        select count(MACB)
        from CHUYENBAY
        group by SBDI
        order by count(MACB) desc
        limit 1
    );
end $$
delimiter ;
call cau17();

# 18) Cho biết tên, địa chỉ, điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất

delimiter $$
create procedure cau18()
begin
    select TEN, DCHI, DTHOAI
    from KHACHHANG
             natural join DATCHO
    group by MAKH
    having count(*) >= all (
        select count(*)
        from DATCHO
        group by makh
    );
end $$
delimiter ;

call cau18();

# 19) Cho biết mã số, tên, lương của các phi công có khả năng lái nhiều máy bay nhất.
delimiter $$
create procedure cau19()
begin
    select MANV, TEN, LUONG
    from qlchuyenbay.NHANVIEN
             natural join KHANANG
    group by MANV
    having count(*) >= all (
        select count(*)
        from KHANANG
        group by MANV
    );
end $$
delimiter ;
call cau19();

# 20) Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001 được phân lái trên 2
# lần
delimiter $$
create procedure cau20()
begin
    set @number_flies = 0;
    select count(*)
    into @number_flies
    from MAYBAY
             natural join LICHBAY
             natural join qlchuyenbay.PHANCONG
    where MANV = 1001;

    if @number_flies >= 2
    then
        select *
        from MAYBAY
        where SOHIEU in (
            select LICHBAY.SOHIEU
            from MAYBAY
                     natural join LICHBAY
                     natural join qlchuyenbay.PHANCONG
            where MANV = 1001
        );
    end
    if;
end $$
delimiter ;

call cau20(); 
