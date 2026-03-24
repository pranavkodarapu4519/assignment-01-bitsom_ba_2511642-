-- =========================
-- Q1: List all customers from Mumbai along with their total order value
-- =========================
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.unit_price * oi.quantity) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name;

o/p

| customer_id | customer_name | total_order_value |
| ----------- | ------------- | ----------------- |
| C001        | Rohan Mehta   | 326390            |
| C005        | Vikram Singh  | 854280            |



-- =========================
-- Q2: Find the top 3 products by total quantity sold
-- =========================
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

o/p: 

prod_id	     product_name         total_quantity_sold 	
	
PR02	     Cotton Kurti	   184
PR04	     Running Shoes	   114
PR07	     Yoga Mat	           114

-- =========================
-- Q3: List all sales representatives and the number of unique customers they have handled
-- =========================
SELECT 
    sr.sales_rep_id,
    sr.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM sales_reps sr
LEFT JOIN orders o ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_id, sr.sales_rep_name;

o/p:

	
	
sales_rep_id		sales_rep_name 				unique_customers
SR01      		Deepak Joshi					8
SR02     		 Ravi Kumar					8
SR03      		Anita Desai					8

-- =========================
-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- =========================
SELECT 
    o.order_id,
    SUM(p.unit_price * oi.quantity) AS total_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING total_value > 10000
ORDER BY total_value DESC;


o/p:
ORD1061     1980000
ORD1131     1980000
ORD1095     1485000
ORD1125     1485000
ORD1048     1485000
ORD1144    1485000
ORD1025    990000
ORD1098    990000
ORD1148    770000
ORD1076    770000
ORD1101    616000
ORD1054    495000
ORD1163    462000
ORD1091    462000
ORD1169    255000
ORD1012    154000
ORD1093    154000
ORD1075    153000
ORD1155    153000
ORD1094    153000
ORD1090    102000
ORD1035    51000
ORD1033    20000
ORD1022   20000
ORD1143   19200
ORD1132   13750
ORD1118   13750
ORD1166   12000

-- =========================
-- Q5: Identify any products that have never been ordered
-- =========================
SELECT 
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

| product_id | product_name |
| ---------- | ------------ |
| P010       | Smart Watch  |
| P015       | Tablet       |
