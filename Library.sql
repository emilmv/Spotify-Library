--Books: Id Name - max 100, min 2 AuthorId PageCount - min 10 Authors: Id Name Surname Books ve Authors table-lariniz olsun (one to many realtion) Id,Name,PageCount
--ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin
CREATE DATABASE Library
USE Library

CREATE TABLE Authors
(
ID INT PRIMARY KEY IDENTITY,
Name NVARCHAR(255) NOT NULL,
Surname NVARCHAR(255) NOT NULL,
)
CREATE TABLE Books
(
ID INT PRIMARY KEY IDENTITY,
BookName NVARCHAR(100) CHECK(LEN(BookName)>2),
AuthorID INT FOREIGN KEY REFERENCES Authors(ID),
[PageCount] INT CHECK([PageCount]>10)
)
INSERT INTO Authors (Name,Surname) VALUES
('George','Orwell'), --1984,Animal Farm
('Xalid','Huseyn'), --1000 mohteshem gunesh, Cerpeleng Ucuran
('Fyodor','Dostoyevski') -- Cinayet ve Ceza, Beyaz Geceler
INSERT INTO Books (BookName,AuthorID,[PageCount]) VALUES
('1984',1,300),
('Animal Farm',1,400),
('1000 Mohteshem Gunesh',2,250),
('Cerpeleng Ucuran',2,350),
('Cinayet ve Ceza',3,550),
('Beyaz Geceler',3,500)

GO
CREATE VIEW GetInfo AS
SELECT B.ID,B.BookName,B.[PageCount],CONCAT(A.Name,' ',A.Surname) AS [Author Full Name] FROM Books B
JOIN Authors A ON A.ID=B.AuthorID
GO
SELECT * FROM GetInfo
