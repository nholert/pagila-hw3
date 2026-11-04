WITH bacall_1 AS (
    SELECT DISTINCT fa2.actor_id
    FROM actor AS a
    JOIN film_actor AS fa1
        ON a.actor_id = fa1.actor_id
    JOIN film_actor AS fa2
        ON fa1.film_id = fa2.film_id
    WHERE a.first_name = 'RUSSELL'
      AND a.last_name = 'BACALL'
      AND fa2.actor_id <> a.actor_id
),
bacall_2 AS (
    SELECT DISTINCT fa2.actor_id
    FROM bacall_1 AS b1
    JOIN film_actor AS fa1
        ON b1.actor_id = fa1.actor_id
    JOIN film_actor AS fa2
        ON fa1.film_id = fa2.film_id
    WHERE fa2.actor_id NOT IN (
        SELECT actor_id FROM bacall_1
    )
    AND fa2.actor_id NOT IN (
        SELECT actor_id
        FROM actor
        WHERE first_name = 'RUSSELL'
          AND last_name = 'BACALL'
    )
)
SELECT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor AS a
JOIN bacall_2 AS b2
    ON a.actor_id = b2.actor_id
ORDER BY "Actor Name";
/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
