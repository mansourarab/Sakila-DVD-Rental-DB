/*Query Slide-2: This code is to return the total earnings by each store */

SELECT s.store_id AS Store,
SUM (p.amount) AS Earnings
FROM payment AS p                                                                               
JOIN staff AS s
	ON s.staff_id = p.staff_id
GROUP BY 1;

