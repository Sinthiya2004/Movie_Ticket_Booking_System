create database movieticket;
use movieticket;


-- 1. Movies Table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    language VARCHAR(50),
    duration_minutes INT,
    release_date DATE,
    rating VARCHAR(10)
);

-- 2. Theatres Table
CREATE TABLE Theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    location VARCHAR(255),
    total_screens INT
);

-- 3. Screens Table
CREATE TABLE Screens (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    screen_number INT,
    seat_capacity INT,
    screen_type VARCHAR(50), -- 2D, 3D, IMAX
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id) ON DELETE CASCADE
);

-- 4. Shows Table
CREATE TABLE Shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    screen_id INT,
    show_time DATETIME,
    price_multiplier DECIMAL(3,2) DEFAULT 1.0,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id) ON DELETE CASCADE
);

-- 5. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(15),
    membership_status VARCHAR(50) DEFAULT 'Standard'
);

-- 6. Seats Table
CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    screen_id INT,
    seat_number VARCHAR(10),
    seat_class VARCHAR(50), -- VIP, Premium, Normal
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id) ON DELETE CASCADE
);

-- 7. Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    show_id INT,
    booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50), -- Confirmed, Cancelled
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id) ON DELETE CASCADE
);

-- 8. Tickets Table
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    seat_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id) ON DELETE CASCADE
);

-- 9. Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    payment_method VARCHAR(50), -- UPI, Card, NetBanking
    payment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2),
    payment_status VARCHAR(50), -- Success, Failed
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- 10. Snacks Table
CREATE TABLE Snacks (
    snack_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100),
    category VARCHAR(50), -- Food, Beverage
    price DECIMAL(10,2)
);

-- 11. Snack_Orders Table
CREATE TABLE Snack_Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    total_snack_amount DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- 12. Snack_Order_Details Table
CREATE TABLE Snack_Order_Details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    snack_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Snack_Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (snack_id) REFERENCES Snacks(snack_id) ON DELETE CASCADE
);

-- 13. Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    customer_id INT,
    rating_stars INT CHECK (rating_stars BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- 14. Discounts Table
CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    promo_code VARCHAR(50) UNIQUE,
    discount_percentage INT,
    expiry_date DATE
);

-- 15. Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    name VARCHAR(100),
    role VARCHAR(100),
    salary DECIMAL(10,2),
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id) ON DELETE SET NULL
);

-- 1. Movies (5 rows)
INSERT INTO Movies VALUES (1, 'Leo', 'Action', 'Tamil', 165, '2023-10-19', 'UA'),(2, 'Jailer', 'Action', 'Tamil', 160, '2023-08-10', 'UA'),(3, 'Vikram', 'Thriller', 'Tamil', 175, '2022-06-03', 'UA'),(4, 'Interstellar', 'Sci-Fi', 'English', 169, '2014-11-07', 'U'),(5, 'Premalu', 'Rom-Com', 'Malayalam', 156, '2024-02-09', 'U');

-- 2. Theatres (3 rows)
INSERT INTO Theatres VALUES (1, 'Rohini Silver Screens', 'Chennai', 'Koyambedu', 7),(2, 'PVR Cinemas', 'Chennai', 'Velachery', 5),(3, 'Vetrrivel Cinemas', 'Madurai', 'Villapuram', 2);

-- 3. Screens (4 rows)
INSERT INTO Screens VALUES (1, 1, 1, 200, 'IMAX'),(2, 1, 2, 150, '2D'),(3, 2, 1, 120, '3D'),(4, 3, 1, 300, '2D');

-- 4. Seats (5 rows)
INSERT INTO Seats VALUES (1, 1, 'A1', 'VIP'),(2, 1, 'A2', 'VIP'),(3, 2, 'G10', 'Normal'),(4, 3, 'E5', 'Premium'),(5, 4, 'M12', 'Normal');

