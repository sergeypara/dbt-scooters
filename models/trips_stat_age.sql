WITH t1 AS
(SELECT t.*, 
	u.birth_date, 
	(extract(YEAR FROM t.started_at)-EXTRACT(YEAR FROM u.birth_date)) AS age  FROM scooters_raw.trips AS t
 INNER JOIN scooters_raw.users AS u
 ON t.user_id = u.id)
SELECT age, avg(trips) AS avg_trips
FROM (
	SELECT 
	date (started_at) AS date,
	age,
	count(id) AS trips
	FROM t1
	GROUP BY 1, 2
	)
GROUP BY 1
ORDER BY 1