USE QLhocphi 

----NHÂN VIÊN----
GO 

alter PROC insert_NV 
            @manv varchar(10) ,
			@tenNV NVARCHAR(50) , 
			@Nsinh date , 
			@GT BIT , 
			@CMND varchar(50) , 
			@makhoa varchar(10), 
			@soDT varchar(10) 
			AS BEGIN 
			   INSERT INTO dbo.NhanVien(MaNV, TenNV, NgaySinh, GioiTinh, MaKhoa, SoDT) 
			   VALUES (@manv , @tenNV , @Nsinh , @GT , @makhoa, @soDT)
			END 

GO 

EXEC dbo.insert_NV @manv = '13',            -- varchar(10)
                   @tenNV = N'Nguyễn Thị Kiều',          -- nvarchar(50)
                   @Nsinh = '1994-11-01', -- date
                   @GT = 0,            -- bit
                   @CMND = '12623413123',            -- varchar(50)
                   @makhoa = 2            -- int

-- 2.tạo thủ tục sửa thông tin của nhân viên 
 GO 

create PROC update_NV 
             @manv varchar(10) , 
			 @tenNV NVARCHAR(50) , 
			 @Nsinh date , 
			 @GT BIT , 
			 @CMND varchar(50), 
			 @SoDT VARCHAR(10)
			 AS BEGIN 
			    UPDATE dbo.NhanVien SET 
					TenNV = @tenNV , 
					NgaySinh = @Nsinh , 
					GioiTinh = @GT , 
					CMND = @CMND, 
					SoDT = @SoDT 
				WHERE MaNV = @manv
			 END 

GO 
 EXEC dbo.update_NV  @manv = '13',            -- varchar(10)
                    @tenNV = N'Nguyễn Thị Kiều',          -- nvarchar(50)
                    @Nsinh = '1994-11-01', -- date
                    @GT =0,            -- bit
                    @CMND = '234236123',            -- varchar(50)
                    @makhoa = 1            -- int

					
-- 3.xóa nhân viên có tên được truyền vào 
GO 

create PROC DELETE_NV 
            @tenNV VARCHAR(10) 
			AS BEGIN 
			   DELETE FROM dbo.NhanVien WHERE maNV  = @tenNV
			END 
GO 

EXEC dbo.DELETE_NV @tenNV = N'nGUYỄN THỊ KIỀU' -- nvarchar(50)

GO 

-- 4.Tạo thủ tục đưa ra danh sách thông tin của nhân viên khoa có tên là tham số truyền vào

alter PROC SELECT_NV
		@maKhoa VARCHAR(10)
		AS BEGIN
			SELECT MaNV as N'Mã Nhân Viên' , TenNV as N'Tên Nhân Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', CMND, SoDT as N'Số Điện Thoại'
			FROM Nhanvien 
			WHERE MaKhoa = @maKhoa
		END

EXEC dbo.SELECT_NV

go
alter PROC Search_NV_MaNV
		@maKhoa VARCHAR(10), @maNV VARCHAR(10)
		AS BEGIN
			SELECT MaNV as N'Mã Nhân Viên' , TenNV as N'Tên Nhân Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', CMND, SoDT as N'Số Điện Thoại'
			FROM Nhanvien 
			WHERE MaKhoa = @maKhoa AND MaNV = @maNV
		END
go
alter PROC Search_NV_TenNV_NgaySinh
		@maKhoa VARCHAR(10), @tenNV NVARCHAR(20), @ngaySinh DATE
		AS BEGIN
			SELECT MaNV as N'Mã Nhân Viên' , TenNV as N'Tên Nhân Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', CMND , SoDT as N'Số Điện Thoại'
			FROM Nhanvien 
			WHERE MaKhoa = @maKhoa AND TenNV = @tenNV AND NgaySinh = @ngaySinh
		END


create PROC Select_NV_Report
		@maKhoa VARCHAR(10)
		AS BEGIN
			SELECT MaNV, TenNV , case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'GioiTinh', NgaySinh , SoDT, TenKhoa
			FROM Nhanvien INNER JOIN Khoa ON NhanVien.MaKhoa = Khoa.MaKhoa
			WHERE Nhanvien.MaKhoa = @maKhoa 
		END

