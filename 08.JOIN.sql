USE world;

SELECT * FROM city WHERE CountryCode = 'KOR';
SELECT * FROM country WHERE Code = 'KOR';

SELECT ci.Name AS 도시명, 
co.Name AS 나라명, 
co.Continent AS 대륙, 
ci.Population AS 도시인구수, 
co.Population AS 나라인구수, 
ROUND((ci.Population / co.Population) * 100, 2) AS 도시인구비율
FROM city ci INNER JOIN country co 
ON ci.CountryCode = co.Code
WHERE co.Name = 'South Korea';

SELECT
	co.Name AS 나라명,
    COUNT(*) AS 도시개수
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY 도시개수;

SELECT
	co.Continent AS 대륙,
    COUNT(*),
    AVG(ci.Population)
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Continent;

SELECT
	COUNT(DISTINCT co.Code) AS 전체국가수_join,
    (SELECT COUNT(*) FROM country) AS 전체국가수_country
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code;

SELECT
	*
FROM country co LEFT JOIN city ci
ON co.Code = ci.CountryCode
ORDER BY co.Population;

SELECT c1.Name, c2.Name
FROM city c1 INNER JOIN city c2
ON c1.CountryCode = c2.CountryCode AND c1.ID < c2.ID
WHERE c1.CountryCode = 'KOR';

SELECT *
FROM country co INNER JOIN city ci ON co.Code = ci.CountryCode
	INNER JOIN countrylanguage cl ON ci.CountryCode = cl.CountryCode;
    
USE sakila;
SELECT * FROM film;
SELECT * FROM language;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM store;
SELECT * FROM rental;

-- 영화(film)와 언어(language) 테이블을 조인하여 영화 제목, 언어 이름을 조회
SELECT film.title, language.name
FROM film INNER JOIN language
ON film.language_id = language.language_id;

-- 영화와 카테고리를 조인하여 영화 제목, 카테고리 이름, 대여료를 조회
SELECT film.title, category.name, film.rental_rate
FROM film INNER JOIN film_category ON film.film_id = film_category.film_id
	INNER JOIN category ON film_category.category_id = category.category_id;
    
-- 모든 고객(customer)과 그들의 대여 내역(rental)을 사용하여 고객 이름(first_name, last_name), 대여 ID, 대여 날짜 조회
SELECT cu.first_name, cu.last_name, re.rental_id, re.rental_date
FROM customer cu LEFT JOIN rental re ON cu.customer_id = re.customer_id;

-- 고객별 대여 횟수를 조회(대여 횟수가 0인 고객도 포함)
-- 고객 이름, 대여 횟수, 대여 횟수가 많은 순서로 정렬
SELECT customer.first_name, COUNT(*) AS 대여횟수
FROM customer LEFT JOIN rental
ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY 대여횟수 DESC;

-- 같은 상영 시간을 가진 영화 쌍을 찾으세요.
-- 영화1 제목, 영화2 제목, 상영 시간, 상위10개
SELECT f1.title, f2.title, f1.length
FROM film f1 INNER JOIN film f2
ON f1.length = f2.length
ORDER BY f1.length DESC
LIMIT 10;