SELECT f.title
FROM film AS f
JOIN film_actor AS fa
    ON f.film_id = fa.film_id
JOIN film_actor AS fa2
    ON fa.actor_id = fa2.actor_id
JOIN film AS f2
    ON fa2.film_id = f2.film_id
WHERE f2.title = 'AMERICAN CIRCUS'
GROUP BY f.film_id, f.title
HAVING COUNT(DISTINCT fa.actor_id) >= 2
ORDER BY f.title;
/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
