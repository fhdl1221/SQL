USE world;

SELECT * FROM country;
SELECT COUNT(*) AS 총국가수 FROM country;
SELECT COUNT(LifeExpectancy) FROM country;

SELECT COUNT(DISTINCT Continent) FROM country;

SELECT SUM(Population) AS 총인구수 FROM country;

SELECT SUM(Population) FROM country
WHERE Continent = 'Asia';

SELECT SUM(Population) FROM country
WHERE Population >= 100000000;

-- ROUND : 반올림 
SELECT ROUND(SUM(SurfaceArea) / 1000) FROM country;

SELECT AVG(Population) FROM country
WHERE Continent = 'Asia';

SELECT MAX(Population) AS 최대 FROM country;
-- 서브쿼리 (괄호 안에 있는게 먼저 실행되고 그 결과를 바깥에서 사용)
SELECT * FROM country WHERE Population = (SELECT MAX(Population) FROM country);

SELECT 
	COUNT(*),
    SUM(Population),
    AVG(Population),
    MAX(Population),
    MIN(Population)
FROM country;

SELECT LifeExpectancy FROM country;

SELECT AVG(LifeExpectancy) FROM country;
SELECT COALESCE(LifeExpectancy, 66) FROM country;
SELECT AVG(COALESCE(LifeExpectancy, 50)) FROM country;


-- 연습문제
 USE sakila;
 SELECT * FROM film;
 
 SELECT COUNT(*) FROM film;
 SELECT COUNT(*) FROM film WHERE rating = 'PG';
 SELECT COUNT(DISTINCT rating) FROM film;
 SELECT SUM(rental_rate) FROM film;
 SELECT ROUND(AVG(rental_rate), 2) FROM film;
 SELECT AVG(rental_rate) FROM film WHERE rating = 'R';
 SELECT title FROM film WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);
 SELECT title FROM film WHERE length = (SELECT MAX(length) FROM film);
 SELECT 
	COUNT(*) AS 전체영화수,
    SUM(rental_rate) AS 대여료합계,
    AVG(rental_rate) AS 평균대여료,
    MAX(rental_rate) AS 최고대여료,
    MIN(rental_rate) AS 최저대여료,
    AVG(length) AS 평균상영시간
 FROM film;