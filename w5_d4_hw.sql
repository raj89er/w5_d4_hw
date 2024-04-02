

-- 1. Create a Stored Procedure that will insert a new film into the film table with the following arguments: 
--title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating

CREATE OR REPLACE PROCEDURE InsertFilm(
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_release_year INTEGER,
    IN p_language_id INTEGER,
    IN p_rental_duration INTEGER,
    IN p_rental_rate DECIMAL(5, 2),
    IN p_length INTEGER,
    IN p_replace_cost DECIMAL(5, 2),
    IN mpaa_rating mpaa_rating
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
    VALUES (p_title, p_description, p_release_year, p_language_id, p_rental_duration, p_rental_rate, p_length, p_replace_cost, mpaa_rating, CURRENT_TIMESTAMP);
END;
$$;

CALL InsertFilm(
	'Cloud Atlas',
	'a very detailed movie for sci-fi fans that has gotten many confused',
	2012,
	1,
	14,
	5.99,
	172,
	29.99,
	'PG-13'
);

SELECT *
FROM film
WHERE title ILIKE "cloud atlas";

-- 2. Create a Stored Function that will take in a category_id and return the number of films in that category

SELECT COUNT(*) AS filmcount
FROM film_category
WHERE category_id = 1;

CREATE OR REPLACE FUNCTION num_film_in_cat(num_search INTEGER)
RETURNS integer
LANGUAGE plpgsql
AS $$
	DECLARE tempvar INTEGER;
BEGIN 
	SELECT COUNT(*) INTO tempvar
	FROM film_category
	WHERE category_id = num_search;
	RETURN tempvar;
END;
$$;

SELECT num_film_in_cat(5);




