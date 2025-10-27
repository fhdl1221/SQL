## 실습 준비
### 데이터셋 소개
주요 컬럼
- survived: 생존 여부 (0: 사망, 1: 생존)
- pclass: 티켓 등급 (1: 1등석, 2: 2등석, 3: 3등석)
- sex: 성별 (male, female)
- age: 나이
- sibsp: 동승한 형제자매/배우자 수
- parch: 동승한 부모/자녀 수
- ticket: 티켓 번호
- fare: 요금
- cabin: 객실 번호
- embarked: 탑승 항구 (C: Cherbourg, Q: Queenstown, S: Southampton)

## 1. 데이터 기본 탐색
### 문제 1-1: 상위 5행 조회
타이타닉 테이블에서 모든 컬럼의 상위 5개 행을 조회하세요.
```
USE temp;
SELECT * FROM titanic;

-- 1-1
SELECT * FROM titanic 
LIMIT 5;

-- 1-2
SELECT COUNT(*) AS row_count 
FROM titanic;

-- 1-3
SELECT SUM(
	CASE
		WHEN Cabin = '' THEN 1
        ELSE 0
	END
) 
FROM titanic;

-- 1-4
SELECT MIN(Fare), MAX(Fare), ROUND(AVG(Fare),2)
FROM titanic;

-- 2-1
SELECT name, ticket, fare
FROM titanic
WHERE pclass = 1;

-- 2-2
SELECT * 
FROM titanic 
WHERE embarked = 'C';

-- 2-3
SELECT name, age, sex 
FROM titanic 
WHERE age < 30 AND survived = 1;

-- 2-4
SELECT name, pclass, fare
FROM titanic
ORDER BY fare DESC;

-- 2-5
SELECT name, age, fare
FROM titanic
WHERE pclass = 1
AND sex = 'female'
ORDER BY age;

-- 3-1
SELECT
	ROUND(
		SUM(CASE
				WHEN survived = 1 THEN 1
				ELSE 0
			END) / COUNT(*) * 100, 2) AS 전체생존률
FROM titanic;

SELECT survived, COUNT(*)
FROM titanic
GROUP BY survived;

-- 3-2
SELECT
	sex,
	COUNT(*) AS 총승객수,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS 생존자수,
    ROUND(SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS 생존율
FROM titanic
GROUP BY sex
ORDER BY 생존율 DESC;

-- 3-3
SELECT 
	pclass,
    ROUND(SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS 생존율
FROM titanic
GROUP BY pclass
ORDER BY pclass;

SELECT
	pclass,
    AVG(fare),
    MIN(fare),
    MAX(fare)
FROM titanic
GROUP BY pclass
ORDER BY pclass;

-- 3-4
SELECT embarked, pclass, COUNT(*) AS 승객수
FROM titanic
WHERE embarked != ''
GROUP BY embarked, pclass
ORDER BY embarked, pclass;

-- 3-5
SELECT
	pclass,
    sex,
	COUNT(*),
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS 생존자수,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
GROUP BY pclass, sex
ORDER BY pclass, sex;

-- 3-6
SELECT
	CASE
		WHEN SibSp + Parch = 0 THEN '혼자'
        ELSE '가족동반'
	END AS 가족동반유무,
	SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
GROUP BY 가족동반유무;

SELECT
	SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
WHERE SibSp > 0 OR Parch > 0;

-- 3-7
SELECT 
	(1 + SibSp + Parch) AS 가족규모,
	COUNT(*) AS 승객수,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
GROUP BY 가족규모
ORDER BY 가족규모;

-- 4-1
SELECT
	CASE
		WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 60 THEN 'Adult'
        ElSE 'Senior'
	END AS 연령대,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
GROUP BY 연령대;

-- 4-2
SELECT
	CASE
		WHEN fare < 10 THEN '저가(<10)'
        WHEN fare >= 10 AND fare < 30 THEN '중저가(10-29)'
        WHEN fare >= 30 AND fare < 100 THEN '중고가(30-99)'
        ELSE '고가(100+)'
    END AS 요금구간,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS 생존율
FROM titanic
GROUP BY 요금구간
ORDER BY
	CASE
		WHEN 요금구간 = '저가(<10)' THEN 1
        WHEN 요금구간 = '중저가(10-29)' THEN 2
        WHEN 요금구간 = '중고가(30-99)' THEN 3
        ELSE 4
	END;

-- 4-3
SELECT
	pclass,
    AVG(fare) AS 평균요금
FROM titanic
GROUP BY pclass
HAVING 평균요금 > 50;

-- 4-4
SELECT 
	name,
    pclass,
    fare,
    (SELECT AVG(fare) FROM titanic) AS 전체평균요금
FROM titanic
WHERE fare > (SELECT AVG(fare) FROM titanic)
ORDER BY fare
LIMIT 20;

-- 4-5
SELECT
	name,
    age,
    pclass,
    (SELECT AVG(age) FROM titanic WHERE pclass = 3) AS 3등석평균나이
FROM titanic
WHERE pclass = 1 AND age > (SELECT AVG(age) FROM titanic WHERE pclass = 3)
ORDER BY age DESC
LIMIT 20;
