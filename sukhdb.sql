create database sukhdb;
use sukhdb;
CREATE TABLE category_header (
	cat_code INT PRIMARY KEY, 
    cat_desc VARCHAR(20)
);
 
CREATE TABLE route_header (
    route_id INT PRIMARY KEY,
    route_no INT,
    cat_code INT,
    origin VARCHAR(20),
    destination VARCHAR(20),
    fare DECIMAL(7,2),
    distance INT,
    capacity INT,
    FOREIGN KEY (cat_code) REFERENCES category_header(cat_code)
);
 
CREATE TABLE place_header (
    place_id INT PRIMARY KEY,
    place_name VARCHAR(20) NOT NULL,
    place_address VARCHAR(50),
    bus_station VARCHAR(10)
);
 
CREATE TABLE fleet_header (
    fleet_id INT PRIMARY KEY,
    day DATE,
    route_id INT,
    cat_code INT,
    FOREIGN KEY (route_id) REFERENCES route_header(route_id),
    FOREIGN KEY (cat_code) REFERENCES category_header(cat_code)
);
 
CREATE TABLE ticket_header (
    fleet_id INT,
    ticket_no INT PRIMARY KEY,
    doi DATE NOT NULL,
    dot DATE NOT NULL,
    time_travel CHAR(8),
    board_place VARCHAR(20),
    origin VARCHAR(40),
    destination VARCHAR(40),
    adult INT,
    children INT,
    total_fare DECIMAL(7,2),
    route_id INT,
    FOREIGN KEY (fleet_id) REFERENCES fleet_header(fleet_id),
    FOREIGN KEY (route_id) REFERENCES route_header(route_id)
);
 
CREATE TABLE ticket_detail (
    ticket_no INT,
    name VARCHAR(20),
    sex CHAR(1),
    age INT,
    fare DECIMAL(5,2)
);

CREATE TABLE route_detail (
    route_id INT,
    place_id INT,
    nonstop CHAR(1)
    -- FOREIGN KEY (route_id) REFERENCES route_header(route_id),
    -- FOREIGN KEY (place_id) REFERENCES place_header(place_id)
);

ALTER TABLE category_header MODIFY cat_desc VARCHAR(50);

CREATE TABLE Student_MPSTME (
    student_number INT NOT NULL,
    student_name VARCHAR(100),
    student_address VARCHAR(255),
    student_phone_number VARCHAR(15)
);

ALTER TABLE Student_MPSTME ADD PRIMARY KEY (student_number);

CREATE TABLE Student_NMIMS AS
SELECT student_number, student_name
FROM Student_MPSTME;

RENAME TABLE Student_MPSTME TO Stu_MPSTME;

ALTER TABLE Stu_MPSTME DROP COLUMN student_phone_number;

DROP TABLE Stu_MPSTME;

INSERT INTO category_header (cat_code, cat_desc)
VALUES
    (01, 'super deluxe'),
    (02, 'delux'),
    (03, 'super fast'),
    (04, 'normal');
    
select* from category_header;

INSERT INTO route_header (route_id, route_no, cat_code, origin, destination, fare, distance, capacity)
VALUES
    (101, 33, 01, 'Madurai', 'Madras', 35, 250, 50),
    (102, 25, 02, 'Trichy', 'Madurai', 40, 159, 50),
    (103, 15, 03, 'Thanjavur', 'Madurai', 59, 140, 50),
    (104, 08, 01, 'Madras', 'Banglore', 79, 375, 50),
    (105, 40, 01, 'Banglore', 'Madras', 79, 375, 50),
    (106, 23, 03, 'Hydrabad', 'Madras', 50, 430, 50),
    (107, 41, 03, 'Madras', 'Cochin', 47, 576, 50);
select* from route_header;

INSERT INTO place_header (place_id, place_name, place_address, bus_station)
VALUES
    (01, 'Madras', '10, ptc road', 'Parrys'),
    (02, 'Madurai', '21, canal bank road', 'Kknagar'),
    (03, 'Trichy', '11, first cross road', 'Bheltown'),
    (04, 'Banglore', '15, first main road', 'CubbonPark'),
    (05, 'Hydrabad', '14, lake view road', 'Charminar'),
    (06, 'Thanjavur', '12, temple road', 'RailwayJn');
select* from place_header;

INSERT INTO fleet_header (fleet_id, day, route_id, cat_code)
VALUES
    (01, '1996-04-10', 101, 01),
    (02, '1996-04-10', 101, 01),
    (03, '1996-04-10', 101, 01),
    (04, '1996-04-10', 102, 02),
    (05, '1996-04-10', 102, 03),
    (06, '1996-04-10', 103, 04);
select* from fleet_header;    

INSERT INTO ticket_header (fleet_id, ticket_no, doi, dot, time_travel, board_place, origin, destination, adult, children, total_fare, route_id)
VALUES
    (01, 1, '1996-04-10', '1996-05-10', '15:00:00', 'Parrys', 'Madras', 'Madurai', 1, 1, 60, 101),
    (02, 2, '1996-04-12', '1996-05-05', '09:00:00', 'Kknagar', 'Madurai', 'Madras', 1, 1, 60, 102),
    (03, 3, '1996-04-21', '1996-05-15', '21:00:00', 'Cubbon park', 'Banglore', 'Madras', 2, 2, 400, 101);
select* from ticket_header;    

INSERT INTO ticket_detail (ticket_no, name, sex, age, fare) 
VALUES (01, 'Charu', 'F', 24, 14.00),
       (01, 'Lathu', 'F', 10, 15.55),
       (02, 'Anand', 'M', 28, 17.80),
       (02, 'Guatham', 'M', 28, 16.00),
       (02, 'Bala', 'M', 09, 17.65),
       (05, 'Sandip', 'M', 30, 18.00); 
select* from ticket_detail;

INSERT INTO route_detail (route_id, place_id, nonstop) VALUES
    (105, 01, 'N'),
    (012, 02, 'S'),
    (106, 01, 'S'),
    (109, 05, 'N'),
    (106, 02, 'N');
select* from route_detail;

SELECT place_name, place_address FROM place_header; -- 2
SELECT total_fare, total_fare + 10 AS new_fare FROM ticket_header; -- 3
SELECT DISTINCT destination FROM route_header; -- 4
DESCRIBE route_detail; -- 5
UPDATE ticket_detail  SET fare = fare + 1  WHERE name = 'Gautam'; -- 6
UPDATE ticket_detail  SET age = 30  WHERE name = 'Anand'; -- 7
INSERT INTO route_detail (route_id, place_id, nonstop) 
VALUES (105, 01, 'S'); -- 8
DELETE FROM route_detail 
WHERE route_id = 105 AND place_id = 01 AND nonstop = 'S'; -- 9



