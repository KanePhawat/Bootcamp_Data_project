--PROJECT: Restaurant Owners
--create 5 table (1xFACT 4XDIMENSION)
--How to add foreign key
--write SQL 3-5 queries analyze data
--1xsubquery command

--Dim_table-- Customers
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
  Gender varchar(100),
  FirstName varchar(100),
  LastName varchar(100),
  Phone varchar(100)
);
INSERT INTO Customers VALUES
  (1,'F','Darleen','Levi','(305)2584243'),
  (2,'F','Minne','Findley','(459)4176641'),
  (3,'M','Yvon','Leachman','(862)6521222'),
  (4,'M','Alistair','Frichley','(909)6642728'),
  (5,'M','Kristoforo','Boutflour','(712)9475070'),
  (6,'F','Fidela','Sandom','(430)2862350'),
  (7,'M','Zolly','Stapleton','(352)1956561'),
  (8,'M','Franky','Monk','(768)7928377'),
  (9,'F','Nicolle','McGrouther','(943)9714581'),
  (10,'M','Percy','Batten','(797)8796763'),
  (11,'F','Cornelle','Wiltshear','(604)8622931'),
  (12,'M','Earl','Rozier','(100)5386287'),
  (13,'M','Stacy','Waterstone','(196)9029427'),
  (14,'F','Rora','Slot','(369)1462332'),
  (15,'M','Germayne','Skinner','(775)3375939');
--Dim_table-- Staffs
CREATE TABLE Staffs (
	StaffID INT PRIMARY KEY,
  Gender varchar(100),
  FirstName varchar(100),
  LastName varchar(100),
  age INT
);
INSERT INTO Staffs VALUES
  (1,'F','Doll','Guilford',25),
  (2,'M','Neils','Featley',35),
  (3,'M','Ario','Riccard',37),
  (4,'F','Carree','Critchard',19),
  (5,'M','Peadar','Ecclesall',44);
--Dim_table-- Menu
CREATE TABLE Menu (
  MenuID INT PRIMARY KEY,
  Name varchar(100),
  CategoryID INT,
  Price REAL,
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
INSERT INTO Menu VALUES
	(1,'Meal_A',1,199.0),
	(2,'Meal_B',1,179.0),
  (3,'Meal_C',1,159.0),
  (4,'Set_A',1,299.0),
  (5,'Set_B',1,359.0),
  (6,'Appetizer_1',2,69.0),
  (7,'Appetizer_2',2,59.0),
  (8,'Dessert_A',3,99.0),
  (9,'Dessert_B',3,129.0),
  (10,'Drink_1',4,39),
  (11,'Drink_2',4,49),
  (12,'Drink_3',4,69);
--Dim_table-- Categories
CREATE TABLE Categories(
  CategoryID INT PRIMARY KEY,
  CategoryName varchar(100) 
);
INSERT INTO Categories VALUES
  (1,'Main Courses'),
  (2,'Appitizers'),
  (3,'Desserts'),
  (4,'Drinks');
--Dim_table-- Payment
CREATE TABLE Payment(
  PaymentID INT PRIMARY KEY,
  PaymentType varchar(100)
);
INSERT INTO Payment VALUES
  (1,'Cash'),
  (2,'Mobile payment'),
  (3,'Credit Card'),
  (4,'Delivery');
--Dim_table-- Order
CREATE TABLE Orders(
  OrderID INT PRIMARY KEY,
  OrderDate varchar(100),
  PaymentID INT,
  FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);
INSERT INTO Orders VALUES
  (1,'2022-08-29',2),
  (2,'2022-08-27',4),
  (3,'2022-08-26',1),
  (4,'2022-08-26',3),
  (5,'2022-08-26',3),
  (6,'2022-08-24',2),
  (7,'2022-08-25',1),
  (8,'2022-08-27',4),
  (9,'2022-08-27',3),
  (10,'2022-08-24',4);

--Fact_table--
CREATE TABLE Sale_Orders(
  OrderID INT,
  CustomerID INT,
  MenuID INT,
  Amount INT,
  StaffID INT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (MenuID) REFERENCES Menu(MenuID),
  FOREIGN KEY (StaffID) REFERENCES Staffs(StaffID)
);
INSERT INTO Sale_Orders VALUES
  (1,4,5,1,1),
  (1,4,9,2,2),
  (1,4,3,2,4),
  (2,2,5,2,5),
  (2,2,8,2,5),
  (2,2,11,1,4),
  (2,2,1,1,1),
  (3,15,4,1,4),
  (3,15,2,1,2),
  (3,15,8,1,3),
  (3,15,9,2,3),
  (3,15,4,2,5),
  (4,1,3,2,3),
  (4,1,9,1,2),
  (5,8,3,1,2),
  (5,8,13,1,2),
  (6,11,7,1,3),
  (6,11,4,1,4),
  (6,11,11,1,5),
  (6,11,5,1,2),
  (7,7,5,2,2),
  (7,7,8,2,3),
  (7,7,3,1,5),
  (7,7,9,2,2),
  (8,13,10,1,3),
  (8,13,6,2,3),
  (8,13,4,2,5),
  (9,10,1,2,1),
  (9,10,5,2,2),
  (10,6,13,1,2);

/*==========Analyze data===========*/
.mode table
.header on 
--Q1.Which menu is the best seller?
SELECT
  M.Name,
  SUM(s_ord.Amount) AS qty,
  SUM(M.Price) AS Total_price,
  CategoryName AS Category
FROM Sale_Orders AS s_ord
JOIN Customers AS cus
ON s_ord.CustomerID = cus.CustomerID
JOIN Menu AS M
ON s_ord.MenuID = M.MenuID
JOIN Categories AS cat
ON M.CategoryID = cat.CategoryID
GROUP BY 1
ORDER BY 3 DESC;

--Q2.TOP 5 Spenders
SELECT
  cus.FirstName||' '||cus.LastName AS Cus_name,
  cus.Gender,
  SUM(M.Price) AS Total_price,
  SUM(s_ord.Amount) AS qty
FROM Sale_Orders AS s_ord
JOIN Customers AS cus
ON s_ord.CustomerID = cus.CustomerID
JOIN Menu AS M
ON s_ord.MenuID = M.MenuID
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

--JOIN TABLE by WITH CLAUSE
--Q3.Payment method
WITH sub AS(
  SELECT 
    OrderID,
    OrderDate,
    PaymentType
  FROM Orders AS ord
  JOIN payment AS pay
  ON ord.PaymentID = pay.PaymentID
)
SELECT 
  sub.PaymentType,
  COUNT(s_ord.OrderID) AS times
FROM Sale_Orders AS s_ord
JOIN sub
ON s_ord.OrderID = sub.OrderID
GROUP BY 1
ORDER BY 2 DESC;

--Q4.Daily sales report
SELECT
  OrderDate,
  SUM(Price) AS 'Daily Sales'
FROM(
    SELECT 
    *
    FROM Orders AS ord
    JOIN Sale_Orders AS s_ord
    ON ord.OrderID = s_ord.OrderID
    JOIN Menu AS M
    ON s_ord.MenuID = M.MenuID 
)
GROUP BY 1;
