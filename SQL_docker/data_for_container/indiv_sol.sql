--Extra credit 1

--1,2.
SELECT m.*
FROM meals m
  JOIN (
      SELECT type
        ,AVG(price) AS avg_price
      FROM meals
      GROUP BY type
  ) am
  ON m.type = am.type
    AND m.price >= am.avg_price;

--3
SELECT m.type
  ,COUNT(m.meal_id) as meal_count
FROM meals m
  JOIN (
      SELECT type
        ,AVG(price) AS avg_price
      FROM meals
      GROUP BY type
  ) am
  ON m.type = am.type
    AND m.price >= am.avg_price
GROUP BY m.type;

--4
SELECT u.campaign_id
  ,COUNT(u.userid) / CAST(tu.total_user_count AS REAL) AS per_of_total
FROM users u
  INNER JOIN (
    SELECT COUNT(*) AS total_user_count
    FROM users
  ) tu
  ON 1 = 1
GROUP BY u.campaign_id
  ,tu.total_user_count
;

--extra credit 2

SELECT
