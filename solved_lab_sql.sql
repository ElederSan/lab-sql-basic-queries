-- Use the sakila database to do the following tasks:

USE sakila;
-- 1. Display all available tables in the Sakila database.

SHOW tables;
-- 2. Retrieve all the data from the tables actor, film and customer.
-- Actor: 
SELECT * FROM sakila.actor;
-- film: 
SELECT * FROM sakila.film;
-- customer
SELECT * FROM sakila.customer;

-- 3. Retrieve the following columns from their respective tables:

-- 3.1 Titles of all films from the film table:

SELECT title FROM film;

-- 3.2 List of languages used in films, with the column aliased as language from the language table

SELECT name AS "language" FROM sakila.language;

-- 3.3 List of first names of all employees from the staff table

SELECT first_name FROM sakila.staff;

-- 4. Retrieve unique release years.

SELECT distinct(release_year) FROM sakila.film;

-- 5. Counting records for database insights:

-- 5.1 Determine the number of stores that the company has.

SELECT count(distinct(store_id)) FROM sakila.store;

-- 5.2 Determine the number of employees that the company has. 

SELECT count(distinct(staff_id)) FROM sakila.staff;

-- 5.3 Determine how many films are available for rent and how many have been rented.

SELECT count(distinct(inventory_id)) AS "rented_movies" FROM sakila.rental WHERE return_date IS NULL;

-- I had to get some external help for the available movies, as I was trying with the same code as for rented but I was also getting all the records, as I was not able to discriminate between the return date NULL and NOT NULL
SELECT COUNT(*) AS available_films
FROM sakila.inventory
WHERE NOT EXISTS (
    SELECT 1
    FROM rental
    WHERE rental.inventory_id = inventory.inventory_id
    AND rental.return_date IS NULL
);


-- 5.4 Determine the number of distinct last names of the actors in the database.

SELECT count(distinct(last_name)) FROM sakila.actor;

-- 6. Retrieve the 10 longest films.

SELECT title,length FROM sakila.film ORDER BY length DESC LIMIT 10;

-- 7.Use filtering techniques in order to:

-- 7.1 Retrieve all actors with the first name "SCARLETT".

SELECT first_name, last_name FROM sakila.actor WHERE first_name = "SCARLETT";

-- 7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.

SELECT film_id,title FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%' AND (length>100);


-- 7.3 Determine the number of films that include Behind the Scenes content

SELECT film_id,title,special_features FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';
