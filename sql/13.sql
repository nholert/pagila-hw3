WITH film_revenue AS (
    SELECT
        f.film_id,
        f.title,
        COALESCE(SUM(p.amount), 0) AS revenue
    FROM film AS f
    LEFT JOIN inventory AS i
        ON f.film_id = i.film_id
    LEFT JOIN rental AS r
        ON i.inventory_id = r.inventory_id
    LEFT JOIN payment AS p
        ON r.rental_id = p.rental_id
    GROUP BY f.film_id, f.title
),
actor_films AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        fr.film_id,
        fr.title,
        ROW_NUMBER() OVER (
            PARTITION BY a.actor_id
            ORDER BY fr.revenue DESC, fr.film_id
        ) AS rank,
        fr.revenue
    FROM actor AS a
    JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
    JOIN film_revenue AS fr
        ON fa.film_id = fr.film_id
)
SELECT
    actor_id,
    first_name,
    last_name,
    film_id,
    title,
    rank,
    revenue
FROM actor_films
WHERE rank <= 3
ORDER BY actor_id, rank, film_id;
/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
