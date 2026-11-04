SELECT f.title
FROM film AS f
JOIN film_actor AS fa1
    ON f.film_id = fa1.film_id
JOIN film_actor AS fa2
    ON fa1.actor_id = fa2.actor_id
JOIN film AS f2
    ON fa2.film_id = f2.film_id
WHERE f2.title IN (
    'AMERICAN CIRCUS',
    'ACADEMY DINOSAUR',
    'AGENT TRUMAN'
)
GROUP BY f.film_id, f.title
HAVING COUNT(*) >= 3
ORDER BY f.title;
/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */
