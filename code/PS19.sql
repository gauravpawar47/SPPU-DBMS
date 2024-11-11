-- Create the customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR2(20)
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    amount NUMBER,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Inserting data into customer table
INSERT INTO customer (customer_id, first_name) VALUES (1, 'John');
INSERT INTO customer (customer_id, first_name) VALUES (2, 'Jane');
INSERT INTO customer (customer_id, first_name) VALUES (3, 'Alice');
INSERT INTO customer (customer_id, first_name) VALUES (4, 'Bob');

-- Inserting data into orders table
INSERT INTO orders (order_id, amount, customer_id) VALUES (101, 150, 1);
INSERT INTO orders (order_id, amount, customer_id) VALUES (102, 200, 2);
INSERT INTO orders (order_id, amount, customer_id) VALUES (103, 250, 3);
-- A customer with no orders (for demonstrating LEFT JOIN)
INSERT INTO orders (order_id, amount, customer_id) VALUES (104, 300, NULL);

COMMIT;

SELECT c.customer_id, c.first_name, o.order_id, o.amount
FROM customer c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.first_name, o.order_id, o.amount
FROM customer c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.first_name, o.order_id, o.amount
FROM customer c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.first_name, o.order_id, o.amount
FROM customer c
FULL OUTER JOIN orders o
ON c.customer_id = o.customer_id;