create PROC DS_NV 
       @TenK NVARCHAR(50) 
	   AS BEGIN 
	      SELECT dbo.NhanVien.MaNV , 
			  dbo.NhanVien.TenNV , 
			  dbo.NhanVien.GioiTinh, 
			  dbo.NhanVien.NgaySinh , 
			  dbo.Khoa.TenKhoa 
		  FROM dbo.NhanVien INNER JOIN dbo.Khoa 
		  ON Khoa.MaKhoa = NhanVien.MaKhoa 
		  WHERE UPPER(dbo.Khoa.TenKhoa) = UPPER(@TenK)
	   END

GO 

EXEC dbo.DS_NV  @TenK = N'Cong nghe thong tin' -- nvarchar(50)

GO

-- 5.Tạo thủ tục đưa ra tổng tiền thu của nhân viên có tên là tham số truyền vào 

----NHÂN VIÊN----


----SinhVien----
GO 

-- 6.Thủ tục thêm dữ liệu vào bảng sinh viên 
create PROC INSERT_SV 
            @maSV VARCHAR(10) , @TenSV NVARCHAR(50) , @GT bit , @Ns date , @Mak VARCHAR(10), @Lop VARCHAR(10), @soDT VARCHAR(10)
			AS BEGIN 
			    INSERT INTO dbo.SinhVien VALUES (@maSV , @TenSV , @GT , @Ns , @Mak, @Lop, @soDT)
			END 

GO 

EXEC INSERT_SV  @maSV = '14',          -- int
                   @TenSV = N'Nguyễn An',       -- nvarchar(50)
                   @GT = 1,         -- bit
                   @Ns = '2003-11-02', -- date
                   @Mak = '2',            -- int
				   @Lop = '2110B02'

GO 

-- 7. thủ tục cập nhật sinh viên có mã là tham số truyền vào

create PROC  UPDATE_SV 
            @maSV VARCHAR(10), @TenSV NVARCHAR(50), @GT bit, @Ns date, @Lop VARCHAR(10), @soDT VARCHAR(10) 
			AS BEGIN 
			   UPDATE dbo.SinhVien SET TenSV = @TenSV , GioiTinh = @GT , NgaySinh = @Ns, Lop = @Lop, SoDT = @soDT
			   WHERE MaSV = @maSV
			END 

GO 

EXEC dbo.UPDATE_SV @maSV = 1,          -- int
                   @TenSV = N'Nguyễn Kim Thiên An',       -- nvarchar(50)
                   @GT = 1,         -- bit
                   @Ns = '2002-11-01', -- date
                   @Lop = '2110B02'         -- int
				   
GO 

-- 8. thủ tục xóa sinh viên có tên là tham số truyền vào 

create PROC delete_SV 
            @ma NVARCHAR(50)
			AS BEGIN
				DELETE FROM dbo.SinhVien WHERE MaSV = @ma
		    END

GO 

EXEC dbo.delete_SV @ten = N'Nguyễn Kim tHIỆN' -- nvarchar(50)

GO 

-- 9. Thủ tục đưa ra danh sách thông tin sinh viên khoa CNTT

create PROC SELECT_SV
		  @maKhoa VARCHAR(10)
		  AS BEGIN
              SELECT MaSV as N'Mã Sinh Viên' , TenSV as N'Tên Sinh Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh',SoDT as N'Số ĐT' , Lop as N'Lớp'
			  FROM SinhVien
			  WHERE MaKhoa = @maKhoa
          END
EXEC SELECT_SV @maKhoa = '1' -- nvarchar(50)
GO
create PROC SELECT_SV_REPORT
		  @maKhoa VARCHAR(10), @Lop VARCHAR(10)
		  AS BEGIN
              SELECT MaSV, TenSV , case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'GioiTinh', NgaySinh,SoDT, Lop, TenKhoa
			  FROM SinhVien INNER JOIN Khoa ON SinhVien.MaKhoa = Khoa.MaKhoa
			  WHERE SinhVien.MaKhoa = @maKhoa AND Lop = @Lop
          END

