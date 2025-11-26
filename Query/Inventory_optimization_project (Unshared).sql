#task1:Show total number of records in each table.\

SELECT COUNT(*) AS total_records, 'Demand Forecasting' AS table_name FROM demand_forecasting
UNION ALL
SELECT COUNT(*), 'Inventory Monitoring' FROM inventory_monitoring
UNION ALL
SELECT COUNT(*), 'Pricing Optimization' FROM pricing_optimization;

#task2:Total sales quantity per store

SELECT store_id, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY store_id
ORDER BY total_sales DESC;

#task3:Average price per customer segment

SELECT customer_segments, ROUND(AVG(price),2) AS avg_price
FROM demand_forecasting
GROUP BY customer_segments;

#task4:Identify top 5 products by demand

SELECT product_id, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY product_id
ORDER BY total_sales DESC FETCH FIRST 5 ROWS ONLY;

#task5:Seasonal sales trend

SELECT seasonality_factors, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY seasonality_factors
ORDER BY total_sales DESC;

#task6:Promotions impact on sales

SELECT promotions, ROUND(AVG(sales_quantity),2) AS avg_sales
FROM demand_forecasting
GROUP BY promotions
ORDER BY avg_sales DESC;

#External factors affecting demand

SELECT external_factors, AVG(sales_quantity) AS avg_sales
FROM demand_forecasting
GROUP BY external_factors;


#task8:Month-wise total demand

SELECT TO_CHAR(forecast_date, 'MON-YYYY') AS month, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY TO_CHAR(forecast_date, 'MON-YYYY')
ORDER BY MIN(forecast_date);


#task9:Average demand trend per store

SELECT store_id, demand_trend, AVG(sales_quantity) AS avg_demand
FROM demand_forecasting
GROUP BY store_id, demand_trend;

#task10:Top 3 customer segments by total sales

SELECT customer_segments, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY customer_segments
ORDER BY total_sales DESC FETCH FIRST 3 ROWS ONLY;


#task11:Average price per season

SELECT seasonality_factors, ROUND(AVG(price),2) AS avg_price
FROM demand_forecasting
GROUP BY seasonality_factors;

#task12:Average stock level per product

SELECT product_id, ROUND(AVG(stock_levels),2) AS avg_stock
FROM inventory_monitoring
GROUP BY product_id;


#task12:Identify products below reorder point

SELECT product_id, store_id, stock_levels, reorder_point
FROM inventory_monitoring
WHERE stock_levels < reorder_point;

#task13:Identify products below reorder point
SELECT product_id, store_id, stock_levels, reorder_point
FROM inventory_monitoring
WHERE stock_levels < reorder_point;


#task14:Warehouse utilization rate

SELECT store_id,
       ROUND((SUM(stock_levels)/SUM(warehouse_capacity))*100,2) AS utilization_percent
FROM inventory_monitoring
GROUP BY store_id;

#task15:Average supplier lead time per store

SELECT store_id, ROUND(AVG(supplier_lead_time_days),2) AS avg_lead_time
FROM inventory_monitoring
GROUP BY store_id;

#task16:Identify products with high stockout frequency

SELECT product_id, stockout_frequency
FROM inventory_monitoring
WHERE stockout_frequency > (SELECT AVG(stockout_frequency) FROM inventory_monitoring);


#task17:Order fulfillment performance

SELECT store_id, AVG(order_fulfillment_time_days) AS avg_fulfillment_days
FROM inventory_monitoring
GROUP BY store_id;

#task18:Count expired products (based on current date)

SELECT COUNT(*) AS expired_products
FROM inventory_monitoring
WHERE expiry_date < SYSDATE;

#task19:Average reorder point per store

SELECT store_id, ROUND(AVG(reorder_point),2) AS avg_reorder_point
FROM inventory_monitoring
GROUP BY store_id;

task20:Top 5 warehouses with highest capacity

SELECT store_id, warehouse_capacity
FROM inventory_monitoring
ORDER BY warehouse_capacity DESC FETCH FIRST 5 ROWS ONLY;

#task21:Supplier performance vs stockouts

SELECT supplier_lead_time_days, AVG(stockout_frequency) AS avg_stockout
FROM inventory_monitoring
GROUP BY supplier_lead_time_days;

#task22:Price vs Sales Volume correlation insight
SELECT ROUND(price,2), ROUND(AVG(sales_volume),2) AS avg_sales
FROM pricing_optimization
GROUP BY price
ORDER BY price;

#task23:Identify products with high discounts but low sales

SELECT product_id, discounts, sales_volume
FROM pricing_optimization
WHERE discounts > 30 AND sales_volume < (SELECT AVG(sales_volume) FROM pricing_optimization);

#task24:Average competitor price comparison
SELECT ROUND(AVG(price),2) AS avg_our_price, ROUND(AVG(competitor_prices),2) AS avg_competitor
FROM pricing_optimization;

#task25:Find elasticity index effect

SELECT elasticity_index, ROUND(AVG(sales_volume),2) AS avg_sales
FROM pricing_optimization
GROUP BY elasticity_index;


#task26:Return rate per store

SELECT store_id, ROUND(AVG(return_rate_percent),2) AS avg_return_rate
FROM pricing_optimization
GROUP BY store_id;

