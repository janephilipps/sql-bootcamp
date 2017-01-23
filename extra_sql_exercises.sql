--EXTRA SQL PRACTICE

-- What is the average price of a track
SELECT AVG(unitprice)
FROM track;

-- Answer
-- AVG(unitprice)
-- ----------------
-- 1.05080502426483


-- What's the name of the oldest employee
SELECT firstname, lastname, birthdate
FROM employee
ORDER BY birthdate
LIMIT 1;

-- Answer
-- FirstName   LastName    BirthDate
-- ----------  ----------  -------------------
-- Margaret    Park        1947-09-19 00:00:00


-- How many hours of content are in the iTunes library?
SELECT SUM(milliseconds) / 1000.0 / 60.0 /60.0 AS hours
FROM track;

-- Answer
-- hours
-- ----------
-- 382.9939


-- How many customers use a yahoo email address
SELECT COUNT(*)
FROM customer
WHERE email LIKE '%@yahoo%' -- don't assume .com
LIMIT 10000;

-- Answer
-- COUNT(*)
-- ----------
-- 18

-- How many different countries have been invoiced?
SELECT COUNT(DISTINCT billingcountry)
FROM invoice
LIMIT 1000;

-- Answer
-- COUNT(DISTINCT billingcountry)
-- ------------------------------
-- 24


-- How many customers don't have a State in their customer profiles?
SELECT COUNT(*)
FROM customer
WHERE state IS NULL;

-- Answer
-- COUNT(*)
-- ----------
-- 29

-- Which Genre name has the fewest tracks?
SELECT g.name, COUNT(*)
FROM track t
JOIN genre g
    ON t.genreid = g.genreid
GROUP BY g.name
ORDER BY COUNT(*)
LIMIT 1;

-- Answer
-- Name        COUNT(*)
-- ----------  ----------
-- Opera       1

-- What is the most number of tracks on an album?
SELECT a.title, ar.name, COUNT(t.name)
FROM album a
JOIN track t
    ON t.albumid = a.albumid
JOIN artist ar
    ON ar.artistid = a.artistid
GROUP BY a.title
ORDER BY COUNT(t.name) DESC
LIMIT 10;

-- Answer
-- Title          Name           COUNT(t.name)
-- -------------  -------------  -------------
-- Greatest Hits  Lenny Kravitz  57
-- Minha Histori  Chico Buarque  34
-- Unplugged      Eric Clapton   30
-- Lost, Season   Lost           26
-- Lost, Season   Lost           25
-- The Office, S  The Office     25
-- Battlestar Ga  Battlestar Ga  24
-- Lost, Season   Lost           24
-- My Way: The B  Frank Sinatra  24
-- Afrociberdeli  Chico Science  23



-- What is the name of the longest R&B/Soul track?
SELECT t.name, t.milliseconds
FROM track t
JOIN genre g
    ON t.genreid = g.genreid
WHERE g.name = 'R&B/Soul'
ORDER BY t.milliseconds DESC
LIMIT 1;

-- Answer
-- Name                    Milliseconds
-- ----------------------  ------------
-- Rehab (Hot Chip Remix)  418293


-- What are the names of the music videos?
SELECT t.name, g.name, m.name
FROM track t
JOIN mediatype m
    ON t.mediatypeid = m.mediatypeid
JOIN genre g
    ON t.genreid = g.genreid
WHERE g.name NOT IN(
    'Science Fiction',
    'TV Shows',
    'Sci Fi & Fantasy',
    'Drama',
    'Comedy'
) AND m.name LIKE '%video%'
LIMIT 100;

-- Answer
-- Name                                            Name         Name
-- ----------------------------------------------  -----------  ---------------------------
-- Band Members Discuss Tracks from "Revelations"  Alternative  Protected MPEG-4 video file













