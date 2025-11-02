USE temp;
CREATE TABLE accounts (
	id	INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10),
    balance INT
);

INSERT INTO accounts (name, balance) 
VALUES('kim', 100000);
INSERT INTO accounts (name, balance) 
VALUES('lee', 200000);

SELECT * FROM accounts;

START TRANSACTION;
UPDATE accounts SET balance = balance + 10000 WHERE id = 1;
UPDATE accounts SET balance = balance - 10000 WHERE id = 2;

COMMIT;
ROLLBACK;

INSERT INTO accounts (name, balance) VALUES ('hong', 0);
SAVEPOINT sp1;
INSERT INTO accounts (name, balance) VALUES ('choi', 9999999);
SAVEPOINT sp2;

ROLLBACK TO SAVEPOINT sp1;

SELECT @@autocommit;
SET autocommit = 0;

INSERT INTO accounts (name, balance) VALUES ('test', 0);
SET autocommit = 1;
