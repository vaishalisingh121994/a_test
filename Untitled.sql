CREATE TABLE customer_reviews (
  review_id SERIAL PRIMARY KEY,
  customer_id INT,
  review_text TEXT
);

INSERT INTO customer_reviews (customer_id, review_text)
VALUES (1, 'This film was fantastic! I highly recommend it.');


Select*From customer_reviews;

Select*From city;

Select*from payment
Where payment_date > '2007-03-28'
Order By payment_date DESC;

Select first_name , last_name
from actor
WHERE first_name = 'Tom';

Select concat(first_name,'' ,last_name) as full_name
from actor
WHERE first_name = 'Tom';

Select*From actor;

Select*from payment
Where amount <> 5.98
Order By payment_date ASC;

Select*from payment
Where staff_id <> 1
Order By amount ASC;

Select count(staff_id)
From payment;

Select count(distinct staff_id)
From payment;

Select distinct staff_id
from payment;


Select staff_id, Sum(amount)
from payment
Group By staff_id;

Select staff_id, Max(amount)
from payment
Group By staff_id;

Select staff_id, Avg(amount)
from payment
Group By staff_id;

Select staff_id, percentile_cont(.5)
From payment
Within group staff_id(order by amount ASC)
Group By staff_id;

Select count(staff_id)
from payment
Group By staff_id;


--And use
select*from payment
where(amount>5) and (payment_date>'2007-02-28')

select*from payment
where(amount>5) and (payment_date>'2007-03-17')

select*from payment
where(amount>5) and (payment_date>'2007-03-17')
and (payment_date<'2007-03-18');

--In use
select*from actor
where first_name In('Tom', 'jack','Nick','Jill');

select*from language
where not name ='english';

select*from language
where name not in ('english');

--% use
select*from language
where name not like 'E%';


--like use
Select*from film
where title like 'Ad%';

Select*from Film
where description not like 'a%';

Select*from Film
where description like 'A T%';

--Keywords search
Select*from Film
where description like '%Moose%' And description Like '%Cat%';

Select*from Film
where description like '%Moose%Cat%';

Select*from Film
where description like '%Cat%' And description like '%Moose%';

--Between use
Select*from actor
where actor_id Between 4 and 10;

--
--sub query(within the query)
Select*From actor
where length(last_name)>
All(select length(First_name) from actor);

Select*From actor
where length(first_name)>
All(select length(last_name) from actor);

Select Length (first_name)from actor;

--All use

Select customer_id , first_name, Last_name
From customer
where customer_id<> All (
    Select customer_id
    From rental
Where return_date is Null
);

Select customer_id , first_name, Last_name
From customer
where customer_id IN (
    Select customer_id
    From rental
Where return_date is Null
);


--Or use

Select*from Film
where (description like '%Moose%Cat%') OR (description like '%dog%');

--Any use
Select customer_id , first_name, Last_name
From customer
where customer_id<> Any (
    Select customer_id
    From rental
Where return_date is Null
);


SELECT customer_id, first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
    AND r.return_date IS NULL
);

SELECT customer_id, first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
    AND r.return_date IS NULL
)
Limit 20;


Select return_date
from rental;

Select distinct return_date
from rental;

--Left Join

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC;
