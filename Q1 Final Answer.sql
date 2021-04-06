/*Query Slide-1: This code is to count the orders made by each store for every month*/

SELECT DISTINCT st.store_id AS Store,
	   DATE_PART('month', r.rental_date) AS Rentalmonth,
	   DATE_PART('year',r.rental_date) AS Rentalyear, 
	   COUNT (r.rental_id) AS orders
FROM rental AS r                                                                               
JOIN staff AS st
	ON st.staff_id = r.staff_id
GROUP BY 1 , 2 , 3
ORDER BY 3, 2;