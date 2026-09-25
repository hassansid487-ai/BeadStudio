const express = require('express');
const msql = require('msnodesqlv8');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname)));

const connString = "Driver={ODBC Driver 17 for SQL Server};Server=localhost\\SQLEXPRESS;Database=BeadStudioDB;Trusted_Connection=yes;";

msql.query(connString, "SELECT 1", (err) => {
    if (err) {
        console.log("⚠️ DB Error: ", err.message);
    } else {
        console.log("✅ Connected to BeadStudioDB Database!");
    }
});

// HTML Pages Routes
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'index.html')));
app.get('/traditional', (req, res) => res.sendFile(path.join(__dirname, 'traditional.html')));
app.get('/western', (req, res) => res.sendFile(path.join(__dirname, 'western.html')));
app.get('/cart', (req, res) => res.sendFile(path.join(__dirname, 'cart.html')));

// REST APIs
app.get('/api/products', (req, res) => {
    msql.query(connString, "SELECT * FROM Products", (err, rows) => {
        if (err) return res.status(500).send(err.message);
        res.json(rows);
    });
});

app.get('/api/products/:category', (req, res) => {
    const category = req.params.category;
    msql.query(connString, "SELECT * FROM Products WHERE Category = ?", [category], (err, rows) => {
        if (err) return res.status(500).send(err.message);
        res.json(rows);
    });
});

app.post('/api/checkout', (req, res) => {
    const { customerName, email, phone, city, address, cartItems } = req.body;
    
    // Check/Insert Customer Details with Phone & Address
    const custQuery = `
        IF NOT EXISTS (SELECT * FROM Customers WHERE Email = ?) 
            INSERT INTO Customers (CustomerName, Email, Phone, City, Address) VALUES (?, ?, ?, ?, ?)
        ELSE
            UPDATE Customers SET Phone = ?, City = ?, Address = ? WHERE Email = ?
    `;
    
    msql.query(connString, custQuery, [email, customerName, email, phone, city, address, phone, city, address, email], (err) => {
        if (err) return res.json({ success: false, message: err.message });

        msql.query(connString, "SELECT CustomerID FROM Customers WHERE Email = ?", [email], (err, rows) => {
            if (err || rows.length === 0) return res.json({ success: false, message: "Customer Lookup Failed" });

            const customerId = rows[0].CustomerID;
            let completed = 0;

            cartItems.forEach(item => {
                const orderQuery = "INSERT INTO Orders (CustomerID, ProductID, OrderQuantity, TotalAmount) VALUES (?, ?, ?, ?)";
                msql.query(connString, orderQuery, [customerId, item.id, item.qty, item.price * item.qty], (err) => {
                    completed++;
                    if (completed === cartItems.length) {
                        res.json({ success: true, message: "🎉 Order Successfully Saved in Database!" });
                    }
                });
            });
        });
    });
});

app.listen(PORT, () => {
    console.log(`🚀 Bead Studio Store listening at http://localhost:${PORT}`);
});