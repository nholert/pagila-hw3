SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film_category
        ON film_actor.film_id = film_category.film_id
    JOIN category
        ON film_category.category_id = category.category_id
    WHERE category.name = 'Children'
)
AND actor.actor_id NOT IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film_category
        ON film_actor.film_id = film_category.film_id
    JOIN category
        ON film_category.category_id = category.category_id
    WHERE category.name = 'Horror'
)
ORDER BY actor.actor_id;
/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