GO
create PROC Search_SV_MaSV
		  @maKhoa VARCHAR(10), @maSV VARCHAR(10)
		  AS BEGIN
              SELECT MaSV as N'Mã Sinh Viên' , TenSV as N'Tên Sinh Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', Lop as N'Lớp'
			  FROM SinhVien
			  WHERE MaKhoa = @maKhoa AND MaSV = @maSV
          END
GO

GO
create PROC Search_SV_TenSV
		  @maKhoa VARCHAR(10), @tenSV NVARCHAR(50)
		  AS BEGIN
              SELECT MaSV as N'Mã Sinh Viên' , TenSV as N'Tên Sinh Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', Lop as N'Lớp'
			  FROM SinhVien
			  WHERE MaKhoa = @maKhoa AND TenSV = @tenSV
          END

GO
create PROC Search_SV_Lop
		  @maKhoa VARCHAR(10), @Lop VARCHAR(10)
		  AS BEGIN
              SELECT MaSV as N'Mã Sinh Viên' , TenSV as N'Tên Sinh Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', Lop as N'Lớp'
			  FROM SinhVien
			  WHERE MaKhoa = @maKhoa AND Lop = @Lop
          END

GO
create PROC Search_SV_TenSV_Lop
		  @maKhoa VARCHAR(10), @Lop VARCHAR(10),  @tenSV NVARCHAR(50)
		  AS BEGIN
              SELECT MaSV as N'Mã Sinh Viên' , TenSV as N'Tên Sinh Viên', case GioiTinh 
									when 0 then N'Nữ'
									else 'Nam'
									end as N'Giới tính', NgaySinh as N'Ngày Sinh', Lop as N'Lớp'
			  FROM SinhVien
			  WHERE MaKhoa = @maKhoa AND Lop = @Lop AND TenSV =  @tenSV
          END

GO 

-- 10. Thủ tục cho biết số học phí của sinh viên 

create PROC proc_HocPhi_SV 
            @Ten NVARCHAR(50) 
			AS BEGIN
			       SELECT SUM(Sotin * Sotien1tin * (1-MienGiam)) AS N'Tổng tiền'  FROM dbo.SinhVien INNER JOIN dbo.HoaDon ON HoaDon.MaSV = SinhVien.MaSV  INNER JOIN  dbo.ChiTietHoaDon ON ChiTietHoaDon.MaHD = HoaDon.MaHD INNER JOIN dbo.BoMon ON BoMon.MaBM = ChiTietHoaDon.MaBM
				                 GROUP BY SinhVien.MaSV , dbo.SinhVien.TenSV HAVING UPPER(TenSV) = UPPER(@Ten)
			   END
GO 

EXEC dbo.proc_HocPhi_SV @Ten = N'nguyễn kim thiện' -- nvarchar(50)

----SINH VIÊN----


----HÓA DƠN----
GO 

-- 16. thủ tục thêm hóa đơn 
create PROC check_MaSV
		@maSV VARCHAR(10), @maKhoa VARCHAR(10)
		AS BEGIN
	        SELECT MaSV
			FROM SinhVien
			WHERE MaKhoa = @maKhoa AND MaSV = @maSV					
	    END


create PROC insert_HD 
		@maHD varchar(10), @MaSV varchar(10), @maNV varchar(10) , @ngaylap datetime, @hocKy INT, @namHoc VARCHAR(9), @trangThai BIT , @miengiam float 
		AS BEGIN
	        INSERT INTO HoaDon(MaHD , MaSV , MaNV , NgayLap , HocKy, NamHoc, TrangThai, MienGiam) VALUES (@maHD , @MaSV , @maNV , @ngaylap , @hocKy, @namHoc, @trangThai , @miengiam)
	    END
GO 

EXEC dbo.proc_insert_HD  @maHD = '11',                       -- varchar(10)
                        @MaSV = 1,                        -- int
                        @maNV = 'NV1',                       -- varchar(10)
                        @ngaylap = '2022-11-01 08:19:42', -- datetime
                        @ngaythu = '2022-11-01 08:19:42', -- datetime
                        @miengiam = 0.0                   -- float


go
create PROC Select_HD
		@maKhoa VARCHAR(10)
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa						
	    END



go