#task27:Identify most profitable products (sales volume × price)

SELECT product_id, ROUND(SUM(price * sales_volume),2) AS total_revenue
FROM pricing_optimization
GROUP BY product_id
ORDER BY total_revenue DESC FETCH FIRST 5 ROWS ONLY;

#task28:Customer review analysis

SELECT ROUND(AVG(customer_reviews),2) AS avg_reviews
FROM pricing_optimization;

#task29:Top stores by average sales volume

SELECT store_id, ROUND(AVG(sales_volume),2) AS avg_sales
FROM pricing_optimization
GROUP BY store_id
ORDER BY avg_sales DESC FETCH FIRST 5 ROWS ONLY;

#task30:Price deviation from competitors

SELECT product_id, ROUND(price - competitor_prices,2) AS price_gap
FROM pricing_optimization
ORDER BY price_gap DESC;

#task31:Discount influence on return rate

SELECT ROUND(discounts,2), ROUND(AVG(return_rate_percent),2) AS avg_return
FROM pricing_optimization
GROUP BY discounts
ORDER BY discounts;

#task32:Find products with low stock (below their reorder point)

SELECT product_id, store_id, stock_levels, reorder_point
FROM inventory_monitoring
WHERE stock_levels < reorder_point;

#task33:Identify products that are about to expire in the next 30 days
SELECT product_id, store_id, expiry_date
FROM inventory_monitoring
WHERE expiry_date BETWEEN SYSDATE AND SYSDATE + 30;

#task34:Calculate the average supplier lead time by store
SELECT store_id, AVG(supplier_lead_time_days) AS avg_lead_time
FROM inventory_monitoring
GROUP BY store_id;

#task35:Find products with high return rate (>15%)

SELECT product_id, store_id, return_rate_percent
FROM pricing_optimization
WHERE return_rate_percent > 15;

#task36:Display top 10 most discounted products
SELECT product_id, store_id, discounts
FROM pricing_optimization
ORDER BY discounts DESC
FETCH FIRST 10 ROWS ONLY;


#task37:Calculate price elasticity impact on sales

SELECT product_id, store_id, elasticity_index, sales_volume
FROM pricing_optimization
WHERE elasticity_index > 0.7;

#task38:Find average storage cost per store
SELECT store_id, AVG(storage_cost) AS avg_storage_cost
FROM pricing_optimization
GROUP BY store_id;

#task39:Get total stock value per store (price × stock)

SELECT i.store_id, SUM(i.stock_levels * p.price) AS total_stock_value
FROM inventory_monitoring i
JOIN pricing_optimization p USING (product_id, store_id)
GROUP BY i.store_id;

#task40:Identify products with frequent stockouts (>5 times)

SELECT product_id, store_id, stockout_frequency
FROM inventory_monitoring
WHERE stockout_frequency > 5;

#task41:Find correlation pattern between discounts and sales volume (trend-style)
SELECT product_id, store_id, discounts, sales_volume
FROM pricing_optimization
ORDER BY discounts DESC, sales_volume DESC;


#task42:Check seasonal promotion impact (products having promotions during ‘Festive’ season)

SELECT product_id, promotions, seasonality_factors, sales_quantity
FROM demand_forecasting
WHERE LOWER(seasonality_factors) LIKE '%festive%'
  AND promotions IS NOT NULL;

#task43:Get stores with the highest lead time and lowest stock — risk zone

SELECT store_id, AVG(supplier_lead_time_days) AS avg_lead_time, SUM(stock_levels) AS total_stock
FROM inventory_monitoring
GROUP BY store_id
HAVING AVG(supplier_lead_time_days) > 10 AND SUM(stock_levels) < 500;

#task44:Find average product price variation across stores
SELECT product_id, MAX(price) - MIN(price) AS price_variation
FROM pricing_optimization
GROUP BY product_id;


#task45:Get top 5 products by total sales quantity

SELECT product_id, SUM(sales_quantity) AS total_sales
FROM demand_forecasting
GROUP BY product_id
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;


#task46:Find products with negative demand trend but high discounts

SELECT d.product_id, d.demand_trend, p.discounts
FROM demand_forecasting d
JOIN pricing_optimization p USING (product_id, store_id)
WHERE LOWER(d.demand_trend) = 'decreasing' AND p.discounts > 20;


#task47:Identify customer segments contributing highest revenue

SELECT customer_segments, SUM(sales_quantity * price) AS total_revenue
FROM demand_forecasting
GROUP BY customer_segments
ORDER BY total_revenue DESC;


#task48:Find slow-moving inventory (high stock but low sales)
SELECT i.product_id, i.store_id, i.stock_levels, d.sales_quantity
FROM inventory_monitoring i
JOIN demand_forecasting d USING (product_id, store_id)
WHERE i.stock_levels > 1000 AND d.sales_quantity < 100;

#task49:Check competitor price gap for each product


SELECT product_id, store_id, price, competitor_prices, (price - competitor_prices) AS price_gap
FROM pricing_optimization;

#task50:Find products having both high elasticity and high return rate

SELECT product_id, store_id, elasticity_index, return_rate_percent
FROM pricing_optimization
WHERE elasticity_index > 0.8 AND return_rate_percent > 10;





