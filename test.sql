-- SQLite

DROP TABLE IF EXISTS test;
CREATE TABLE "test" (
                        "city" INTEGER,                          
                        "data" TEXT,
                        "temperature" INTEGER DEFAULT 1,
                        CONSTRAINT pk_test PRIMARY KEY (city, data));

INSERT INTO "test" (city, data)
    VALUES (1, datetime());
INSERT INTO test (city, data)
    VALUES (2, datetime());
INSERT INTO test (city, data)
    VALUES (3, datetime());
INSERT INTO test (city, data)
    VALUES (1, datetime('now','-1 month'));
INSERT INTO test (city, data)
    VALUES (2, datetime('now', '-1 day'));
INSERT INTO test (city, data)
    VALUES (3, datetime('now', '-2 year'));
INSERT INTO test (city, data)
    VALUES (1, datetime('now','+1 month'));
INSERT INTO test (city, data)
    VALUES (2, datetime('now', '+1 day'));
INSERT INTO test (city, data)
    VALUES (3, datetime('now', '+2 year'));
INSERT INTO test (city, data)
    VALUES (4, datetime('now'));

SELECT *
FROM test;

WITH find_last_two(city, data) AS (
    WITH max_cte (city, data) AS
        (SELECT city, MAX(data) 
        FROM test
        GROUP BY city)
    SELECT city, data
    FROM max_cte
    UNION ALL
    SELECT city, MAX(data) 
    FROM
    (SELECT city, data
    FROM test
    EXCEPT
    SELECT city, data
    FROM max_cte)
    GROUP BY city)
DELETE FROM test as t
WHERE EXISTS (SELECT * FROM find_last_two WHERE city = t.city AND data = t.data);

SELECT *
FROM test;