--error here
create PROC Select_HD_LopNamHocKy
		@Lop VARCHAR(10), @NamHoc VARCHAR(9), @Ky varchar(9), @Khoa NVARCHAR(50)
		AS BEGIN
	        SELECT MaHD, HoaDon.MaSV , TenSV, NgayLap, HocKy,
				   case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'TrangThai'
				   ,TongSoTin, TongSoTien, MienGiam, ThanhTien, SinhVien.Lop, Khoa.TenKhoa, NamHoc
						 FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
									 INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
									 INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
									 WHERE Khoa.TenKhoa = @Khoa AND NamHoc = @NamHoc 
																AND SinhVien.Lop = @Lop 
																AND HoaDon.HocKy = @Ky
																
	    END

		EXEC Select_HD_LopNamHocKy  @Lop = '2110A04', @NamHoc = '2022-2023', @Ky = 1, @Khoa = N'Công nghệ thông tin'

GO 
create PROC Select_HD_LopNamHocKy_TrangThai
		@Lop VARCHAR(10), @NamHoc VARCHAR(9), @Ky Int, @Khoa NVARCHAR(50), @TrangThai BIT
		AS BEGIN
	        SELECT MaHD, HoaDon.MaSV, TenSV, NgayLap, HocKy, case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'TrangThai'
				   ,TongSoTin, TongSoTien, MienGiam, ThanhTien, SinhVien.Lop, Khoa.TenKhoa, NamHoc
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.TenKhoa = @Khoa AND NamHoc = @NamHoc 
									   AND SinhVien.Lop = @Lop 
									   AND HoaDon.HocKy = @Ky
									   AND HoaDon.TrangThai = @TrangThai;
	    END	
GO 
create PROC Search_HD_MaHD
		@maKhoa VARCHAR(10), @maHD VARCHAR(10)
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa	AND MaHD = @maHD					
	    END
GO 
create PROC Search_HD_MaSV
		@maKhoa VARCHAR(10), @maSV VARCHAR(10)
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa	AND HoaDon.MaSV = @maSV					
	    END
GO 
create PROC Search_HD_MaSV_TrangThai
		@maKhoa VARCHAR(10), @maSV VARCHAR(10), @trangThai BIT
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa	AND HoaDon.MaSV = @maSV AND TrangThai = @trangThai				
	    END
GO
create PROC Search_HD_MaSV_HocKy_NamHoc
		@maKhoa VARCHAR(10), @maSV VARCHAR(10), @NamHoc VARCHAR(9), @hocKy Int
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa	AND HoaDon.MaSV = @maSV AND NamHoc = @NamHoc AND HocKy = @hocKy		
	    END

GO
create PROC Search_HD_MaSV_HocKy_NamHoc_TrangThai
		@maKhoa VARCHAR(10), @maSV VARCHAR(10), @trangThai BIT, @NamHoc VARCHAR(9), @hocKy Int
		AS BEGIN
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', NgayLap as N'Ngày Lập', HocKy as N'Học Kỳ', NamHoc as N'Năm Học'
				   , case TrangThai 
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'Trạng Thái'
				   ,TongSoTin as N'Tổng Tín', TongSoTien as N'Tổng Số Tiền', MienGiam as N'Miễn Giảm',
				   ThanhTien as N'Thành Tiền'
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE Khoa.MaKhoa = @maKhoa	AND HoaDon.MaSV = @maSV AND NamHoc = @NamHoc 
										AND HocKy = @hocKy AND TrangThai = @trangThai					
	    END

GO
create PROC delete_HD
		@maHD varchar(10), @MaSV varchar(10), @maNV varchar(10) , @ngaylap datetime, @hocKy INT, @namHoc VARCHAR(9), @trangThai BIT , @miengiam float 
		AS BEGIN
              DELETE FROM HoaDon 			  
			  WHERE MaHD = @maHD 
		END
Go

create PROC check_HD
		@maHD varchar(10), @MaKhoa varchar(10)
		AS BEGIN
              SELECT MaHD 
			  FROM HoaDon INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV			  
			  WHERE MaHD = @maHD AND MaKhoa = @MaKhoa
		END
GO 

-- 17. thủ tục update hóa đơn 

