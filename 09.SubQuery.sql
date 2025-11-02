USE world;

SELECT Population FROM city WHERE Name = 'SEOUL';

-- 서울 인구보다 많은 도시
SELECT *
FROM city
WHERE Population > (SELECT Population FROM city WHERE Name = 'SEOUL');

SELECT Name, Population
FROM country
WHERE Population > (SELECT AVG(Population) FROM country)
ORDER BY Population DESC;

SELECT Code
FROM country
WHERE Continent = 'Asia';

SELECT Name, CountryCode, Population FROM city
WHERE CountryCode IN (SELECT Code FROM country WHERE Continent = 'Asia');

SELECT DISTINCT CountryCode FROM city;

SELECT * FROM country WHERE Code NOT IN (SELECT DISTINCT CountryCode FROM city);

-- FROM 절의 서브쿼리(인라인 뷰)
SELECT *
FROM (
	SELECT Continent, COUNT(*) AS co_count
    FROM country 
    GROUP BY Continent
) AS continent_table
WHERE co_count > 40;

USE sakila;
-- 평균 대여료보다 비싼 영화를 조회하세요
-- 영화 제목, 대여료, 대여료 내림차순 정렬, 상위 10개
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate desc
LIMIT 10;

-- Action 카테고리에 속한 영화를 조회
-- 영화제목
SELECT title
FROM film INNER JOIN film_category ON film.film_id = film_category.film_id
WHERE film_category.category_id IN(SELECT category_id FROM category WHERE name = 'Action');

SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = 'Action'));

-- 대여 기록이 있는 고객만 조회
-- 고객 이름, 이메일
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id FROM rental);

SELECT first_name, last_name, email
FROM customer
WHERE EXISTS (SELECT * FROM rental WHERE customer.customer_id = rental.customer_id);

-- 고객별 대여 횟수를 구한 뒤, 대여 횟수가 30회 이상인 고객만 조회
-- 고객 이름, 대여 횟수, 대여 횟수 내림차순
SELECT *
FROM (
	SELECT c.first_name, c.last_name, COUNT(*) AS 대여횟수
    FROM customer c INNER JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
) AS count_table
WHERE 대여횟수 >= 30
ORDER BY 대여횟수 DESC;