-- 5. Shows (4 rows)
INSERT INTO Shows VALUES (1, 1, 1, '2026-06-15 10:00:00', 1.20),(2, 2, 2, '2026-06-15 14:30:00', 1.00),(3, 3, 3, '2026-06-16 18:15:00', 1.50),(4, 5, 4, '2026-06-16 22:00:00', 1.00);

-- 6. Customers (5 rows)
INSERT INTO Customers VALUES (1, 'Arun', 'Kumar', 'arun@mail.com', '9876543210', 'Premium'),(2, 'Divya', 'Prakash', 'divya@mail.com', '8765432109', 'Standard'),(3, 'Santhosh', 'Raj', 'santhosh@mail.com', '7654321098', 'Standard'),(4, 'Pooja', 'Sree', 'pooja@mail.com', '6543210987', 'Premium'),(5, 'Vijay', 'Anand', 'vijay@mail.com', '9999988888', 'Standard');

-- 7. Bookings (4 rows)
INSERT INTO Bookings VALUES (1, 1, 1, '2026-06-12 09:15:00', 400.00, 'Confirmed'),(2, 2, 2, '2026-06-12 11:30:00', 150.00, 'Confirmed'),(3, 3, 3, '2026-06-13 15:00:00', 300.00, 'Cancelled'),(4, 4, 4, '2026-06-14 19:45:00', 200.00, 'Confirmed');

-- 8. Tickets (4 rows)
INSERT INTO Tickets VALUES (1, 1, 1, 200.00),(2, 1, 2, 200.00),(3, 2, 3, 150.00),(4, 4, 4, 200.00);

-- 9. Payments (4 rows)
INSERT INTO Payments VALUES (1, 1, 'UPI', '2026-06-12 09:16:00', 400.00, 'Success'),(2, 2, 'Card', '2026-06-12 11:32:00', 150.00, 'Success'),(3, 3, 'NetBanking', '2026-06-13 15:02:00', 300.00, 'Failed'),(4, 4, 'UPI', '2026-06-14 19:46:00', 200.00, 'Success');

-- 10. Snacks (3 rows)
INSERT INTO Snacks VALUES (1, 'Popcorn Large', 'Food', 180.00),(2, 'Coca Cola', 'Beverage', 120.00),(3, 'Nachos', 'Food', 150.00);

-- 11. Snack_Orders (3 rows)
INSERT INTO Snack_Orders VALUES (1, 1, 300.00),(2, 2, 120.00),(3, 4, 180.00);

-- 12. Snack_Order_Details (3 rows)
INSERT INTO Snack_Order_Details VALUES (1, 1, 1, 1),(2, 1, 2, 1),(3, 2, 2, 1);

-- 13. Reviews (3 rows)
INSERT INTO Reviews VALUES (1, 1, 1, 5, 'Blockbuster movie! Action scenes ultra mass.'),(2, 2, 2, 4, 'Superb performance by Thalaivar.'),(3, 5, 4, 5, 'Feel good romance entertainer.');

-- 14. Discounts (2 rows)
INSERT INTO Discounts VALUES (1, 'WELCOME50', 50, '2026-12-31'),(2, 'MOVIEBUFF', 20, '2026-08-31');

-- 15. Employees (3 rows)
INSERT INTO Employees VALUES (1, 1, 'Ram Kumar', 'Manager', 45000.00),(2, 1, 'Suresh', 'Ticket Checker', 15000.00),(3, 2, 'Meena', 'Snack Counter', 12000.00);


SELECT * FROM Movies;

SELECT name, location FROM Theatres WHERE city = 'Chennai';

SELECT title, duration_minutes FROM Movies WHERE duration_minutes > 160;

SELECT first_name, last_name, email FROM Customers WHERE membership_status = 'Standard';

SELECT SUM(total_screens) AS total_screens_count FROM Theatres;

SELECT item_name, price FROM Snacks ORDER BY price DESC;

SELECT S.show_id, M.title, Sc.screen_type, S.show_time 
FROM Shows S
JOIN Movies M ON S.movie_id = M.movie_id
JOIN Screens Sc ON S.screen_id = Sc.screen_id;