create PROC update_HD
       @maHD varchar(10), @MaSV varchar(10), @maNV varchar(10) , @ngaylap datetime, @hocKy INT, @namHoc VARCHAR(9), @trangThai BIT , @miengiam float 
	   AS BEGIN
              UPDATE dbo.HoaDon 
			  SET MaHD = @maHD, MaSV = @MaSV , MaNV = @maNV , NgayLap = @ngaylap , HocKy = @hocKy,NamHoc = @namHoc, TrangThai=@trangThai , MienGiam = @miengiam 
			  WHERE MaHD = @maHD 
       END
DROP PROC proc_update_HD
GO 

EXEC dbo.proc_update_HD @maHD = 'HD1',                       -- varchar(10)
                        @MaSV = 1,                        -- int
                        @maNV = 'NV1',                       -- varchar(10)
                        @ngaylap = '2022-11-01 08:24:07', -- datetime
                        @ngaythu = '2022-11-01 08:24:07', -- datetime
                        @miengiam = 0.0                   -- float

----HÓA DƠN----
GO  

----CHI TIẾT HÓA ĐƠN----
-- 18. thủ tục thêm chi tiết hóa đơn 
create PROC proc_insert_CTHD 
       @MaHD varchar(10)  , @MaBM varchar(10), @SoTien1Tin FLOAT
	   AS BEGIN
	          INSERT INTO dbo.ChiTietHoaDon VALUES (@MaHD , @MaBM, @SoTien1Tin)
	      END

GO 

EXEC proc_insert_CTHD 'HD1' , 'BM10'

GO 

--  19. thủ tục update chi tiết hóa đơn

create PROC proc_update_CTHD 
       @MaHD VARCHAR(10) , @MaBM VARCHAR(10), @SoTien1Tin FLOAT
	   AS BEGIN
	          UPDATE dbo.ChiTietHoaDon SET MaBM = @MaBM, Sotien1tin =  @SoTien1Tin WHERE MaHD = @MaHD
	      END

GO 

EXEC dbo.proc_update_CTHD @MaHD = 'HD1', -- varchar(10)
                          @MaBM = 'BM9'  -- varchar(10)

GO 

-- 20. thủ tục xóa chi tiết hóa đơn có mã bộ môn là tham số truyền vào 

create PROC proc_delete_CTHD 
       @MaBM varchar(10), @MaHD VARCHAR(10)
	   AS BEGIN
	          DELETE FROM ChiTietHoaDon WHERE MaBM = @MaBM AND MaHD =  @MaHD
	      END

GO
create PROC Select_CTHD
			@maHD varchar(10)
			AS BEGIN
				SELECT RANK() OVER (ORDER BY ChiTietHoaDon.MaBM) AS STT, MonHoc.MaBM as N'Mã Môn Học', TenBM as N'Tên Môn Học', Sotin as N'Số Tín'
					   ,Sotien1tin as N'Đơn Giá', Sotin*Sotien1tin as N'Số Tiền'
				FROM ChiTietHoaDon INNER JOIN HoaDon ON HoaDon.MaHD = ChiTietHoaDon.MaHD
								   INNER JOIN MonHoc ON ChiTietHoaDon.MaBM = MonHoc.MaBM 
				WHERE ChiTietHoaDon.MaHD = @maHD
			END
GO
EXEC Select_CTHD @MaHD = 'HD1'
GO
create PROC Select_CTHD_Report
			@maHD varchar(10)
			AS BEGIN
				SELECT RANK() OVER (ORDER BY ChiTietHoaDon.MaBM) AS STT
				, ChiTietHoaDon.MaBM, TenBM, Sotin, Sotien1tin, TongSoTien
				,ChiTietHoaDon.MaHD, SinhVien.MaSV, TenSV, NgaySinh, Sotin*Sotien1tin as N'Tien1Mon'
				, HoaDon.NgayLap, TenKhoa, HoaDon.HocKy, case HoaDon.TrangThai
				   when 0 then N'Chưa Nộp'
				   else 'Đã Nộp'
				   end as N'TrangThai', MienGiam, ThanhTien, Lop, NamHoc
				FROM ChiTietHoaDon INNER JOIN HoaDon ON HoaDon.MaHD = ChiTietHoaDon.MaHD								   
								   INNER JOIN MonHoc ON ChiTietHoaDon.MaBM = MonHoc.MaBM 
								   INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV
								   INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
				WHERE ChiTietHoaDon.MaHD = @maHD
			END
