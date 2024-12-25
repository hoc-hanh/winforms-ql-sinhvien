use QLhocphi
go

--Tính tổng tín trong hóa đơn
create trigger TinhTongTin
on ChiTietHoaDon
for insert, delete
as
begin
	declare @MaBM varchar(10), @Tin INT, @MaHD varchar(10)
	IF EXISTS (SELECT * FROM inserted)
	BEGIN
		SELECT @MaHD = MaHD FROM inserted
		select @MaBM = MaBM FROM inserted
		SELECT @Tin = (SELECT Sotin FROM MonHoc WHERE MaBM = @MaBM)
		UPDATE HoaDon SET TongSoTin = TongSoTin + @Tin WHERE MaHD = @MaHD
	END
	ELSE
	BEGIN
		SELECT @MaHD = MaHD FROM deleted
		SELECT @MaBM = MaBM FROM deleted
		SELECT @Tin = (SELECT Sotin FROM BoMon WHERE MaBM = @MaBM)
		UPDATE HoaDon SET TongSoTin = TongSoTin - @Tin WHERE MaHD = @MaHD
	END
end

--Tính tổng tiền trong hóa đơn
go
create trigger TinhTongTien
on ChiTietHoaDon
for insert, delete
as
begin
	declare @MaBM varchar(10), @Tin FLOAT, @MaHD varchar(10), @Tien Float
	IF EXISTS (SELECT * FROM inserted)
	BEGIN
		SELECT @MaHD = MaHD FROM inserted
		select @MaBM = MaBM FROM inserted
		SELECT @Tien = (SELECT Sotien1tin FROM ChiTietHoaDon WHERE MaBM = @MaBM and MaHD = @MaHD)
		SELECT @Tin = (SELECT Sotin FROM MonHoc WHERE MaBM = @MaBM)
		UPDATE HoaDon SET TongSoTien = TongSoTien + (@Tin * @Tien) WHERE MaHD = @MaHD
	END
	ELSE
	BEGIN
		SELECT @MaHD = MaHD FROM deleted
		SELECT @MaBM = MaBM FROM deleted
		SELECT @Tien = (SELECT Sotien1tin FROM ChiTietHoaDon WHERE MaBM = @MaBM)
		SELECT @Tin = (SELECT Sotin FROM MonHoc WHERE MaBM = @MaBM)
		UPDATE HoaDon SET TongSoTien = TongSoTien - (@Tin * @Tien) WHERE MaHD = @MaHD
	END
end

go
create trigger TinhThanhTien
on HoaDon
for update, insert
as
begin
	declare @MienGiam FLOAT, @MaHD varchar(10), @Tien Float
	BEGIN
		SELECT @MaHD = MaHD FROM inserted
		SELECT @Tien = (SELECT TongSoTien FROM HoaDon WHERE MaHD = @MaHD)
		SELECT @MienGiam = (SELECT MienGiam FROM HoaDon WHERE MaHD = @MaHD)
		UPDATE HoaDon SET ThanhTien = @Tien - (@Tien * @MienGiam) WHERE MaHD = @MaHD
	END
end


DELETE ChiTietHoaDon WHERE MaBM = 'BM2' and MaHD = 'HD1'

go
--update tổng tiền và tín trong hóa đơn
create trigger UpdateBoMon1
on MonHoc for update, insert
as 
begin
	declare @MaBM varchar(10), @Tin int, @MaHD varchar(10), @Tien Float,@1 int, @2 float
	select @MaBM = MaBM from inserted
	select @1 = Sotin from deleted
	
	select @Tin = SoTin from inserted
	
	if update (SoTin) 
		begin 
			Select *
			Into   #Temp
			From   ChiTietHoaDon

			Declare @Id varchar(10),  @Id2 varchar(10) 
			While (Select Count(*) From #Temp) > 0
				Begin
					Select Top 1 @Id = MaHD , @Id2  = MaBM  From #Temp
					if @Id2 = @MaBM
						begin
							UPDATE HoaDon SET TongSoTin = TongSoTin - @1 + @Tin WHERE MaHD = @Id
							UPDATE HoaDon SET TongSoTien = TongSoTien -(@1*(SELECT Sotien1tin FROM ChiTietHoaDon)) + (@Tin * (SELECT Sotien1tin FROM ChiTietHoaDon)) WHERE MaHD = @Id
						end
					Delete #Temp Where MaHD = @Id and @Id2  = MaBM
				End
		end
end

go
create trigger UpdateBoMon2
on ChiTietHoaDon for update, insert
as 
begin
	declare @MaBM varchar(10), @MaHD varchar(10), @Tien Float, @2 float
	select @MaBM = MaBM from inserted
	
	select @2 = Sotien1tin from deleted
	
	select @Tien = Sotien1tin from inserted
	if update(Sotien1tin)
		begin 
			UPDATE HoaDon SET TongSoTien = TongSoTien -((SELECT SoTin FROM MonHoc)*@2) + ((SELECT SoTin FROM MonHoc)* @Tien) WHERE MaHD = @MaHD
						
		End
END