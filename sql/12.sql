WITH recent_rentals AS (
    SELECT
        r.customer_id,
        r.inventory_id,
        ROW_NUMBER() OVER (
            PARTITION BY r.customer_id
            ORDER BY r.rental_date DESC, r.rental_id DESC
        ) AS rental_rank
    FROM rental AS r
),
action_counts AS (
    SELECT
        rr.customer_id,
        COUNT(*) FILTER (
            WHERE c.name = 'Action'
        ) AS action_count
    FROM recent_rentals AS rr
    JOIN inventory AS i
        ON rr.inventory_id = i.inventory_id
    JOIN film_category AS fc
        ON i.film_id = fc.film_id
    JOIN category AS c
        ON fc.category_id = c.category_id
    WHERE rr.rental_rank <= 5
    GROUP BY rr.customer_id
)
SELECT
    cu.customer_id,
    cu.first_name,
    cu.last_name
FROM customer AS cu
JOIN action_counts AS ac
    ON cu.customer_id = ac.customer_id
WHERE ac.action_count >= 4
ORDER BY cu.customer_id;
/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
