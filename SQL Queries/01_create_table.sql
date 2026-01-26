CREATE TABLE flipkart (product_id VARCHAR PRIMARY KEY, product_name	VARCHAR, category VARCHAR, 
brand VARCHAR,  seller VARCHAR, seller_city VARCHAR, price NUMERIC (10,2), discount_percent NUMERIC(5,2), 
final_price NUMERIC (10,2),  rating NUMERIC (10,2), review_count INT, stock_available INT, units_sold INT, 
listing_date DATE, delivery_days INT, weight_g FLOAT, warranty_months INT, color VARCHAR, size VARCHAR, 
return_policy_days INT, is_returnable BOOLEAN, payment_modes VARCHAR, shipping_weight_g	FLOAT,
product_score NUMERIC (10,2), seller_rating NUMERIC (10,2)
);

SELECT * FROM flipkart

ALTER TABLE flipkart
ALTER COLUMN discount_percent TYPE NUMERIC(10,2);