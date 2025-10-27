USE world;
SELECT * FROM country;

SELECT Continent, COUNT(*) FROM country
GROUP BY Continent;

SELECT Continent, COUNT(*) FROM country
GROUP BY Continent ORDER BY COUNT(*) DESC;

SELECT 
	Continent,
    COUNT(*),
    ROUND(AVG(Population)/1000000, 0) AS 인구수,
    AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY 인구수 DESC;

SELECT 
	Continent,
    Region,
    COUNT(*)
FROM country
GROUP BY Continent, Region
ORDER BY Continent, COUNT(*);

SELECT Continent, COUNT(*)
FROM country
WHERE Population >= 100000000
GROUP BY Continent;

SELECT Continent, AVG(Population)
FROM country
GROUP BY Continent
HAVING AVG(Population) > 20000000;

USE sakila;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

SELECT rating, COUNT(*), ROUND(AVG(rental_rate),2) AS 평균대여료, MAX(rental_rate), MIN(rental_rate)
FROM film
GROUP BY rating
ORDER BY 평균대여료 DESC;

SELECT rating, COUNT(*), AVG(rental_rate)
FROM film
GROUP BY rating
HAVING COUNT(*) >= 200;

SELECT rating, COUNT(*), AVG(rental_rate)
FROM film
WHERE rental_rate >= 2.99
GROUP BY rating
HAVING COUNt(*) >= 50;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;
