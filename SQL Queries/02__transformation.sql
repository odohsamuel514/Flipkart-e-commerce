SELECT * FROM flipkart;

UPDATE flipkart
SET discount_percent = discount_percent::numeric/100.0;

-- ADD REVENUE COLUMN --
ALTER TABLE flipkart
ADD COLUMN revenue NUMERIC(10,2);
ALTER TABLE flipkart
ALTER COLUMN revenue TYPE NUMERIC(20,2);

UPDATE flipkart
SET revenue = final_price * units_sold;

-- ADD discount_amount column --
ALTER TABLE flipkart
ADD COLUMN discount_amount NUMERIC(10,2);
UPDATE flipkart
SET discount_amount = price - final_price;

-- ADD listing_age_days Column --
ALTER TABLE flipkart
ADD COLUMN  listing_age_days INT;
UPDATE flipkart
SET listing_age_days= DATE '2023/06/24' - listing_date;

-- ADD shipping_weight_class Column --
ALTER TABLE flipkart
ADD COLUMN shipping_weight_class VARCHAR;

UPDATE flipkart
SET shipping_weight_class = CASE WHEN shipping_weight_g >=3000 THEN 'Heavy'
                                 WHEN shipping_weight_g >= 500 THEN 'Medium'
								 ELSE 'Light' END;

-- ADD is_high_return_risk column; 
ALTER TABLE flipkart
ADD COLUMN is_high_return_risk VARCHAR;

UPDATE flipkart
SET is_high_return_risk = CASE WHEN delivery_days >= 6 AND rating < 3
                          AND is_returnable = 'true' THEN 'Yes' 
						  ELSE 'No' END;

-- ADD seller_rating_class Column --	
ALTER TABLE flipkart
ADD COLUMN seller_rating_class VARCHAR;

UPDATE flipkart
SET seller_rating_class = CASE WHEN seller_rating>=4.5 THEN 'Very High' 
                               WHEN seller_rating>=4.0 THEN 'High'
							   WHEN seller_rating>=3.6 THEN 'Mid'
							   WHEN seller_rating>=3.2 THEN 'Low'
							   ELSE 'Very Low' END;

-- ADD Final Class cloumn --
ALTER TABLE flipkart
ADD COLUMN final_price_class VARCHAR;

UPDATE flipkart
SET final_price_class =
    CASE
        WHEN final_price <= (SELECT PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY final_price) FROM flipkart)
            THEN 'Low'
        WHEN final_price <= (SELECT PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY final_price) FROM flipkart)
            THEN 'Mid'
        ELSE 'High'
    END;

ALTER TABLE flipkart
ADD COLUMN listing_age_class VARCHAR;

UPDATE flipkart
SET listing_age_class = CASE
    WHEN listing_age_days BETWEEN 0 AND 30 THEN '0–30 Days'
    WHEN listing_age_days BETWEEN 31 AND 90 THEN '31–90 Days'
    WHEN listing_age_days BETWEEN 91 AND 180 THEN '91–180 Days'
    WHEN listing_age_days BETWEEN 181 AND 365 THEN '181–365 Days'
    ELSE '366+ Days'
END;

