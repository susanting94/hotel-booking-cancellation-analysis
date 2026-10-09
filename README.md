# Hotel Booking Cancellation Analysis

**Tools:** PostgreSQL, SQL  
**Project Type:** Exploratory Data Analysis (EDA)  
**Dataset:** Hotel bookings demand (119,390 booking records)

## Project Overview

This project explores hotel booking cancellation patterns using SQL. The goal is to understand how cancellation rates vary by hotel type and booking lead time, and how these findings may support hotel operations and occupancy forecasting.

## Business Questions

1. Do City Hotels and Resort Hotels have different cancellation rates?
2. How does cancellation rate vary across booking lead-time groups?
3. Does the relationship between lead time and cancellation rate differ by hotel type?

## Data Preparation and Analysis

The dataset was imported into PostgreSQL. Initial data preparation included handling empty values in the `children` column and converting the column to an integer data type.

Basic data validation found no missing or negative lead-time values and no invalid cancellation indicators.

SQL queries were used to calculate booking counts, canceled bookings, and cancellation rates. Booking lead time was divided into five groups: 0–7, 8–30, 31–90, 91–180, and 181+ days.

The analysis used `CASE WHEN`, `GROUP BY`, `COUNT()`, `SUM()`, `ROUND()`, and `ORDER BY`.

## Key Findings

### 1. Cancellation Rates by Hotel Type

- **City Hotel:** 41.73%
- **Resort Hotel:** 27.76%

City Hotels had a higher cancellation rate than Resort Hotels in this dataset.

### 2. Cancellation Rates by Booking Lead Time

| Lead Time | Cancellation Rate |
|---|---|
| 0–7 days | 9.63% |
| 8–30 days | 27.86% |
| 31–90 days | 37.70% |
| 91–180 days | 44.71% |
| 181+ days | 57.01% |

Longer booking lead-time groups showed progressively higher cancellation rates.

### 3. Hotel Type and Lead Time

City Hotels had higher cancellation rates across all five lead-time groups.

The largest difference occurred for bookings made more than 180 days in advance:

- **City Hotel:** 64.06%
- **Resort Hotel:** 41.58%

## Business Interpretation

The findings suggest that booking lead time and hotel type may be useful factors when assessing cancellation risk.

Hotels could consider historical cancellation patterns when evaluating future booking volumes and occupancy forecasts. However, cancellation rates alone do not indicate actual revenue loss because canceled rooms may be resold.

Before recommending changes to booking or cancellation policies, additional analysis would be needed to understand factors such as booking channels, deposit policies, seasonal demand, and customer segments.

## Limitations

- The analysis identifies associations, not causal relationships.
- The dataset does not establish why individual bookings were canceled.
- Booking lead time is not the same as the number of days between cancellation and arrival.
- The analysis does not measure actual revenue losses or room resale outcomes.
- Market segments were identified, but their cancellation patterns were not analyzed.
- The initial data preparation was limited and does not represent a comprehensive data-quality audit.

## Conclusion

This project demonstrates how SQL can be used to explore hotel booking behavior and translate operational data into business insights.

The analysis highlights the importance of considering both hotel type and booking lead time when interpreting cancellation patterns. Further research would be required before making specific policy recommendations.

## Data Source

**Dataset:** Hotel bookings demand  
**Source:** Kaggle — qucwang  
**Dataset URL:** https://www.kaggle.com/datasets/qucwang/hotel-bookings-analysis-dataset/data

The dataset contains 119,390 hotel booking records and was used to explore booking cancellation patterns.# hotel-booking-cancellation-analysis
SQL analysis of hotel booking cancellation patterns by hotel type and lead time.
