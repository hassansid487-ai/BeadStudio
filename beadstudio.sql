
CREATE DATABASE BeadStudioDB;
GO

USE BeadStudioDB;
GO

-- Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL, -- 'Traditional' or 'Western'
    Price DECIMAL(10,2) NOT NULL,
    ImageURL VARCHAR(500)
);

--  Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    City VARCHAR(50) NOT NULL
);

--  Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    OrderQuantity INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE()
);

-- Insert Initial Jewelry Items
INSERT INTO Products (ProductName, Category, Price, ImageURL) VALUES
('Royal Kundan Jhumkas', 'Traditional', 3500.00, 'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=500'),
('Pearl Dangle Chandbalis', 'Traditional', 4200.00, 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500'),
('Minimalist Gold Hoops', 'Western', 1800.00, 'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=500'),
('Contemporary Pearl Drop', 'Western', 2200.00, 'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=500');


USE BeadStudioDB;
GO

-- Purane products clear karke naye rich items add karte hain
DELETE FROM Orders;
DELETE FROM Products;

INSERT INTO Products (ProductName, Category, Price, ImageURL) VALUES
-- Traditional Collection
('Royal Kundan Jhumkas', 'Traditional', 3500.00, 'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=500'),
('Pearl Dangle Chandbalis', 'Traditional', 4200.00, 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500'),
('Antique Temple Gold Earrings', 'Traditional', 2900.00, 'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=500'),
('Meenakari Floral Jhumka', 'Traditional', 3100.00, 'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=500'),
('Bridal Emerald Matha Patti Set', 'Traditional', 6500.00, 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500'),
('Ruby Red Heritage Choker', 'Traditional', 5800.00, 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=500'),

-- Western Collection
('Minimalist Gold Hoops', 'Western', 1800.00, 'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=500'),
('Contemporary Pearl Drop', 'Western', 2200.00, 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500'),
('Textured Geometric Studs', 'Western', 1400.00, 'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=500'),
('Sleek Snake Chain Drop', 'Western', 2500.00, 'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=500'),
('Crystal Huggie Earrings', 'Western', 1950.00, 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500'),
('Chic Layered Gold Pendant', 'Western', 2700.00, 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=500');

USE BeadStudioDB;
GO

-- Contact Number aur House Address ke columns add karne ke liye
ALTER TABLE Customers 
ADD Phone VARCHAR(20),
    Address VARCHAR(250);
GO


USE BeadStudioDB;
GO

-- Saare Customers dekhne ke liye
SELECT * FROM Customers;

-- Saare Products dekhne ke liye
SELECT * FROM Products;

-- Sirf Traditional Collection dekhne ke liye
SELECT * FROM Products WHERE Category = 'Traditional';

-- Sirf Western Collection dekhne ke liye
SELECT * FROM Products WHERE Category = 'Western';