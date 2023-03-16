USE sakila;
#1- Write a query to display for each store its store ID, city, and country.
#tables to be joined are store, address, city, country
SELECT c.city, s.store_id, cc.country
FROM store s 
JOIN address a ON s.address_id = a.address_id 
JOIN city c USING(city_id)
JOIN country cc USING(country_id);

#2- Write a query to display how much business, in dollars, each store brought in.
#tables to be joined are store, staff, and payment
SELECT s.store_id, SUM(amount) dollars
FROM store s
JOIN staff ss
USING (store_id)
join payment p
USING(staff_id)
GROUP BY s.store_id;

#3-What is the average running time of films by category?
#Join 3 tables of film, film_category, category
SELECT SUM(length)/COUNT(*) avg_running, c.name category_name
FROM film
JOIN film_category USING(film_id)
JOIN category c USING(category_id)
GROUP BY c.name;

#4-Which film categories are longest?
SELECT SUM(length)/COUNT(*) avg_running, c.name category_name
FROM film
JOIN film_category USING(film_id)
JOIN category c USING(category_id)
GROUP BY c.name
ORDER BY avg_running DESC;

#5-Display the most frequently rented movies in descending order.
#three tables of rental, inventory, and film have been joined.
SELECT COUNT(r.rental_id) num_rentals, f.title
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY f.title
ORDER BY num_rentals DESC;

#6-List the top five genres in gross revenue in descending order.
SELECT ROUND(SUM(amount),0) gross_revenue, c.name genre
FROM category c
JOIN film_category fc
on c.category_id = fc.category_id
JOIN film f
on f.film_id = fc.film_id
JOIN inventory i
on i.film_id = fc.film_id
JOIN rental r
on r.inventory_id = i.inventory_id
JOIN payment p
on p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY c.name DESC;

#7-Is "Academy Dinosaur" available for rent from Store 1?
SELECT r.return_date, i.store_id, f.title
from rental r 
join inventory i USING(inventory_id)
join film f USING(film_id)
WHERE f.title = 'Academy Dinosaur' and i.store_id = 1
order by r.return_date DESC;
# The movie will be available after the last return date which is 2005-08-30