SELECT B.booking_id, C.first_name, B.total_amount, S.show_time 
FROM Bookings B
JOIN Customers C ON B.customer_id = C.customer_id
JOIN Shows S ON B.show_id = S.show_id;


SELECT T.ticket_id, T.price, S.seat_number, S.seat_class 
FROM Tickets T
JOIN Seats S ON T.seat_id = S.seat_id;


SELECT E.name AS employee_name, E.role, T.name AS theatre_name 
FROM Employees E
LEFT JOIN Theatres T ON E.theatre_id = T.theatre_id;

SELECT M.title, C.first_name, R.rating_stars, R.comments 
FROM Reviews R
JOIN Movies M ON R.movie_id = M.movie_id
JOIN Customers C ON R.customer_id = C.customer_id;

SELECT P.payment_id, B.booking_id, P.payment_method, P.amount_paid, P.payment_status 
FROM Payments P
JOIN Bookings B ON P.booking_id = B.booking_id
WHERE B.status = 'Confirmed';

SELECT SO.booking_id, S.item_name, SOD.quantity 
FROM Snack_Order_Details SOD
JOIN Snack_Orders SO ON SOD.order_id = SO.order_id
JOIN Snacks S ON SOD.snack_id = S.snack_id;

SELECT T.name, T.city, S.screen_number 
FROM Theatres T
JOIN Screens S ON T.theatre_id = S.theatre_id
WHERE S.screen_type = 'IMAX';

SELECT Se.seat_number, Se.seat_class 
FROM Seats Se
JOIN Screens Sc ON Se.screen_id = Sc.screen_id
JOIN Theatres T ON Sc.theatre_id = T.theatre_id
WHERE T.name = 'Rohini Silver Screens';

SELECT genre, COUNT(*) AS movie_count FROM Movies GROUP BY genre;

SELECT SUM(amount_paid) AS total_revenue FROM Payments WHERE payment_status = 'Success';

SELECT M.title, AVG(R.rating_stars) AS avg_rating 
FROM Reviews R
JOIN Movies M ON R.movie_id = M.movie_id
GROUP BY M.title;

SELECT screen_type, SUM(seat_capacity) AS total_seats 
FROM Screens GROUP BY screen_type;

SELECT customer_id, COUNT(*) AS booking_count 
FROM Bookings 
GROUP BY customer_id 
HAVING booking_count >= 1;

SELECT booking_id, SUM(total_snack_amount) AS total_spent 
FROM Snack_Orders GROUP BY booking_id;

SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary FROM Employees;

SELECT title FROM Movies 
WHERE movie_id NOT IN (SELECT DISTINCT movie_id FROM Reviews);



SELECT item_name, price FROM Snacks 
WHERE price = (SELECT MAX(price) FROM Snacks);

SELECT first_name, last_name, email FROM Customers 
WHERE customer_id = (SELECT customer_id FROM Bookings ORDER BY total_amount DESC LIMIT 1);

SELECT promo_code, discount_percentage FROM Discounts WHERE expiry_date > '2026-06-09';

SELECT booking_id, total_amount,
       CASE 
           WHEN total_amount >= 300 THEN 'Premium Ticket Expense'
           ELSE 'Budget Ticket Expense'
       END AS expense_category
FROM Bookings;


SELECT name FROM Theatres 
WHERE theatre_id = (SELECT theatre_id FROM Employees WHERE role = 'Manager' LIMIT 1);

UPDATE Bookings SET status = 'Cancelled' WHERE booking_id = 2;

DELETE FROM Discounts WHERE expiry_date < '2026-06-09';

CREATE VIEW ActiveShows AS 
SELECT M.title, S.show_time, T.name AS theatre_name 
FROM Shows S
JOIN Movies M ON S.movie_id = M.movie_id
JOIN Screens Sc ON S.screen_id = Sc.screen_id
JOIN Theatres T ON Sc.theatre_id = T.theatre_id;

SELECT * FROM ActiveShows;

SELECT COUNT(*) AS total_vip_seats FROM Seats WHERE seat_class = 'VIP';