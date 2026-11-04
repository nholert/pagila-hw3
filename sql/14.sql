WITH rental_counts AS (
    SELECT
        c.category_id,
        c.name,
        f.film_id,
        f.title,
        COUNT(r.rental_id) AS "total rentals"
    FROM category AS c
    JOIN film_category AS fc
        ON c.category_id = fc.category_id
    JOIN film AS f
        ON fc.film_id = f.film_id
    LEFT JOIN inventory AS i
        ON f.film_id = i.film_id
    LEFT JOIN rental AS r
        ON i.inventory_id = r.inventory_id
    GROUP BY
        c.category_id,
        c.name,
        f.film_id,
        f.title
),
ranked_films AS (
    SELECT
        name,
        title,
        "total rentals",
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY "total rentals" DESC, film_id DESC
        ) AS film_rank
    FROM rental_counts
)
SELECT
    name,
    title,
    "total rentals"
FROM ranked_films
WHERE film_rank <= 5
ORDER BY name, "total rentals" DESC, title;
/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
