SELECT film.title
FROM film_actor AS fa1
JOIN film_actor AS fa2
    ON fa1.actor_id = fa2.actor_id
JOIN film
    ON fa2.film_id = film.film_id
WHERE fa1.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'AMERICAN CIRCUS'
)
ORDER BY film.title;
/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */
