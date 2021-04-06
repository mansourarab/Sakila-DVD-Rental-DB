/*Query Slide-3: This code is to return the top 10 actors which thier movies were top rented from both stores*/

WITH Actor_info AS (SELECT (fa.actor_id) AS Actor_ID, CONCAT(a.first_name,' ',a.last_name) AS Actor_Fullname, fa.film_id AS Film_ID
					FROM actor AS a
					JOIN film_actor AS fa                            /* This is a subquery to make a column wiht the full name of the actors */
						ON fa.actor_id = a.actor_id
					ORDER BY 1),
					
	Rent_info AS (SELECT DISTINCT   i.film_id AS Film_ID, COUNT(r.rental_id) OVER (PARTITION BY i.film_id) AS Ren_Times 
					FROM inventory AS i
					JOIN rental AS r                                /* This is a subquery to count the renting times for each movie from both stores  */
						ON i.inventory_id = r.inventory_id)

SELECT ai.Actor_Fullname, SUM(ri.ren_times) AS Number_of_Rented_Movies
FROM rent_info AS ri
JOIN actor_info AS ai
	ON ai.Film_id = ri.Film_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;