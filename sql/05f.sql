SELECT f.title
FROM film AS f
JOIN film_category AS fc1
    ON f.film_id = fc1.film_id
JOIN film_category AS fc2
    ON fc1.category_id = fc2.category_id
JOIN film AS reference_film
    ON fc2.film_id = reference_film.film_id
WHERE reference_film.title = 'AMERICAN CIRCUS'
GROUP BY f.film_id, f.title
HAVING COUNT(DISTINCT fc1.category_id) >= 2

INTERSECT

SELECT f.title
FROM film AS f
JOIN film_actor AS fa1
    ON f.film_id = fa1.film_id
JOIN film_actor AS fa2
    ON fa1.actor_id = fa2.actor_id
JOIN film AS reference_film
    ON fa2.film_id = reference_film.film_id
WHERE reference_film.title = 'AMERICAN CIRCUS'

ORDER BY title;
/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
