-- Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) ,
    phone VARCHAR(20),
    email VARCHAR(100),
    license_number VARCHAR(50) ,
);

-- Cars
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    brand VARCHAR(50) ,
    model VARCHAR(50) ,
    year INT ,
    price_per_day DECIMAL(10,2),
    status VARCHAR(20) 'available' CHECK (status IN ('available','rented','maintenance')),
);

-- Rentals
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    customer_id INT ,
    car_id INT ,
    rent_date  ,
    return_date ,
    total_amount DECIMAL(10,2) ,
    CHECK (return_date > rent_date),

    -- Foreign Keys
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_car
        FOREIGN KEY (car_id)
        REFERENCES cars(car_id)
        ON DELETE CASCADE
);

-- Payments
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    rental_id INT ,
    payment_date DATE,
    amount DECIMAL(10,2) ,
    payment_method VARCHAR(50) ,

      -- Foreign Key
    CONSTRAINT fk_rental
        FOREIGN KEY (rental_id)
        REFERENCES rentals(rental_id)
        ON DELETE CASCADE
);


INSERT INTO customers (name, phone, email, license_number) VALUES
('Solomon', '0911536612', 'soll@email.com', 'C12195'),
('Tinsae', '0923456789', 'tina@email.com', 'B67890'),
('Samuel', '0993451253', 'nardi@email.com', 'A59890'),
('Kirubel', '0917456948', 'kuri@email.com', 'B65871');


INSERT INTO cars (brand, model, year, price_per_day) VALUES
('Toyota', 'VXR', 2025, 7000.00),
('Suzuki', 'Dzier', 2023, 1900.00),
('Volkswagen', 'ID6', 2024, 3200.00),
('Ford', 'F150', 2022, 4000.00),
('Hyundai', 'Elantra', 2019, 2000.00);


INSERT INTO rentals (customer_id, car_id, rent_date, return_date, total_amount) VALUES
(1, 1, '2026-04-01', '2026-04-05', 28000.00),
(2, 3, '2026-03-10', '2026-03-12', 6400.00),
(3, 5, '2026-02-01', '2026-02-03', 4000.00),
(4, 4, '2026-04-10', '2026-04-12', 8000.00);


INSERT INTO payments (rental_id, payment_date, amount, payment_method) VALUES
(1, '2026-04-01', 28000.00, 'Cash'),
(2, '2026-03-10', 6400.00, 'Credit Card'),
(3, '2026-02-01', 4000.00, 'Mobile'),
(4, '2026-04-10', 8000.00, 'Debit Card');


UPDATE cars
SET status = 'rented'
WHERE car_id IN (1, 3, 5, 4);


UPDATE cars
SET status = 'maintenance'
WHERE car_id IN (5);

SELECT * FROM cars;
SELECT * FROM customers;
SELECT * FROM rentals;
SELECT * FROM payments;

SELECT r.rent_date FROM rentals r;

SELECT
    r.rental_id,
    c.name,
    ca.brand,
    ca.model,
    r.rent_date,
    r.return_date,
    r.total_amount
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN cars ca ON r.car_id = ca.car_id;
