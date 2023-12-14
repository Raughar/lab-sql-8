-- Selecting the database Sakila to use it:
use sakila;

-- Ranking the films by it's length:
select title, length, rank() over (order by length) as `rank`
from film
where length is not null and length > 0
order by length;

-- Ranking the films by it's length within the ranking table:
select title, length, rating, rank() over (partition by rating order by length) as `rank`
from film
where 
    length is not null 
    and length > 0
    and rating is not null
order by rating, length;
    
    -- Getting how many films are there for each of the categories:
select c.name as category_name, count(fc.film_id) as number_of_films
from category c
join film_category fc on c.category_id = fc.category_id
group by c.name
order by number_of_films desc;
    
-- Getting which actor has appeared in the most films:
select a.actor_id, a.first_name, a.last_name, count(fa.actor_id) as film_appearances
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_appearances desc
limit 1;

-- Getting which is the customer that rented the most films:
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as num_rentals
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by num_rentals desc
limit 1;