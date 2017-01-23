-- SQL BOOTCAMP 1/20/17

-- Gets first 10 results from Album table
-- SELECT *
-- FROM Album
-- LIMIT 10;

-- Exercise #1
-- What are the genres in the database?

-- SELECT Name
-- FROM Genre
-- LIMIT 10000;

-- What are the customer names that are from CA?

-- SELECT firstname, lastname, state
-- FROM customer
-- WHERE country='USA' AND state='CA';

-- SELECT *
-- FROM Invoice
-- WHERE BillingCountry='USA';

-- SELECT *
-- FROM Employee
-- LIMIT 50;

-- Exercise #2

-- How many songs are longer than 10 minutes?

-- SELECT COUNT(*)
-- FROM track
-- WHERE milliseconds > 600000; -- 10 * 60 * 1000

-- COUNT(*)
-- ----------
-- 260

-- How many invoices were there between January 1, 2010 and February 1,2010?

-- SELECT COUNT(*)
-- FROM invoice
-- WHERE invoicedate BETWEEN '2010-01-01' AND '2010-02-01';

-- Between can double count without timestamp

-- How many tracks have a NULL composer?

-- SELECT COUNT(*)
-- FROM track
-- WHERE composer IS NULL;

-- 978

-- SELECT COUNT(DISTINCT title)
-- FROM album;

-- SELECT COUNT(DISTINCT albumid)
-- from album;

-- Exercise #3

-- What are the 5 longest songs?

-- SELECT name, milliseconds/1000.0/60.0 -- make the data in a more human readable format to see minutes, then you can identify outliers
-- FROM track
-- ORDER BY milliseconds DESC
-- LIMIT 10; -- if there's a tie for 5th place, you will only get 1 record with LIMIT 5

-- Can you find which artists R.E.M. have collaborated with?

-- SELECT *
-- FROM track
-- WHERE composer LIKE '%R.E.M.%';

-- SELECT name
-- FROM artist
-- WHERE name LIKE 'R.E.M. Feat.%';


-- How many 'Love' songs are there? (Use track name)

-- SELECT name
-- FROM track
-- WHERE name LIKE '%love%'
--     AND name NOT LIKE '%glove%';
    -- inspect results to see where pattern matching goes wrong - love might be contained in certain words like glove, rollover etc.

-- Look at edges of your data to find the outliers i.e. longest and shortest songs etc.

-- Exercise #4

-- CREATE TABLE krs_1 (
--     id INTEGER,
--     name VARCHAR(20),
--     alive BOOLEAN
-- );

-- Will only create table if it doesn't alreaedy exist
-- CREATE TABLE IF NOT EXISTS favorite_songs (
--     id INTEGER PRIMARY KEY,
--     title TEXT,
--     seconds INTEGER
-- );

-- Create table from a query
-- Take a sample of a large dataset as split it into a smaller table to more easily query
-- Sandbox, delete once you're done
-- CREATE TABLE IF NOT EXISTS favorite_tracks AS
--     SELECT *
--     FROM track
--     WHERE genreid=1;



-- INSERT INTO krs_1
-- (id, name,)
-- VALUES (2, 'David');

-- DROP TABLE IF EXISTS krs_1;

-- Exercise #5

-- How many tracks are rock or alternative?

-- SELECT COUNT(*)
-- FROM track
-- JOIN genre
--     ON track.genreid = genre.genreid
-- WHERE genre.name LIKE '%rock%' OR '%alternative%'


-- -- Using the IN operator is less expensive than using the LIKE operator for large datasets
-- SELECT COUNT(*)
-- FROM track
-- JOIN genre
--     ON track.genreid = genre.genreid
-- WHERE genre.name IN ('Rock', 'Alternative',
--                      'Rock And Roll',
--                      'Alternative & Punk');


-- How many tracks are performed by R.E.M. excluding collaborators?

-- SELECT COUNT(*)
-- FROM track
-- JOIN album
--     ON track.albumid = album.albumid
-- JOIN artist
--     ON album.artistid = artist.artistid
-- WHERE artist.name = 'R.E.M.'
-- LIMIT 100;

-- Answer
-- COUNT(*)
-- ----------
-- 41

-- How many tracks are performed by R.E.M. with collaborators?
-- SELECT COUNT(*)
-- FROM track
-- JOIN album
--     ON track.albumid = album.albumid
-- JOIN artist
--     ON album.artistid = artist.artistid
-- WHERE artist.name LIKE '%R.E.M.%'
-- AND artist.name NOT LIKE 'R.E.M.';

-- Answer
-- COUNT(*)
-- ----------
-- 11

-- What other interesting queries can you create that join 2 tables?

-- Exercise #6

-- What was the sales total for January 2010?

-- SELECT SUM(total)
-- FROM invoice
-- WHERE invoicedate >= '2010-01-01'
-- AND invoicedate <= '2010-01-31'; -- LIKE '2010-01-%'

-- Answer
-- SUM(total)
-- ----------
-- 52.62


-- What is the average length of a song by R.E.M.? (Convert results to minutes)


-- SELECT AVG(t.milliseconds/60.0/1000.0) AS minutes
-- FROM track t
-- JOIN album al
--     ON t.albumid = al.albumid
-- JOIN artist ar
--     ON al.artistid = ar.artistid
-- WHERE ar.name LIKE '%R.E.M.%';

-- Answer
-- minutes
-- ----------------
-- 4.04347884615385

-- ***
-- If you have a transaction between an integer and a float, it converts it to a float
-- Always divide by floats
-- ***

-- SELECT composer, COUNT(*)
-- FROM track
-- GROUP BY composer;

-- Exercise #7

SELECT al.title, ar.name, SUM(t.milliseconds/1000.0/60.0) AS minutes
FROM album al
JOIN artist ar
    ON ar.artistid = al.artistid
JOIN track t
    ON t.albumid = al.albumid
JOIN mediatype m
    ON m.mediatypeid = t.mediatypeid
WHERE m.name LIKE '%audio%'
GROUP BY ar.name, al.title
ORDER BY minutes DESC
LIMIT 10;

-- Answer
-- Title          Name           minutes
-- -------------  -------------  ----------------
-- Greatest Hits  Lenny Kravitz  251.095516666667
-- Unplugged      Eric Clapton   135.221266666667
-- Minha Histori  Chico Buarque  131.260716666667
-- Live After De  Iron Maiden    97.1309333333333
-- Instant Karma  U2             85.5814333333333
-- A Matter of L  Iron Maiden    79.2539833333333
-- A-Sides        Soundgarden    79.2004833333333
-- Load           Metallica      78.97675
-- BBC Sessions   Led Zeppelin   78.3184666666667
-- Pure Cult: Th  The Cult       77.5456666666667












