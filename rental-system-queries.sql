/* 1 */
INSERT INTO rental_records VALUES(
NULL,
'SBA1111A',
(
SELECT customer_id
FROM customers
WHERE name = 'Angel'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL
)

/* 2 */
INSERT INTO rental_records VALUES(
NULL,
'GA5555E',
(
SELECT customer_id
FROM customers
WHERE name = 'Kumar'
),
DATE_ADD(CURDATE(), INTERVAL 1 DAY),
DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 3 MONTH),
NULL
)

/* 3 */
SELECT 
rental_records.start_date,
rental_records.end_date,
rental_records.veh_reg_no,
vehicles.brand,
vehicles.category,
customers.name
FROM rental_records,
vehicles,
customers
WHERE customers.customer_id = rental_records.customer_id
AND rental_records.veh_reg_no = vehicles.veh_reg_no
ORDER BY category, start_date;

/* 4 */
SELECT *
FROM rental_records
WHERE end_date < CURDATE();

/* 5 */
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers,
vehicles
WHERE
customers.customer_id = rental_records.customer_id
AND rental_records.veh_reg_no = vehicles.veh_reg_no
AND start_date < '2012-01-10'
AND end_date > '2012-01-10';

/* 6 */
/* Not sure if the question meant rentals that started today, or vehicles that have active rentals as of today. I queried the latter. */
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers,
vehicles
WHERE
customers.customer_id = rental_records.customer_id
AND rental_records.veh_reg_no = vehicles.veh_reg_no
AND start_date <= CURDATE()
AND end_date >= CURDATE();

/* 7 */
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers,
vehicles
WHERE
customers.customer_id = rental_records.customer_id
AND rental_records.veh_reg_no = vehicles.veh_reg_no
AND (
(start_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(end_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(start_date < '2012-01-03' AND end_date > '2012-01-18')
);

/* 8 */
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT veh_reg_no
FROM rental_records
WHERE start_date < '2012-01-10'
AND end_date > '2012-01-10'
);
 
/* 9 */
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT
veh_reg_no
FROM rental_records
WHERE (
(start_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(end_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(start_date < '2012-01-03' AND end_date > '2012-01-18')
)
);

/* 10 */
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT
veh_reg_no
FROM rental_records
WHERE (
(start_date BETWEEN CURDATE() 
AND 
DATE_ADD(CURDATE(), INTERVAL 10 DAY))
)
);