EXEC Select_CTHD_Report @MaHD = 'HD1'
			
GO

alter PROC Select_CTHD
			@maHD varchar(10)
			AS BEGIN
				SELECT RANK() OVER (ORDER BY ChiTietHoaDon.MaBM) AS STT, ChiTietHoaDon.MaBM , TenBM, Sotin, Sotien1tin, Sotin*Sotien1tin as N'Tổng'
				FROM ChiTietHoaDon INNER JOIN HoaDon ON HoaDon.MaHD = ChiTietHoaDon.MaHD
								   INNER JOIN MonHoc ON ChiTietHoaDon.MaBM = MonHoc.MaBM 
				WHERE ChiTietHoaDon.MaHD = @maHD
			END  

EXEC proc_delete_CTHD 'BM10'			

GO
--error
create PROC Select_ChiTietHoaDon_Data
		@maHD varchar(10)	
		AS BEGIN
		
	        SELECT MaHD as N'Mã HĐ', HoaDon.MaSV as N'Mã SV', TenSV as N'Tên Sinh Viên', SinhVien.NgaySinh as N'Ngày Sinh' , NgayLap as N'Ngày Lập'
				   ,HocKy as N'Học Kỳ',SinhVien.Lop as N'Lớp', Khoa.TenKhoa as N'Khoa', MienGiam, ThanhTien, NamHoc
			FROM HoaDon INNER JOIN NhanVien ON HoaDon.MaNV = NhanVien.MaNV 
						INNER JOIN SinhVien ON HoaDon.MaSV = SinhVien.MaSV 
						INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa 
			WHERE HoaDon.MaHD = @maHD
									
	    END
EXEC Select_ChiTietHoaDon_Data 'BM10'


----CHI TIẾT HÓA ĐƠN----
GO
create PROC find_HoTen
			@ten nvarchar(50)
			AS BEGIN
				
				SELECT * FROM dbo.SinhVien WHERE TenSV like '%' + CAST(@ten as nvarchar(50)) + '%'
			END

EXEC find_HoTen N'Nguyễn'

----TÀI KHOẢN----

create PROC find_TaiKhoan
			@tk nvarchar(50), @mk nvarchar(50), @tenKhoa nvarchar(50)
			AS BEGIN
				SELECT * FROM TaiKhoan INNER JOIN Khoa ON TaiKhoan.MaKhoa = Khoa.MaKhoa
				WHERE TenDangNhap = @tk AND MatKhau = @mk AND TenKhoa = @tenKhoa
			END
EXEC find_TaiKhoan @tk = 'minh', @mk = 'minh'	, @tenKhoa = N'Công nghệ thông tin'


create PROC insert_TaiKhoan
			@tk nvarchar(50), @mk nvarchar(50), @tenKhoa nvarchar(50)
			AS BEGIN
				INSERT INTO TaiKhoan VALUES (@tk , @mk, (SELECT MaKhoa FROM Khoa WHERE TenKhoa = @tenKhoa))
			END

EXEC insert_TaiKhoan @tk = 'minh', @mk = 'minh'	, @tenKhoa = N'Công nghệ thông tin'

go
create PROC update_TaiKhoan
			@tk nvarchar(50), @mk nvarchar(50)
			AS BEGIN
				UPDATE TaiKhoan SET MatKhau = @mk WHERE TenDangNhap = @tk
			END
----TÀI KHOẢN----

----Mon Hoc----
create PROC select_MonHoc
			@maKhoa VARCHAR(10)
			AS BEGIN				
				SELECT MaBM as N'Mã Môn Học' , TenBM as N'Tên Môn Học'
				,Sotin as N'Số Tín Chỉ' 
				FROM MonHoc 
				WHERE MaKhoa = @maKhoa
			END

go
create PROC search_MonHoc_Report
			@maKhoa VARCHAR(10)
			AS BEGIN				
				SELECT RANK() OVER (ORDER BY MaBM) AS STT ,MaBM , TenBM 
				,Sotin, TenKhoa
				FROM MonHoc INNER JOIN Khoa ON MonHoc.MaKhoa = Khoa.MaKhoa
				WHERE MonHoc.MaKhoa = @maKhoa
			END

