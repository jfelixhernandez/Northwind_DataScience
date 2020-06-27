# Northwind_DataScience

Northwind Forecast and Performance Evaluation

Problem 
The company requires a reliable way to evaluate near future performance for spend and savings at Region, Category, Customers, Vendors and Country, and act promptly to work on opportunities or risks.

Data available
1.	Historical Purchase Orders: data details about spend and savings trends, unit price, quantity at the required granularity level.
2.	Baselines: established price by the company for full year, that can be used to compare current and future purchases, and evaluate the amount of spend and savings generated.
3.	Net Requirements: system generated forecast for future material requirements at plant and material level.
Data Challenges

1.	Some purchases have been set wrong, so it’s is required to get correct last purchase price avoiding outliers.
2.	Some baselines may be not available or wrong set, it can be used last purchase price to compare an interval confidence to avoiding outliers.

Proposed Solution
1.	Get reliable data and handle outliers: enrich data with statistical measures like mean, mode for N months of the historical prices, and interquartile ranges, to identify reliable data and outliers.
2.	Prepare spend and savings data at weekly phase at Region, Category, Customer, Vendor level to generate forecast for 6 to 12 months using Time Series (ETS or ARIMA), and evaluate accuracy. Note: because some materials have no continue deliveries, constant data cannot be generated weekly at this level.
3.	Generate measures like Spend and Savings rate, like mean, standard deviation, quartile ranges for confidence interval and evaluate performance, this way can be identified risks or opportunities that may occur in the future like:
a.	Good Performance: if positive and increasing rate for Savings / Spend, and can be used to evaluate new projects or products offerings.
b.	Neutral or Poor performance: if near to 0 rate for Savings / Spend, it would mean that might be required to negotiate price with vendors to get better purchase prices.
c.	Bad Performance: if negative rate for Savings / Spend, it would mean that actions should be taken for that SCO or SCO group to reduce negative impacts.


