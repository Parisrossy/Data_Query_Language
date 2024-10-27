CREATE TABLE CUSTOMER_TABLE(
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(40) NOT NULL,
    Customer_Tel VARCHAR(30) NOT NULL,
);

CREATE TABLE PRODUCT_TABLE(
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50) NOT NULL,
    category VARCHAR(60) NOT NULL,
    Price DECIMAL(10,2) CHECK(Price > 0) NOT NULL
);

CREATE TABLE ORDERS_TABLE(
    Order_ID INT PRIMARY KEY,
    Quantity INT NOT NULL,
    Order_Date DATE NOT NULL,
    Total_Amount INT NOT NULL,
    Product_ID INT FOREIGN KEY REFERENCES PRODUCT_TABLE(Product_ID),
    Customer_ID INT FOREIGN KEY REFERENCES CUSTOMER_TABLE(Customer_ID)
);

INSERT INTO CUSTOMER_TABLE
VALUES
(1, 'Alice', '07043567432'),
(2, 'Bob', '09054735217'),
(3, 'Charlie', '08123496534');

INSERT INTO PRODUCT_TABLE
VALUES
(1, 'Widget', 'small Tech', 10.00),
(2, 'Gadget', 'Medium Tech', 20.00),
(3, 'Doohickey', 'Large Tech', 15.00);

INSERT INTO ORDERS_TABLE
VALUES
(1, 10, '2021-01-01', 100, 1, 1),
(2, 5, '2021-01-02', 100, 2, 1),
(3, 3, '2021-01-03', 30, 1, 2),
(4, 7, '2021-01-04', 140, 2, 2),
(5, 2, '2021-01-05', 20, 1, 3),
(6, 3, '2021-01-06', 45, 3, 3);


------DATA QUERY LANGUAGE--------
--Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying the quantity by the price of the product.
WITH QUESTION_ONE AS(
SELECT CUSTOMER_TABLE.Customer_Name, PRODUCT_TABLE.Product_Name, SUM(ORDERS_TABLE.Quantity * PRODUCT_TABLE.price) AS TOTAL_COST 
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP BY Customer_Name, Product_Name
)
SELECT Customer_Name, Product_Name, TOTAL_COST FROM QUESTION_ONE
WHERE Product_Name = 'Widget' OR Product_Name = 'Gadget'


--Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
WITH QUESTION_TWO AS(
SELECT CUSTOMER_TABLE.Customer_Name, PRODUCT_TABLE.Product_Name, SUM(ORDERS_TABLE.Quantity * PRODUCT_TABLE.price) AS TOTAL_COST 
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP BY Customer_Name, Product_Name
)
SELECT Customer_Name, Product_Name, TOTAL_COST FROM QUESTION_TWO
WHERE Product_Name = 'Widget'

---Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
WITH QUESTION_THREE AS(
SELECT CUSTOMER_TABLE.Customer_Name, PRODUCT_TABLE.Product_Name, SUM(ORDERS_TABLE.Quantity * PRODUCT_TABLE.price) AS TOTAL_COST 
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP BY Customer_Name, Product_Name
)
SELECT Customer_Name, Product_Name, TOTAL_COST FROM QUESTION_THREE
WHERE Product_Name = 'Gadget'

---Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.
WITH QUESTION_FOUR AS(
SELECT CUSTOMER_TABLE.Customer_Name, PRODUCT_TABLE.Product_Name, SUM(ORDERS_TABLE.Quantity * PRODUCT_TABLE.price) AS TOTAL_COST 
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP BY Customer_Name, Product_Name
)
SELECT Customer_Name, Product_Name, TOTAL_COST FROM QUESTION_FOUR
WHERE Product_Name = 'Doohickey'

----Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT CUSTOMER_TABLE.Customer_Name, COUNT(Product_Name)  AS Total_Number, SUM(ORDERS_TABLE.Quantity * PRODUCT_TABLE.price) AS Total_Cost
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
WHERE Product_Name = 'Widget' OR Product_Name = 'Gadget'
GROUP BY Customer_Name

---Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
SELECT PRODUCT_TABLE.Product_Name,  COUNT(Quantity) AS total_quantity
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON  PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP by Product_Name


---Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT  CUSTOMER_TABLE.Customer_Name, COUNT(Order_ID) AS times_Ordered
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON  PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP by Customer_Name
ORDER BY times_Ordered DESC

---Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT top (1) PRODUCT_TABLE.Product_Name, COUNT(Quantity) AS times_Ordered
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON  PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP by Product_Name
ORDER BY times_Ordered DESC

----Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.
SELECT CUSTOMER_TABLE.Customer_Name, DATENAME(DW, Order_Date) AS Order_day, COUNT(Order_ID) as times_Ordered
FROM CUSTOMER_TABLE
FULL OUTER JOIN PRODUCT_TABLE ON  PRODUCT_TABLE.Product_ID = CUSTOMER_TABLE.Customer_ID
FULL OUTER JOIN ORDERS_TABLE ON ORDERS_TABLE.Customer_ID = CUSTOMER_TABLE.Customer_ID
GROUP by Customer_Name, Order_Date