CREATE DATABASE Spotify
USE Spotify

CREATE TABLE Artists
(
ArtistID INT PRIMARY KEY IDENTITY,
ArtistName NVARCHAR(255) NOT NULL,
)
CREATE TABLE Albums
(
AlbumID INT PRIMARY KEY IDENTITY,
AlbumName NVARCHAR(255) NOT NULL,
ArtistID INT FOREIGN KEY REFERENCES Artists(ArtistID)
)
CREATE TABLE Musics
(
MusicID INT PRIMARY KEY IDENTITY,
MusicTitle NVARCHAR(255) NOT NULL,
Duration NVARCHAR(255) NOT NULL,
AlbumID INT FOREIGN KEY REFERENCES Albums(AlbumID)
)
CREATE TABLE MusicArtists
(
ID INT PRIMARY KEY IDENTITY,
MusicID INT FOREIGN KEY REFERENCES Musics(MusicID),
ArtistID INT FOREIGN KEY REFERENCES Artists(ArtistID)
)
INSERT INTO Artists ( ArtistName ) VALUES
('Miyagi'),
('Skriptonit'),
('GUF'),
('The Neighborhood')
INSERT INTO Albums (AlbumName,ArtistID) VALUES
('Yamakasi',1),
('Hajime',1),
('2004',2),
('Fantasy Mixtape',2),
('Gorod Dorog',3),
('Doma',3),
('Zapretnoe Mesto',3),
('Wiped Out',4),
('I Love You',4)
INSERT INTO Musics (MusicTitle,Duration,AlbumID) VALUES
('Atlant','3m 07s',1),
('Utopia','3m 29s',1),
('Look At The Scars','3m 47s',2),
('Fire Man','3m 38s',2),
('Vecherinka','6m 03s',3),
('Lambada','3m 18s',4),
('Ice Baby','4m 12s',5),
('Uragan','4m 05s',6),
('Softcore','3m 01s',7),
('Afraid','4m 30s',8)
INSERT INTO MusicArtists (MusicID,ArtistID) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,3),
(8,3),
(9,4),
(10,4)

--Musics-in name-ni, totalSecond-nu, artist nama-ni, album name-ni göstərən bir view yazırsız.
GO
CREATE VIEW GetAllMusics AS
SELECT M.MusicTitle,M.Duration,A.ArtistName,AA.AlbumName FROM Musics M
JOIN MusicArtists MA ON MA.MusicID=M.MusicID
JOIN ARTISTS A ON A.ArtistID=MA.ArtistID
JOIN Albums AA ON AA.AlbumID=A.ArtistID
GO
SELECT * FROM GetAllMusics

--Albumun adını və həmin albumda neçə dənə mahnı var onu göstərən bir view yazırsız.
GO
CREATE VIEW TotalMusicsOnAlbums AS
SELECT A.AlbumName, COUNT(M.MusicID) MusicCount FROM Albums A
JOIN Musics M ON M.AlbumID=A.AlbumID
GROUP BY AlbumName
GO
SELECT * FROM TotalMusicsOnAlbums

--ListenerCount-u parametr olaraq göndərilən listenerCount-dan böyük olan və Album adında parametr olaraq göndərilən search dəyəri olan bütün mahnıların adını, listenerCount-nu və Album adını göstərən bir procedure yazın.
ALTER TABLE Musics ADD ListenerCount INT
UPDATE Musics SET ListenerCount=100 WHERE MusicID=1
UPDATE Musics SET ListenerCount=200 WHERE MusicID=2
UPDATE Musics SET ListenerCount=300 WHERE MusicID=3
UPDATE Musics SET ListenerCount=400 WHERE MusicID=4
UPDATE Musics SET ListenerCount=500 WHERE MusicID=5
UPDATE Musics SET ListenerCount=600 WHERE MusicID=6
UPDATE Musics SET ListenerCount=700 WHERE MusicID=7
UPDATE Musics SET ListenerCount=800 WHERE MusicID=8
UPDATE Musics SET ListenerCount=900 WHERE MusicID=9
UPDATE Musics SET ListenerCount=1000 WHERE MusicID=10
GO
CREATE PROCEDURE usp_GetListenerCountForAlbum @ListenerCount INT,@AlbumName NVARCHAR(255) AS 
SELECT M.MusicTitle,M.ListenerCount,A.AlbumName FROM Musics M
JOIN Albums A ON A.AlbumID=M.AlbumID
WHERE M.ListenerCount>@ListenerCount AND A.AlbumName=@AlbumName
GO
EXEC usp_GetListenerCountForAlbum 10,'Hajime'