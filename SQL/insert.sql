USE QLhocphi 
GO 
-- Thêm dữ liệu cho bảng Khoa
INSERT dbo.Khoa (MaKhoa , TenKhoa) VALUES ('1' , N'Công nghệ thông tin') ,
                                          ('2' , N'Điện tử viễn thông') ,
										  ('3' , N'Kinh tế') ,
										  ('4' , N'Luật') 	
--DELETE FROM Khoa
--DELETE FROM NhanVien

--Thêm dư liệu cho bảng Lop
INSERT LopHanhChinh (MaKhoa , Lop) VALUES ('1' , N'2110A04') ,
                                          ('1' , N'2110A03') ,
										  ('1' , N'2110A01') ,
										  ('2' , N'2110B02') ,
										  ('1' , N'2110A02') ,
										  ('2' , N'2110B01') ,
										  ('3' , N'2110C01') ,
										  ('3' , N'2110C02') ,
										  ('4' , N'2110D01') ,
										  ('4' , N'2110D02')
-- Thêm dữ liệu cho bảng sinh viên

INSERT dbo.SinhVien (MaSV , TenSV , GioiTinh , NgaySinh , MaKhoa, Lop) VALUES ('1', N'Nguyễn Kim Thiện' , 1 , '20030331' , 1, '2110A04') ,	
                                                                         ('2', N'Nguyễn Bá Việt' , 1 , '20031128' , 2, '2110B02') ,
																		 ('3', N'Trần Hà My' , 0 , '20031230' , 4, '2110D02') ,
																		 ('4', N'Hoàng Vũ Đức' , 1 , '20030419' , 1, '2110A04') ,
																		 ('5', N'Trương Công Thân' , 1 , '20030222' , 3, '2110C01') ,
																		 ('6', N'Nguyễn Quỳnh Như' , 0 , '20030718' , 1, '2110A04') ,
																		 ('7', N'Phan Châu Hân' , 0 , '20030612' , 2, '2110B02') ,
																		 ('8', N'Nguyễn Nhật Bình' , 1 , '20030111' , 3, '2110C01') ,
																		 ('9', N'Nguyễn Hoàng Thân' , 1, '20030919' , 4, '2110D02') ,
																		 ('10', N'Nguyễn Ngọc Minh Nghi' , 0 , '20030322' , 2, '2110B02') ,
																		 ('11', N'Hoàng Thị Bảo' , 0 , '20030310' , 3, '2110C01') ,
																		 ('12', N'Trần Thị An' , 0 , '20030422' , 4, '2110D02') 

--DELETE FROM SinhVien
-- Thêm dữ liệu cho bảng Bộ môn 
INSERT MonHoc (MaBM , TenBM , Sotin, MaKhoa) VALUES ('DTVT1' , N'Kỹ Thuật vi xử lý' , 3, '2') ,
                                               ('DTVT2' , N'Giải tích 1', 3, '2') ,
											   ('DTVT3' , N'Mạch tương tự' , 3, '2') ,
											   ('DTVT4' , N'Lý thuyết mạch', 3, '2')  ,
											   ('DTVT5' , N'Mạch số', 4 , '2') ,
											   ('KT1' , N'Pháp luật kinh tế', 4, '3') ,
											   ('KT2' , N'Nguyên lý kinh tế vĩ mô', 4, '3'),
											   ('KT3' , N'Nguyên lý thống kê', 2 , '3'),
											   ('KT4' , N'Nguyên lý kế toán', 2, '3'),
											   ('LT1' , N'Luật dân sự 1', 2, '4') ,
											   ('LT2' , N'Luật dân sự 2', 3, '4') ,
											   ('LT3' , N'Luật La Mã', 3, '4') ,
											   ('LT4' , N'Luật thương mại', 3, '4') ,											
											   ('LT5' , N'Luật ngân hàng', 4, '4'), 
											   ('CNTT1' , N'Giải tích 1' , 3, '1') ,
                                               ('CNTT2' , N'Giải tích 2', 3, '1') ,
											   ('CNTT3' , N'Giải tích 3' , 3, '1') ,
											   ('CNTT4' , N'Xác suất thống kê', 3, '1')  ,
											   ('CNTT5' , N'Lập trình cơ sở', 4 , '1') ,
											   ('CNTT6' , N'Lập trình web', 4, '1') ,
											   ('CNTT7' , N'Lập trình hướng sự kiện', 4, '1'),
											   ('CNTT8' , N'Giai tích và toán hình', 3, '1') ,
											   ('CNTT9' , N'Toán rời rạc', 3, '1') ,
											   ('CNTT10' , N'Tin học đai cương', 3, '1'),											
											   ('CNTT11' , N'Lập trình di động', 4, '1')

