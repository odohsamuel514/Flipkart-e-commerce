# Flipkart Online Marketplace Analysis
## Table of Contents

- [Project Overview](#project-overview)
- [Dataset Description](#dataset-description)
- [Tools & Technologies](#tools--technologies)
- [Data Cleaning & Preparation](#data-cleaning--preparation)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Analytical Apporach](#analytical-apporach)
- [Results & Findings](#results--findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)


### Project Overview
This project analyzes e-commerce sales data to understand how pricing, discounts, shipping speed, and warranty influence revenue, returns, and customer satisfaction. To  produce actionable recommendations to improve assortment, pricing, and seller Service Level Agreement (SLAs).

### Dataset Description
- Source: Simulated Flipkart e-commerce transactional dataset in CSV Format.
- Records: 80,000 rows
- Time Period: 2018-2023
  
  **Key Columns include:**
product_id, category, price, discount_percent, final_price, units_sold, revenue, shipping_days, warranty_months, customer_rating, seller_rating, is_return_risk_flag.

### Tools & Technologies

- Excel: Initial exploration and validation
- SQL: Data storage, transformation, and aggregation
- Power Query: Data Cleaning and Transformation
- Power BI: Dashboard creation and visualization
- GitHub: Version control and documentation

## Data Cleaning & Preparation
During the initial data preparation phase, several steps were performed to ensure the dataset was accurate, consistent, and ready for analysis. These steps were carried out in the order listed below.

1. **Data Ingestion and Storage**
- Created a PostgreSQL table using the same column names and data types as provided in the original CSV file.
- Imported the raw CSV data into PostgreSQL to enable structured querying and transformation.

2. **Data Type Standardization**
- Converted discount_percent from whole numbers (e.g., 20) to decimal format (e.g., 0.20) to ensure consistency in calculations and analysis.

3. **Added Derived Columns**

To support deeper analysis and business insights, several derived columns were created:
- **Revenue**: Calculated as final_price × units_sold to measure total sales value per product.
- **Discount Amount**: Calculated as price − final_price to quantify the absolute discount offered.
- **Listing Age (Days)**: Computed as the difference between a reference date (June 24, 2023) and the product listing date.
- **High Return Risk Flag**: Products were flagged as high return risk when they combined long delivery times, low ratings, and return eligibility.

4. **Data Normalization in Power BI (Power Query)**
- Loaded the cleaned PostgreSQL dataset into Power BI using Power Query.
- Created a duplicate reference table to isolate product-level attributes.
- Retained only the primary key (product_id) and the payment_mode column.
- Split the payment_mode field, which contained multiple values in a single cell, into individual rows.
- Unpivoted the split values to create a normalized structure where each payment method appears as a single, unique record per product.
- This transformation improved data consistency and enabled accurate filtering and aggregation by payment method in the dashboard.

5. **Data Model Finalization and Reporting**
- Applied all Power Query transformations and finalized the data model in Power BI.
- Established relationships between fact and dimension tables using product_id as the primary key.
- Built interactive reports and dashboards to answer the defined business questions related to performance, pricing, operations, and product lifecycle.


### Exploratory Data Analysis (EDA)

EDA Involved exploring the Online Marketplace data to answer 6 Key Business Questions. Which are:

- What are the highest-revenue products, brands, and categories (by total revenue and by units sold)?
- Which sellers and seller cities contribute the most/least to revenue, and how does seller_rating relate to revenue and returns?
- How do price, discount_percent, and final_price impact units_sold and product ratings? (price elasticity proxy)
- What product attributes (weight, warranty_months, delivery_days, is_returnable, color/size) correlate with higher ratings and lower return risk?
- Are there seasonal or listing-age effects on sales (listing_date → sales trend) and which categories show strongest seasonality?
- Which products or sellers show early warning signs of underperformance (low product_score, high delivery_days, low seller_rating) that should be prioritized for intervention? 

### Analytical Apporach
To answer the business questions effectively, the analysis was structured around clear product, pricing, seller, and operational dimensions. Rather than evaluating raw metrics in isolation, products were grouped into meaningful segments to enable fair comparison and actionable insights.

**Feature Engineering & Classification:**
Several derived attributes and classifications were created to support structured analysis across products, sellers, and lifecycle stages.

**Pricing & Discount Segmentation**
- Products were grouped into discount ranges (e.g., 0–10%, 11–20%, etc.) to assess how different levels of discounting impact sales volume, revenue, customer ratings, and return risk.
- Final prices were also segmented into Low, Mid, and High price categories using relative thresholds, allowing performance comparisons across the marketplace regardless of absolute price differences.

**Seller & Product Quality Classification**
- Seller ratings were grouped into clear rating bands (from Very Low to Very High) to evaluate how seller reliability influences revenue performance and return behavior.
- Warranty offerings were categorized into standard duration groups (No Warranty, 6 Months, 1 Year, etc.) to understand how post-purchase assurance affects customer satisfaction and return risk.

**Logistics & Product Lifecycle Attributes**
- Products were classified into Light, Medium, and Heavy shipping weight groups to analyze logistics impact on returns and customer ratings.
- Listing age was converted into lifecycle stages (0–30 days, 31–90 days, and beyond) to study how product performance and sales momentum change over time.

**Risk Scoring & Product Health Classification**
- To identify early warning signs of underperformance, three key dimensions were evaluated together using Product quality, Delivery experience and Seller reliability. Rather than analyzing these factors separately, they were combined into a single product health framework. Each product was assessed relative to the broader marketplace, with greater emphasis placed on product quality, followed by delivery experience and seller reliability. Based on overall performance, products were classified into four risk levels **Low Risk**, **High Risk**, **Medium Risk**, **Critical**. 

- This framework allows stakeholders to quickly identify products and sellers that may negatively impact customer satisfaction, operational efficiency, or marketplace performance without requiring deep technical analysis. 

These classifications enabled consistent, apples-to-apples comparison across products and formed the foundation for all dashboard visualizations.

### Results & Findings 
The Analysis Key findings are summarized as follows:

1. **Revenue is highly concentrated:** A small group of top products and top brands generates most of the marketplace revenue, making their availability and performance critical to overall business success.
2. **Category performance differs by value vs volume:** Toys drive the highest sales volume and revenue, while premium categories like Beauty and Fashion earn more per item but have untapped potential to sell higher volumes.
3. **Moderate pricing and discounts perform best:** Discounts in the 10–30% range achieve the highest customer ratings, while heavy discounts reduce revenue and do not reliably increase sales.
4. **Seller quality directly impacts returns and revenue:** High-rated sellers generate more revenue and fewer returns, while low-rated sellers are linked to higher return risk and weaker sales.
5. **Operational risks are concentrated in specific products:** Thousands of products especially medium-weight and poorly managed items show high or critical underperformance risk, leading to returns, low ratings, and customer complaints.
6. **Customer trust drivers matter:** Fast delivery, returnability, and 6–12 month warranties significantly improve ratings and reduce return risk, while slow shipping and extreme warranty lengths correlate with worse outcomes.
7. **Product age strongly reduces sales momentum:** Products sell fastest in their first 30 days, after which sales decline sharply across all categories, making new launches and periodic listing refreshes essential.

### Recommendations
Based on the Analysis, The following recomendations are made to Improve the Overall Business Performance:

1. **Protect and optimize top revenue drivers:** Keep top-selling products and leading brands consistently in stock, visible, and competitively priced since they drive most of the marketplace revenue.
2. **Use smarter discount strategies:** Focus on moderate, targeted discounts (around 10–30%) and avoid heavy blanket discounts that reduce revenue and increase risk without improving performance.
3. **Strengthen seller quality management:** Closely monitor low-rated sellers to reduce returns, while boosting high-rated sellers with better visibility, promotions, and support.
4. **Address underperforming products early:** Immediately review and fix or remove high-risk and critical products, and use automated monitoring to flag issues before they harm customer experience.
5. **Improve logistics, returns, and packaging:** Enhance packaging for medium-weight products, prioritize fast shipping, encourage returnable listings, and promote products with 6–12 month warranties.
6. **Target growth by category and location:** Promote high-margin categories like Beauty and support underperforming seller cities through incentives, expanded seller networks, and better product availability.
7. **Maximize early product momentum:** Aggressively promote new products in their first 30 days and regularly refresh, relaunch, or retire aging listings to sustain sales performance.

## Limitations
One key limitation of this analysis is the absence of an explicit indicator showing whether a product was actually returned by customers. Since no direct “return” column was available in the dataset, a rule-based return risk flag was created to approximate return behavior. Products were classified as having a higher return risk based on a combination of Longer delivery times, Low customer ratings, and Whether the product was eligible for returns. This flag does not confirm that a product was returned. Instead, it represents a higher likelihood or risk of return based on observable patterns commonly associated with customer dissatisfaction.

As a Result The analysis focuses on return risk, not confirmed return outcomes. Findings related to returns should be interpreted as risk indicators, not actual return counts. If actual return transaction data were available, future analysis could validate and refine these insights more accurately.
