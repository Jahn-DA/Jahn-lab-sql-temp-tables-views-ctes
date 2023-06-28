-- Step 1: Create a View
-- First, create a view that summarizes rental information for each customer. The view should include the customer's ID, name, email address, and total number of rentals (rental_count).
CREATE VIEW rental_summary_view AS
SELECT c.customer_id, c.first_name, c.last_name, c.email, COUNT(r.rental_id) AS rental_count
FROM sakila.customer AS c
JOIN sakila.rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT * FROM rental_summary_view;
-- 2. Step 2: Create a Temporary Table
-- Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate the total amount paid by each customer.
CREATE VIEW total_paid_summary_view AS
SELECT c.customer_id, c.first_name, c.last_name, c.email, sum(p.amount) AS total_paid
FROM sakila.customer AS c
JOIN sakila.payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT * FROM total_paid_summary_view;
-- Step 3: Create a CTE and the Customer Summary Report
-- Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. The CTE should include the customer's name, email address, rental count, and total amount paid.
-- Next, using the CTE, create the query to generate the final customer summary report, which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, this last column is a derived column from total_paid and rental_count.
CREATE VIEW the_master_view AS
SELECT c.customer_id, c.first_name, c.last_name, c.email, COUNT(r.rental_id) AS rental_count, sum(p.amount) AS total_paid, sum(p.amount)/COUNT(r.rental_id) as average_payment_per_rental
FROM sakila.customer AS c
JOIN sakila.rental AS r ON c.customer_id = r.customer_id
JOIN sakila.payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT * FROM the_master_view;