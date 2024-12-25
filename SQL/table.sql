CREATE DATABASE QLhocphi
use QLhocphi

-- Tạo bảng khoa và khóa chính cho bảng
CREATE TABLE Khoa (
   MaKhoa VARCHAR(10) NOT NULL ,
   TenKhoa NVARCHAR(50) NOT NULL
)
ALTER TABLE dbo.Khoa ADD CONSTRAINT PK_MaKhoa_khoa primary key (MaKhoa)

-- Tạo bảng sinh viên và khóa chính khóa ngoại cho bảng Sinh Vien

CREATE TABLE SinhVien (
   MaSV VARCHAR(10) NOT NULL primary key, 
   TenSV NVARCHAR(50) NOT NULL ,
   GioiTinh BIT NOT NULL , 
   NgaySinh DATE NOT NULL ,
   MaKhoa VARCHAR(10) NOT NULL,
   Lop VARCHAR(10) NOT NULL,
   SoDT VARCHAR(10),

)

--ALTER TABLE SinhVien ADD SoDT VARCHAR(10)
ALTER TABLE dbo.SinhVien ADD CONSTRAINT FK_MaKhoa FOREIGN KEY(MaKhoa) REFERENCES dbo.Khoa 
ALTER TABLE SinhVien ADD FOREIGN KEY(Lop) REFERENCES LopHanhChinh


-- Tao bảng bộ môn và tạo khóa chính khóa ngoại cho bảng BoMon

CREATE TABLE MonHoc (
      MaBM VARCHAR(10) NOT NULL , 
	  TenBM NVARCHAR(30) NOT NULL ,
	  Sotin INT NOT NULL,
	  MaKhoa VARCHAR(10) NOT NULL
)



ALTER TABLE dbo.MonHoc ADD CONSTRAINT PK_MaBM_BM PRIMARY KEY(MaBM) ,
                          CONSTRAINT CK_SoTn CHECK(Sotin > 0)
ALTER TABLE MonHoc ADD	FOREIGN KEY (MaKhoa) REFERENCES Khoa
							


--Tạo bảng nhân viên và tọa khóa chính khóa ngoại cho bảng NhanVien


CREATE TABLE NhanVien (
     MaNV VARCHAR(10) NOT NULL , 
	 TenNV NVARCHAR(20) NOT NULL , 
	 NgaySinh DATE NOT NULL ,
	 GioiTinh BIT NOT NULL , 
	 MaKhoa VARCHAR(10) NOT NULL,
	 SoDT VARCHAR(10)
)
--ALTER TABLE NhanVien ADD SoDT VARCHAR(10)
ALTER TABLE dbo.NhanVien ADD CONSTRAINT PK_MaNV_NV PRIMARY KEY (MaNV) , 
                             CONSTRAINT FK_MaKhoa_NV FOREIGN KEY (MaKhoa) REFERENCES dbo.Khoa 
ALTER TABLE dbo.NhanVien ADD CONSTRAINT CK_age CHECK (DATEDIFF(DAY , NgaySinh , GETDATE()) / 365 >= 24)

--Tạo bảng hóa đơn và tọa khóa chính khóa ngoại cho bảng HoaDon

CREATE TABLE HoaDon (
      MaHD VARCHAR(10) NOT NULL ,
	  MaSV VARCHAR(10) NOT NULL , 
	  MaNV VARCHAR(10) NOT NULL ,
	  NgayLap DATETIME NOT NULL ,
	  HocKy INT NOT NULL,
	  NamHoc VARCHAR(9) NOT NULL,
	  TrangThai Bit NOT NULL DEFAULT 0,
	  TongSoTin INT DEFAULT 0 NOT NULL ,
	  TongSoTien FLOAT DEFAULT 0 NOT NULL,
	  MienGiam FLOAT  NOT NULL,
	  ThanhTien FLOAT DEFAULT 0
)


ALTER TABLE dbo.HoaDon ADD CONSTRAINT PK_MaHD_HD PRIMARY KEY (MaHD) , 
                           CONSTRAINT FK_MaSV_HD FOREIGN KEY (MaSV) REFERENCES dbo.SinhVien ,
						   CONSTRAINT FK_MaNV_HD FOREIGN KEY (MaNV) REFERENCES dbo.NhanVien
ALTER TABLE dbo.HoaDon ADD CONSTRAINT CK_ngaylap CHECK(NgayLap <= GETDATE())

-- tạo bảng chi tiết hóa đơn và tạo khóa chính , khóa ngoại cho bảng ChiTietHoaDon

CREATE TABLE ChiTietHoaDon (
       MaHD VARCHAR(10) NOT NULL ,
	   MaBM  VARCHAR(10) NOT NULL,
	   Sotien1tin FLOAT NOT NULL
)

ALTER TABLE ChiTietHoaDon ADD PRIMARY KEY( MaHD,MaBM);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT  FK_MaBM_CTHD FOREIGN KEY(MaBM) REFERENCES MonHoc 
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT  FK_MaHD_CTHD FOREIGN KEY(MaHD) REFERENCES HoaDon ON UPDATE CASCADE ON DELETE CASCADE


--Tao bảng Lớp
CREATE TABLE LopHanhChinh (
		Lop VARCHAR(10) NOT NULL,
		MaKhoa VARCHAR(10) NOT NULL
)

ALTER TABLE LopHanhChinh ADD PRIMARY KEY(Lop);
ALTER TABLE LopHanhChinh ADD FOREIGN KEY(MaKhoa) REFERENCES Khoa

--Tao bang tai khoản
CREATE TABLE TaiKhoan (
	TenDangNhap VARCHAR(50) PRIMARY KEY,
	MatKhau VARCHAR(50) NOT NULL,
	MaKhoa VARCHAR(10) NOT NULL
)
ALTER TABLE TaiKhoan ADD FOREIGN KEY(MaKhoa) REFERENCES Khoa


