USE world;

SELECT * FROM country WHERE Code = 'AFG';

SELECT * FROM country WHERE Name  = 'South Korea';
SELECT * FROM country WHERE Continent = 'Asia';

SELECT * FROM country WHERE LifeExpectancy >= 80;
SELECT * FROM country WHERE GNP < 10000;

SELECT * FROM country WHERE Continent = 'Asia' AND  Population >= 100000000;
SELECT * FROM country WHERE Continent = 'Europe' OR Continent = 'North America';

SELECT * FROM country WHERE Continent != 'Asia';
SELECT * FROM country WHERE NOT Continent = 'Asia';

SELECT * FROM country WHERE LifeExpectancy >= 70 AND LifeExpectancy <= 80;
SELECT * FROM country WHERE LifeExpectancy BETWEEN 70 AND 80;

SELECT * FROM country WHERE Continent IN ('Asia', 'Europe');

SELECT * FROM country WHERE Name LIKE 'South%';
SELECT * FROM ountry WHERE NAME LIKE '%States%';
SELECT * FROM country WHERE NAME LIKE '_____';
SELECT * FROM country WHERE NAME LIKE '___land';

SELECT * FROM country WHERE GNPOld IS NULL;
SELECT * FROM country WHERE IndepYear IS NOT NULL;


-- 연습문제 
USE sakila;

SELECT * FROM film;

SELECT title, rental_rate FROM film WHERE rental_rate >= 4;
SELECT * FROM film WHERE length < 120;
SELECT * FROM film WHERE rating = 'PG-13';
SELECT * FROM film WHERE rating = 'PG' AND rental_rate >= 3;
SELECT * FROM film WHERE rating = 'G' OR rating = 'PG';
SELECT * FROM film WHERE length < 60 OR length >= 180;
SELECT * FROM film WHERE title LIKE '%LOVE%';
SELECT * FROM film WHERE title LIKE 'THE%';
SELECT * FROM actor WHERE last_name LIKE '%SON';
SELECT * FROM film 
	WHERE rating = 'PG-13' 
    AND rental_rate BETWEEN 2.99 AND 4.99 
    AND length >= 90;

SELECT * FROM address;
SELECT * FROM address WHERE district = 'California';
SELECT address, postal_code, phone FROM address WHERE city_id >= 300;
SELECT * FROM address WHERE postal_code IS NULL;