Go
create PROC insert_MonHoc
			@maBM VARCHAR(10), @tenBM NVARCHAR(10), @Sotin INT, @maKhoa VARCHAR(10)
			AS BEGIN				
				INSERT INTO MonHoc VALUES (@maBM ,@tenBM,@Sotin, @maKhoa)
			END
GO
alter PROC update_MonHoc
			@maBM VARCHAR(10), @tenBM NVARCHAR(30), @Sotin INT
		    AS BEGIN
				UPDATE MonHoc 
				SET MaBM = @maBM, TenBM = @tenBM, Sotin = @Sotin 
				WHERE MaBM = @maBM
	        END
GO
create PROC delete_MonHoc
			@maBM VARCHAR(10)
			AS BEGIN
				DELETE FROM MonHoc 
				WHERE MaBM = @maBM
	        END

go
create PROC search_MonHoc_MaMon
			@maKhoa VARCHAR(10), @maBM VARCHAR(10)
			AS BEGIN				
				SELECT MaBM as N'Mã Môn Học' , TenBM as N'Tên Môn Học'
				,Sotin as N'Số Tín Chỉ' 
				FROM MonHoc 
				WHERE MaKhoa = @maKhoa AND MaBM = @maBM
			END

go
create PROC search_MonHoc_TenMon
			@maKhoa VARCHAR(10), @tenBM NVARCHAR(30)
			AS BEGIN				
				SELECT MaBM as N'Mã Môn Học' , TenBM as N'Tên Môn Học'
				,Sotin as N'Số Tín Chỉ' 
				FROM MonHoc 
				WHERE MaKhoa = @maKhoa AND TenBM = @tenBM
			END
go
create PROC search_MonHoc_TinChi
			@maKhoa VARCHAR(10), @soTin INT
			AS BEGIN				
				SELECT MaBM as N'Mã Môn Học' , TenBM as N'Tên Môn Học'
				,Sotin as N'Số Tín Chỉ' 
				FROM MonHoc 
				WHERE MaKhoa = @maKhoa AND Sotin = @soTin
			END
----Mon Hoc----

----Khoa----
create PROC select_Khoa
			AS BEGIN
				SELECT MaKhoa as N'Mã Khoa' , TenKhoa as N'Tên Khoa'
				from Khoa
			END

create PROC Select_tenKhoa			
			AS BEGIN
				SELECT TenKhoa FROM Khoa 
			END
EXEC Select_tenKhoa	
create PROC Select_maKhoa
			@tenKhoa NVARCHAR(50)
			AS BEGIN				
				SELECT MaKhoa 
				FROM Khoa 
				WHERE TenKhoa = @tenKhoa
			END
EXEC Select_maKhoa	@tenKhoa = N'Công nghệ thông tin'
----Khoa----

----LOP----
create PROC Select_TenLop
			@maKhoa VARCHAR(10)
			AS BEGIN				
				SELECT Lop 
				FROM LopHanhChinh
				WHERE MaKhoa = @maKhoa
			END


create PROC Select_Lop
			@maKhoa VARCHAR(10)
			AS BEGIN	
				SELECT RANK() OVER (ORDER BY Lop) AS STT, Lop 
				FROM LopHanhChinh
				WHERE MaKhoa = @maKhoa				
			END
			go
create proc Select_Lop_Theo_Ten_Khoa @tenKhoa nvarchar(50)
as
begin
	select * from LopHanhChinh LHC, Khoa K
	WHERE K.TenKhoa LIKE N'%' + cast(@tenKhoa as nvarchar) + '%' and LHC.MaKhoa = K.MaKhoa

end
go
----LOP----
create PROC Select_Lop_Theo_Khoa
			@tenKhoa NVARCHAR(50)
			AS BEGIN	
				select Khoa.MaKhoa, TenKhoa, Lop
				FROM Khoa, LopHanhChinh
				WHERE Khoa.TenKhoa = @tenKhoa and Khoa.MaKhoa = LopHanhChinh.MaKhoa
			END
			go

			alter table NhanVien
			add CMND varchar(20) unique