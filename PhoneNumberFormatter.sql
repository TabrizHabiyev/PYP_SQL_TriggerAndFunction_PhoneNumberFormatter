CREATE FUNCTION dbo.PhoneFormatterFunc(@phone varchar(25))
RETURNS varchar(25)
AS
BEGIN
DECLARE @formattedPhone varchar(25)
SET @formattedPhone=
CASE
WHEN LEN(@phone)=13
THEN '+90 ('+ SUBSTRING(@phone,4,3)+ ') ' +SUBSTRING(@phone,7,3) +' ' +SUBSTRING(@phone,10,2)
+ ' ' +SUBSTRING(@phone,12,2)
WHEN LEN(@phone)=12
THEN '+90 ('+ SUBSTRING(@phone,3,3)+ ') ' +SUBSTRING(@phone,6,3) +' ' +SUBSTRING(@phone,9,2)
+ ' ' +SUBSTRING(@phone,11,2)
WHEN LEN(@phone)=11
THEN '+90 ('+ SUBSTRING(@phone,2,3)+ ') ' +SUBSTRING(@phone,5,3) +' ' +SUBSTRING(@phone,8,2)
+ ' ' +SUBSTRING(@phone,10,2)
WHEN LEN(@phone)=10
THEN '+90 ('+ SUBSTRING(@phone,1,3)+ ') ' +SUBSTRING(@phone,4,3) +' ' +SUBSTRING(@phone,7,2)
+ ' ' +SUBSTRING(@phone,9,2)
ELSE
'Phone number is not valid format'
END
RETURN @formattedPhone
END


go

CREATE TRIGGER dbo.PhoneFormatterTrigger
ON Shippers
INSTEAD OF INSERT
AS
BEGIN
DECLARE @phone varchar(25)
DECLARE @companyname varchar(25)
SELECT  @companyname =CompanyName FROM Shippers
SELECT @phone=Phone FROM inserted
INSERT INTO Shippers(CompanyName,Phone) Values (@companyname,dbo.PhoneFormatterFunc(@phone))
END



insert Shippers(CompanyName,Phone) Values ('Code Academy' , '53278945123')