--	Thêm dữ liệu cho giảng viên

-- Thêm dữ liệu cho bảng nhân viên
INSERT dbo.NhanVien (MaNV , TenNV , NgaySinh , GioiTinh , CMND , MaKhoa) VALUES ('NV1' , N'Nguyễn Thị Hương' , '19941118' , 0 , '234236656' , '1') , 
																				('NV2' , N'Nguyễn Chu Ngọc' , '19971218' , 0 , '234234456' , '1') , 
																				('NV3' , N'Trần Thái Hân' , '19980921' , 0 , '2734534856' , '1') , 
																				('NV4' , N'Hoàng Thị Hi' , '19910311' , 0 , '25345345546' , '2') , 
																				('NV5' , N'Nguyễn Thị Hạnh' , '19941118' , 0 , '5634534656' , '2') , 
																				('NV6' , N'Chu Lan Hương' , '19891201' , 0 , '7773436656' , '3') , 
																				('NV7' , N'Nguyễn Nhật Tân' , '19941118' , 1 , '5235736656' , '3') , 
																				('NV8' , N'Nguyễn Thế Anh' , '19900112' , 1 , '83454336656' , '4') , 
																				('NV9' , N'Trần Duy Hưng' , '19921126' , 1 , '7271865465' , '4') ,
																				('NV10' , N'Phan Thị Hòa' , '19831128' , 0 , '8272456334' , '2')

-- Thêm dữ liệu cho hóa đơn
INSERT HoaDon (MaHD , MaSV , MaNV , NgayLap, MienGiam, TrangThai, HocKy, NamHoc) 
VALUES ('HD1' , 1 , 'NV1' , '20220922'  , 0, 0,1,'2022-2023') ,                                                                                      
('HD2' , 2 , 'NV2' , '20220922'  , 0, 0 ,2,'2022-2023') , 
('HD3' , 3 , 'NV4' , '20220819'  , 0 , 0,1,'2022-2023') , 
('HD4' , 4 , 'NV1' , '20220122'  , 0, 0 ,1,'2022-2023') , 
('HD5' , 5 , 'NV3' , '20220111'  , 0, 0,2 ,'2022-2023') , 
('HD6' , 6 , 'NV5' , '20220811'  , 0.1, 0,1,'2022-2023' ) , 
('HD7' , 8, 'NV8' , '20211230'  , 0.1, 0,2,'2022-2023' ) , 
('HD8' , 7 , 'NV10' , '20220222'  , 0, 0,1,'2022-2023' ) , 
('HD9' , 9 , 'NV7' , '20220202'  , 0, 0,2,'2022-2023' ) , 
('HD10' , 10 , 'NV6' , '20220922'  , 0 , 0,1,'2022-2023') , 
('HD11' , 11 , 'NV9' , '20220922'  , 0 , 0,1,'2022-2023')

--Thêm dữ liệu cho bảng chi tiết hóa đơn
    INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD1' , 'CNTT1', 100 ) 
    INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD1' , 'CNTT2' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD2' , 'DTVT2' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD2' , 'DTVT3' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD3' , 'LT1', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD3' , 'LT2', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD4' , 'CNTT3' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD4' , 'CNTT4', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD5' , 'KT1' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD5' , 'KT2' , 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD6' , 'CNTT4', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD6' , 'CNTT7', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD7' , 'DTVT4', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD7' , 'DTVT3', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD8' , 'KT4', 100 ) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD8' , 'KT2', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD9' , 'LT4', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD9' , 'LT1', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD10' , 'DTVT5', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD10' , 'DTVT4', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD10' , 'DTVT3', 100)
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD11' , 'KT1', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD11' , 'KT4', 100) 
	INSERT dbo.ChiTietHoaDon (MaHD , MaBM, Sotien1tin) VALUES ('HD11' , 'KT3', 100) 