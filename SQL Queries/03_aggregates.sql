SELECT
    product_id,
	seller,
    product_score,
    delivery_days,
    seller_rating,

    -- Low product_score = bad
    PERCENT_RANK() OVER (ORDER BY product_score ASC) AS product_score_risk,

    -- High delivery_days = bad
    PERCENT_RANK() OVER (ORDER BY delivery_days DESC) AS delivery_risk,

    -- Low seller_rating = bad
    PERCENT_RANK() OVER (ORDER BY seller_rating ASC) AS seller_risk
FROM flipkart;



-- Question 6
CREATE MATERIALIZED VIEW flipkart_early_warning AS
SELECT
    product_id,
    seller,
    product_score,
    delivery_days,
    seller_rating,

    -- Individual risks
    PERCENT_RANK() OVER (ORDER BY product_score ASC) AS product_score_risk,
    PERCENT_RANK() OVER (ORDER BY delivery_days DESC) AS delivery_risk,
    PERCENT_RANK() OVER (ORDER BY seller_rating ASC) AS seller_risk,

    -- Combined score
   1 - (0.4 * PERCENT_RANK() OVER (ORDER BY product_score ASC)
       + 0.3 * PERCENT_RANK() OVER (ORDER BY delivery_days DESC)
       + 0.3 * PERCENT_RANK() OVER (ORDER BY seller_rating ASC)) AS early_warning_score,

    CASE
    WHEN 1 - (0.4 * PERCENT_RANK() OVER (ORDER BY product_score ASC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY delivery_days DESC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY seller_rating ASC)) >= 0.8 THEN 'Critical'
    WHEN 1 - (0.4 * PERCENT_RANK() OVER (ORDER BY product_score ASC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY delivery_days DESC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY seller_rating ASC)) >= 0.6 THEN 'High Risk'
    WHEN 1 - (0.4 * PERCENT_RANK() OVER (ORDER BY product_score ASC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY delivery_days DESC)
           + 0.3 * PERCENT_RANK() OVER (ORDER BY seller_rating ASC)) >= 0.4 THEN 'Moderate'
    ELSE 'Low Risk'
END AS risk_flag       FROM flipkart;

SELECT * FROM flipkart_early_warning;
