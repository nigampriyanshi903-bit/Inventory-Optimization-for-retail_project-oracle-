CREATE TABLE demand_forecasting (
    product_id NUMBER(10),
    forecast_date DATE,
    store_id NUMBER(10),
    sales_quantity NUMBER(10),
    price FLOAT,
    promotions VARCHAR2(100),
    seasonality_factors VARCHAR2(100),
    external_factors VARCHAR2(100),
    demand_trend VARCHAR2(100),
    customer_segments VARCHAR2(100)
);
CREATE TABLE inventory_monitoring (
    product_id NUMBER(10),
    store_id NUMBER(10),
    stock_levels NUMBER(10),
    supplier_lead_time_days NUMBER(10),
    stockout_frequency NUMBER(10),
    reorder_point NUMBER(10),
    expiry_date DATE,
    warehouse_capacity NUMBER(10),
    order_fulfillment_time_days NUMBER(10)
);
CREATE TABLE pricing_optimization (
    product_id NUMBER(10),
    store_id NUMBER(10),
    price FLOAT,
    competitor_prices FLOAT,
    discounts FLOAT,
    sales_volume FLOAT,
    customer_reviews FLOAT,
    return_rate_percent FLOAT,
    storage_cost FLOAT,
    elasticity_index FLOAT
);
SELECT COUNT(*) AS total_records, 'Demand Forecasting' AS table_name FROM demand_forecasting
UNION ALL
SELECT COUNT(*), 'Inventory Monitoring' FROM inventory_monitoring
UNION ALL
SELECT COUNT(*), 'Pricing Optimization' FROM pricing_optimization;

SELECT table_name FROM user_tables;



DESC DEMAND_FORECASTING;
DESC INVENTORY_MONITORING;
DESC PRICING_OPTIMIZATION;


