

-- ANY
/*
	Select the brand, model and price where
		* the price is lower than any Ford
		* the brand is Volkswagen
*/
-- SELECT brand, model, price FROM cars
--   WHERE price < ANY (
--     SELECT price FROM cars
--       WHERE brand = 'Ford'
--   ) AND brand = 'Volkswagen';
/*

	Select the name, and sold price
		from the staff table, joined with sold_cars
		on matches between staff(id) and sold_cars(seller)
	Where the seller has sold a car for a price greater than
		any sum of a salesperson's total sales
*/
-- SELECT S.name, SC.sold_price
--   FROM staff S
--   JOIN sold_cars SC ON S.id = SC.seller
-- WHERE SC.sold_price > ANY (
-- SELECT SUM(sold_price) FROM sold_cars
--   GROUP BY seller
-- );




-- ALL
/*
	Select brand, model, condition and price from cars
		where the price is less than all cars which are in average condition (3)
*/
-- SELECT brand, model, condition, price
--   FROM cars
-- WHERE price < ALL (
--   SELECT price FROM cars
--     WHERE condition = 3
-- );
/*
	Select the brand, model and year from cars
	Where the year is before all cars with a brand of 'Ford'
	Order the results by year
*/

-- SELECT brand, model, year FROM cars
--   WHERE year < ALL (
--     SELECT year FROM cars WHERE brand = 'Ford'
--   )
-- ORDER BY year;

-- exists
/*
	Select the city, state and date established of dealerships
		Where there are no existing cars in stock
		
	Format the date in 'YYYY-MM-DD' format using TO_CHAR()
		and alias it as 'est'
*/

-- SELECT city, state, TO_CHAR(established, 'YYYY-MM-DD') AS est
--   FROM dealerships D
--   WHERE NOT EXISTS (
--     SELECT 1 FROM cars WHERE dealership_id = D.id
--   );
/*
	Select the city and state of dealerships
	Where there exists a car priced at more than $50,000
	
	Hint: you'll need to match cars(dealership_id) with dealerships(id)
	and then check for car price in your subquery
*/

-- SELECT city, state
--   FROM dealerships D
--   WHERE EXISTS (
--     SELECT 1 FROM cars C
--       WHERE C.dealership_id = D.id AND C.price > 50000
--   );
  

--   select case
/*
	Select the brand, model, condition from cars
		Based on the car's condition level, output the following:
			* 'Excellent' when 4 or greater
			* 'Fair' when 3 or greater
			* 'Poor' when 1 or greater
			* 'Wrecked' for all other cases
		Aliased as 'condition label'
	From cars
	Order by the condition in descending order
*/
-- SELECT brand, model, condition, 
--   CASE
--     WHEN condition >= 4 THEN 'Excellent'
--     WHEN condition >= 3 THEN 'Fair'
--     WHEN condition >= 1 THEN 'Poor'
--     ELSE 'Wrecked'
--   END AS condition_label
--   FROM cars
--   ORDER BY condition DESC;



/*
	Rodney is assigning bonuses for his staff on the following terms:
		- Salespeople who have made more than $100,000 in sales receive $10,000
		- Salespeople who have made more than $75,000 in sales receive $5,000
		- Every other staff member gets a bonus of $1,000
	
	Select from the sold_cars table, joined with staff where
		sold_cars(seller) = staff(id)
	Show all staff, even if they have made no sales
	
	Select:
		* staff(name)
		* staff(role)
		* staff(dealership_id)
		* the sum of the staff member's sales - alias as total_sales
	
	Use CASE to select the correct value, as defined above, aliased as bonus
	
	Use GROUP BY to format the output, and ORDER BY bonus then dealership_id
*/

-- SELECT S.name, S.role, S.dealership_id,
--   SUM(SC.sold_price) AS total_sales,
--   CASE
-- 		WHEN SUM(SC.sold_price) >= 100000 THEN 10000
-- 		WHEN SUM(SC.sold_price) >= 75000 THEN 5000
-- 		ELSE 1000
-- 	END AS bonus
--   FROM sold_cars SC
--   RIGHT JOIN staff S ON SC.seller = S.id
--   GROUP BY (S.name, S.role, S.dealership_id)
--   ORDER BY bonus, dealership_id;

