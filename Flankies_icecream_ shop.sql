CREATE TABLE CUSTOMERS (
    Customer_ID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(20),
    Last_Name VARCHAR2(20),
    Email VARCHAR2(20),
    Phone NUMBER(20),
    Address VARCHAR2(20)
);

ALTER TABLE CUSTOMERS
MODIFY Email VARCHAR2(100);

ALTER TABLE CUSTOMERS
MODIFY Address VARCHAR2(200);

CREATE TABLE Products (
    Product_ID NUMBER PRIMARY KEY,
    Description VARCHAR2(20),
    Price FLOAT(20),
    pro_size VARCHAR2(20),
    Product_Name VARCHAR2(20)
);

ALTER TABLE products
MODIFY price FLOAT;

ALTER TABLE products
MODIFY Description VARCHAR2(255);

ALTER TABLE products
MODIFY Product_Name VARCHAR2(200);

CREATE TABLE Offers (
    Offer_ID NUMBER PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE,
    Discount FLOAT(20),
    Product_ID NUMBER,
    CONSTRAINT fk_product_id FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

ALTER TABLE Offers
MODIFY Discount FLOAT;


CREATE TABLE Orders (
    Order_ID NUMBER PRIMARY KEY,
    Customer_ID NUMBER,
    Order_Date DATE,
    Offer_ID NUMBER,
    Product_ID NUMBER,
    Total_Amount NUMBER,
    CONSTRAINT fk_customerr_id FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS(Customer_ID),
    CONSTRAINT fk_productt_id FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE EMPLOYEES (
    Employee_ID NUMBER PRIMARY KEY,
    Employee_Position VARCHAR2(20),
    Employee_Name VARCHAR2(20),
    Hire_Date DATE,
    Phone NUMBER(20),
    Order_ID NUMBER(20),
    CONSTRAINT fk_order_id FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

ALTER TABLE EMPLOYEES
MODIFY Employee_Name VARCHAR2(150); 

ALTER TABLE EMPLOYEES
MODIFY  Employee_Position VARCHAR2(150);

CREATE TABLE Delivery (
    Delivery_ID NUMBER PRIMARY KEY,
    Order_ID NUMBER,
    Delivery_Address VARCHAR2(20),
    Del_Person_ID NUMBER,
    Delivery_Status VARCHAR2(20),
    Customer_ID NUMBER,
    CONSTRAINT fk_order_id_delivery FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CONSTRAINT fk_customer_id_delivery FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS(Customer_ID)
);

ALTER TABLE Delivery
MODIFY Delivery_Address VARCHAR2(200);

CREATE TABLE Transaction (
    Transaction_ID NUMBER PRIMARY KEY,
    Order_ID NUMBER,
    Transaction_Date DATE,
    Payment_Method VARCHAR2(20),
    Amount FLOAT,
    Product_ID NUMBER,
    CONSTRAINT fk_order_id_transaction FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CONSTRAINT fk_product_id_transaction FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);


CREATE TABLE Inventory (
    Inventory_ID NUMBER PRIMARY KEY,
    Product_ID NUMBER,
    Quantity NUMBER,
    Restock_Date DATE,
    CONSTRAINT fk_product_ID_inventory FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
); 

CREATE TABLE Suppliers (
    Supplier_ID NUMBER PRIMARY KEY,
    Supplier_Name VARCHAR2(80),
    Contact_Person VARCHAR2(80),
    Inventory_ID NUMBER,
    CONSTRAINT fk_inventory_id_supplier FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID)
);

CREATE USER fayrouz IDENTIFIED BY 1234;
CREATE USER asmaa IDENTIFIED BY 12345;
GRANT CREATE SESSION TO fayrouz;

GRANT SELECT, INSERT, UPDATE, DELETE ON Suppliers TO fayrouz;
GRANT SELECT, INSERT, UPDATE, DELETE ON CUSTOMERS TO fayrouz;

GRANT SELECT, INSERT, UPDATE, DELETE ON orders to fayrouz;
-- Add USERNAME and PASSWORD columns to the CUSTOMERS table
ALTER TABLE CUSTOMERS
ADD (USERNAME VARCHAR2(50), PASSWORD VARCHAR2(50));

-- Insert sample user data
INSERT INTO CUSTOMERS (USERNAME, PASSWORD) VALUES ('fayrouz', '1234');


CREATE ROLE manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventory  TO manager;
GRANT manager TO asmaa;


----CUSTOMERS INSERTIONS----
INSERT ALL
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (2, 'Jane', 'Smith', 'jane.smith@email.com', 9876543210, '456 Oak St')
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (3, 'Bob', 'Johnson', 'bob.johnson@email.com', 5551234567, '789 Pine St')
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (4, 'Eva', 'Miller', 'eva.miller@email.com', 5559876543, '321 Elm St')
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (5, 'Michael', 'Brown', 'michael.brown@email.com', 1112223333, '456 Oak St')
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (6, 'Sophia', 'Anderson', 'sophia.anderson@email.com', 9998887777, '789 Pine St')
INTO CUSTOMERS (Customer_ID, First_Name, Last_Name, Email, Phone, Address) VALUES (7, 'William', 'Taylor', 'william.taylor@email.com', 4445556666, '101 Cedar St')
SELECT * FROM dual;
SELECT * FROM CUSTOMERS;

---INSERTIONS ON PRODUCTS--
INSERT ALL
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (1, 'Vanilla Ice Cream', 3.99, 'Medium', 'Vanilla Delight')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (2, 'Chocolate Ice Cream', 4.99, 'Medium', 'Choco Heaven')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (3, 'Strawberry Ice Cream', 5.99, 'Medium', 'Berry Bliss')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (4, 'Mint Chocolate Chip', 6.99, 'Large', 'Minty Crunch')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (5, 'Cookies and Cream', 7.99, 'Large', 'Cookie Fantasy')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (6, 'Rocky Road', 8.99, 'Large', 'Rocky Mountain')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (7, 'Caramel Swirl', 9.99, 'Medium', 'Caramel Dream')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (8, 'Pistachio Almond', 10.99, 'Large', 'Nutty Delight')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (9, 'Blueberry Cheesecake', 11.99, 'Large', 'Blueberry Bliss')
INTO Products (Product_ID, Description, Price, pro_size, Product_Name) VALUES (10, 'Raspberry Sorbet', 12.99, 'Medium', 'Raspberry Delight')
SELECT * FROM dual;
SELECT * FROM Products;

-- Insert data into Offers table
INSERT ALL
INTO Offers (Offer_ID, Start_Date, End_Date, Discount, Product_ID) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 0.1, 1)
INTO Offers (Offer_ID, Start_Date, End_Date, Discount, Product_ID) VALUES (2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-28', 'YYYY-MM-DD'), 0.15, 2)
INTO Offers (Offer_ID, Start_Date, End_Date, Discount, Product_ID) VALUES (3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-15', 'YYYY-MM-DD'), 0.2, 3)
INTO Offers (Offer_ID, Start_Date, End_Date, Discount, Product_ID) VALUES (4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-30', 'YYYY-MM-DD'), 0.25, 4)
INTO Offers (Offer_ID, Start_Date, End_Date, Discount, Product_ID) VALUES (5, TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-15', 'YYYY-MM-DD'), 0.3, 5)
SELECT * FROM dual;
SELECT * FROM Offers;

-- Insert into Orders table
INSERT ALL
INTO Orders (Order_ID, Customer_ID, Order_Date, Offer_ID, Product_ID, Total_Amount) VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 39.99)
INTO Orders (Order_ID, Customer_ID, Order_Date, Offer_ID, Product_ID, Total_Amount) VALUES (2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 2, 2, 54.99)
INTO Orders (Order_ID, Customer_ID, Order_Date, Offer_ID, Product_ID, Total_Amount) VALUES (3, 3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), NULL, 3, 69.99)
INTO Orders (Order_ID, Customer_ID, Order_Date, Offer_ID, Product_ID, Total_Amount) VALUES (4, 4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 4, 4, 84.99)
INTO Orders (Order_ID, Customer_ID, Order_Date, Offer_ID, Product_ID, Total_Amount) VALUES (5, 5, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 5, 5, 99.99)
SELECT * FROM dual;
SELECT * FROM Orders;

-- Insert into EMPLOYEES table
INSERT ALL
INTO EMPLOYEES (Employee_ID, Employee_Position, Employee_Name, Hire_Date, Phone, Order_ID) VALUES (1, 'Manager', 'John Doe', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1234567890, 1)
INTO EMPLOYEES (Employee_ID, Employee_Position, Employee_Name, Hire_Date, Phone, Order_ID) VALUES (2, 'Clerk', 'Jane Smith', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 9876543210, 2)
INTO EMPLOYEES (Employee_ID, Employee_Position, Employee_Name, Hire_Date, Phone, Order_ID) VALUES (3, 'Supervisor', 'Bob Johnson', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 5551234567, 3)
INTO EMPLOYEES (Employee_ID, Employee_Position, Employee_Name, Hire_Date, Phone, Order_ID) VALUES (4, 'Clerk', 'Alice Johnson', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 1112223333, 4)
INTO EMPLOYEES (Employee_ID, Employee_Position, Employee_Name, Hire_Date, Phone, Order_ID) VALUES (5, 'Manager', 'Eva Miller', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 5559876543, 5)
SELECT * FROM dual;
SELECT * FROM EMPLOYEES;

-- Insert into Delivery table
INSERT ALL
INTO Delivery (Delivery_ID, Order_ID, Delivery_Address, Del_Person_ID, Delivery_Status, Customer_ID) VALUES (1, 1, '123 Main St', 101, 'Delivered', 1)
INTO Delivery (Delivery_ID, Order_ID, Delivery_Address, Del_Person_ID, Delivery_Status, Customer_ID) VALUES (2, 2, '456 Oak St', 102, 'In Transit', 2)
INTO Delivery (Delivery_ID, Order_ID, Delivery_Address, Del_Person_ID, Delivery_Status, Customer_ID) VALUES (3, 3, '789 Pine St', 103, 'Pending', 3)
INTO Delivery (Delivery_ID, Order_ID, Delivery_Address, Del_Person_ID, Delivery_Status, Customer_ID) VALUES (4, 4, '101 Cedar St', NULL, 'Delivered', 4)
INTO Delivery (Delivery_ID, Order_ID, Delivery_Address, Del_Person_ID, Delivery_Status, Customer_ID) VALUES (5, 5, '202 Birch St', 105, 'In Transit', 5)
SELECT * FROM dual;
SELECT * FROM Delivery;

-- Insert into Transaction table
INSERT ALL
INTO Transaction (Transaction_ID, Order_ID, Transaction_Date, Payment_Method, Amount, Product_ID) VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Credit Card', 39.99, 1)
INTO Transaction (Transaction_ID, Order_ID, Transaction_Date, Payment_Method, Amount, Product_ID) VALUES (2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Cash', 54.99, 2)
INTO Transaction (Transaction_ID, Order_ID, Transaction_Date, Payment_Method, Amount, Product_ID) VALUES (3, 3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Credit Card', 69.99, 3)
INTO Transaction (Transaction_ID, Order_ID, Transaction_Date, Payment_Method, Amount, Product_ID) VALUES (4, 4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Cash', 84.99, 4)
INTO Transaction (Transaction_ID, Order_ID, Transaction_Date, Payment_Method, Amount, Product_ID) VALUES (5, 5, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Credit Card', 99.99, 5)
SELECT * FROM dual;
SELECT * FROM Transaction;

-- Insert into Inventory table
INSERT ALL
INTO Inventory (Inventory_ID, Product_ID, Quantity, Restock_Date) VALUES (1, 1, 100, TO_DATE('2023-01-01', 'YYYY-MM-DD'))
INTO Inventory (Inventory_ID, Product_ID, Quantity, Restock_Date) VALUES (2, 2, 150, TO_DATE('2023-02-01', 'YYYY-MM-DD'))
INTO Inventory (Inventory_ID, Product_ID, Quantity, Restock_Date) VALUES (3, 3, 200, TO_DATE('2023-03-01', 'YYYY-MM-DD'))
INTO Inventory (Inventory_ID, Product_ID, Quantity, Restock_Date) VALUES (4, 4, 120, TO_DATE('2023-04-01', 'YYYY-MM-DD'))
INTO Inventory (Inventory_ID, Product_ID, Quantity, Restock_Date) VALUES (5, 5, 180, TO_DATE('2023-05-01', 'YYYY-MM-DD'))
SELECT * FROM dual;
SELECT * FROM Inventory;

-- Insert into Suppliers table
INSERT ALL
INTO Suppliers (Supplier_ID, Supplier_Name, Contact_Person, Inventory_ID) VALUES (1, 'Supplier A', 'John Supplier', 1)
INTO Suppliers (Supplier_ID, Supplier_Name, Contact_Person, Inventory_ID) VALUES (2, 'Supplier B', 'Jane Supplier', 2)
INTO Suppliers (Supplier_ID, Supplier_Name, Contact_Person, Inventory_ID) VALUES (3, 'Supplier C', 'Bob Supplier', 3)
INTO Suppliers (Supplier_ID, Supplier_Name, Contact_Person, Inventory_ID) VALUES (4, 'Supplier D', 'Alice Supplier', 4)
INTO Suppliers (Supplier_ID, Supplier_Name, Contact_Person, Inventory_ID) VALUES (5, 'Supplier E', 'Eva Supplier', 5)
SELECT * FROM dual;
SELECT * FROM Suppliers;


CREATE SEQUENCE order_sequence
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE;
    
  CREATE SEQUENCE customer_sequence
 START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE;
    
    select * from CUSTOMERS
    select * from delivery
     select * from orders
     select * from inventory
     select * from suppliers
     