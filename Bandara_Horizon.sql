-- Soal 1
CREATE DATABASE BANDARA;
USE BANDARA;

CREATE TABLE Bandara (
  ID_Bandara INT PRIMARY KEY,
  Nama VARCHAR(100),
  Kota VARCHAR(100),
  Negara VARCHAR(100),
  Kode_IATA VARCHAR(10) UNIQUE
);

CREATE TABLE Bagasi (
  ID INT PRIMARY KEY,
  Berat INT,
  Ukuran VARCHAR(5),
  Warna VARCHAR(255),
  Jenis VARCHAR(255)
);

CREATE TABLE Maskapai (
  ID_Maskapai VARCHAR(10) PRIMARY KEY,
  Nama VARCHAR(100),
  Negara_Asal VARCHAR(100)
);

CREATE TABLE Penumpang (
  NIK CHAR(16) PRIMARY KEY,
  Nama VARCHAR(255),
  Tanggal_Lahir DATE,
  Alamat VARCHAR(255),
  No_Telepon VARCHAR(13),
  Jenis_Kelamin CHAR(1),
  Kewarganegaraan VARCHAR(255),
  Bagasi_ID INT,
  FOREIGN KEY (Bagasi_ID) REFERENCES Bagasi(ID)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Pesawat (
  ID_Pesawat VARCHAR(10) PRIMARY KEY,
  Model VARCHAR(50),
  Kapasitas INT,
  Tahun_Produksi INT,
  Status_Pesawat VARCHAR(50),
  ID_Maskapai VARCHAR(10),
  FOREIGN KEY (ID_Maskapai) REFERENCES Maskapai(ID_Maskapai)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Penerbangan (
  ID_Penerbangan VARCHAR(10) PRIMARY KEY,
  Waktu_Keberangkatan DATETIME,
  Waktu_Sampai DATETIME,
  Status_Penerbangan VARCHAR(50),
  ID_Pesawat VARCHAR(10),
  FOREIGN KEY (ID_Pesawat) REFERENCES Pesawat(ID_Pesawat)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Bandara_Penerbangan (
  Bandara_ID INT,
  Penerbangan_ID VARCHAR(10),
  FOREIGN KEY (Bandara_ID) REFERENCES Bandara(ID_Bandara)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (Penerbangan_ID) REFERENCES Penerbangan(ID_Penerbangan)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Tiket (
  ID_Tiket VARCHAR(10) PRIMARY KEY,
  Nomor_Kursi VARCHAR(10),
  Harga INT,
  Waktu_Pembelian DATETIME,
  Kelas_Penerbangan VARCHAR(50),
  ID_Penerbangan VARCHAR(10),
  FOREIGN KEY (ID_Penerbangan) REFERENCES Penerbangan(ID_Penerbangan)
  ON UPDATE CASCADE ON DELETE CASCADE
);

-- Soal 2
INSERT INTO Bandara VALUES
(1, 'Soekarno-Hatta', 'Jakarta', 'Indonesia', 'CGK'),
(2, 'Ngurah Rai', 'Denpasar', 'Indonesia', 'DPS'),
(3, 'Changi', 'Singapore', 'Singapore', 'SIN'),
(4, 'Haneda', 'Tokyo', 'Japan', 'HND');

INSERT INTO Bagasi VALUES
(1, 20, 'M', 'Hitam', 'Koper'),
(2, 15, 'S', 'Merah', 'Ransel'),
(3, 25, 'L', 'Biru', 'Koper'),
(4, 10, 'S', 'Hijau', 'Ransel');

INSERT INTO Maskapai VALUES
('GA123', 'Garuda Indonesia', 'Indonesia'),
('SQ456', 'Singapore Airlines', 'Singapore'),
('JL789', 'Japan Airlines', 'Japan'),
('QZ987', 'AirAsia', 'Malaysia');

INSERT INTO Penumpang VALUES
('3201123456789012', 'Budi Santoso', '1990-04-15', 'Jl. Merdeka No.1', '081234567890', 'L', 'Indonesia', 1),
('3302134567890123', 'Siti Aminah', '1985-08-20', 'Jl. Kebangsaan No.2', '081298765432', 'P', 'Indonesia', 2),
('3403145678901234', 'John Tanaka', '1992-12-05', 'Shibuya, Tokyo', '080123456789', 'L', 'Japan', 3),
('3504156789012345', 'Li Wei', '1995-03-10', 'Orchard Rd, Singapore', '0658123456789', 'L', 'Singapore', 4);

INSERT INTO Pesawat VALUES
('PKABC1', 'Boeing 737', 180, 2018, 'Aktif', 'GA123'),
('PKDEF2', 'Airbus A320', 150, 2020, 'Aktif', 'SQ456'),
('PKGHI3', 'Boeing', 250, 2019, 'Dalam Perawatan', 'JL789'),
('PKJKL4', 'Airbus A330', 280, 2021, 'Aktif', 'QZ987');

INSERT INTO Penerbangan VALUES
('FL0001', '2024-12-15 10:00:00', '2024-12-15 12:30:00', 'Jadwal', 'PKABC1'),
('FL0002', '2024-12-16 08:00:00', '2024-12-16 10:45:00', 'Jadwal', 'PKDEF2'),
('FL0003', '2024-12-17 14:00:00', '2024-12-17 16:30:00', 'Ditunda', 'PKGHI3'),
('FL0004', '2024-12-18 18:00:00', '2024-12-18 20:30:00', 'Jadwal', 'PKJKL4');

INSERT INTO Bandara_Penerbangan VALUES
(1, 'FL0001'),
(2, 'FL0002'),
(3, 'FL0003'),
(4, 'FL0004');

INSERT INTO Tiket VALUES
('TIK001', '12A', 1200000, '2024-11-01 08:00:00', 'Ekonomi', 'FL0001'),
('TIK002', '14B', 1500000, '2024-11-02 09:30:00', 'Bisnis', 'FL0002'),
('TIK003', '16C', 2000000, '2024-11-03 10:15:00', 'Ekonomi', 'FL0003'),
('TIK004', '18D', 1000000, '2024-11-04 11:45:00', 'Ekonomi', 'FL0004');

-- Soal 3
ALTER TABLE Penumpang ADD Email VARCHAR(100);

-- Soal 4
ALTER TABLE Bagasi MODIFY Jenis VARCHAR(50);

-- Soal 5
ALTER TABLE Bandara DROP INDEX Kode_IATA;
ALTER TABLE ‘bandara’ DROP PRIMARY KEY, ADD PRIMARY KEY(‘Kode_IATA’);

-- Soal 6
ALTER TABLE Penumpang DROP COLUMN Email;

-- Soal 7
UPDATE Penerbangan
SET Waktu_Keberangkatan = '2024-12-15 11:00:00',
    Waktu_Sampai = '2024-12-15 13:30:00'
WHERE ID_Penerbangan = 'FL0001';

-- Soal 8
UPDATE Penumpang
SET No_Telepon = '081223344556'
WHERE NIK = '3302134567890123';

-- Soal 9
UPDATE Pesawat
SET Status_Pesawat = 'Aktif'
WHERE ID_Pesawat = 'PKGHI3';

-- Soal 10
DELETE FROM Tiket WHERE ID_Penerbangan = 'FL0004';

-- Soal 11
DELETE FROM Bagasi WHERE ID = 2;

-- Soal 12
DELETE FROM Penerbangan WHERE Status_Penerbangan = 'Ditunda';