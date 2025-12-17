# Market-Agile-Hospitality

## Executive Summary
In the fast-paced hospitality industry, marketing agility is critical to staying competitive. The "Market-Agile-Hospitality" project develops a Business Intelligence (BI) pipeline to optimize ad spend decisions based on lead-time trends. By leveraging advanced analytics and a cutting-edge Google Cloud Platform (GCP) stack, marketing teams can decide whether to "Pivot" or "Persevere" with ad campaigns. This ensures optimal allocation of resources and prevents wasted investments in underperforming markets.

## Technical Architecture
The solution is built as an end-to-end pipeline leveraging the following GCP services:

1. **Source Data: Google Sheets**
   - Marketing teams input raw data directly into shared Google Sheets.
   - The sheet acts as the single source of truth for initial data ingestion.

2. **Data Warehouse: BigQuery**
   - Data from Google Sheets is ingested and transformed in BigQuery.
   - Data cleaning and transformation utilize SAFE_CAST and COALESCE functions to handle common issues like missing values and datatype mismatches.
     ```sql
     SELECT 
         SAFE_CAST(COALESCE(raw_column, '0') AS INT64) AS cleaned_column 
     FROM dataset.source_table;
     ```

3. **Visualization: Looker Studio**
   - Interactive dashboards and reports are developed in Looker Studio.
   - These dashboards empower stakeholders with actionable insights by visualizing lead-time trends.

### Data Flow Summary
```
Google Sheets → BigQuery (ETL) → Looker Studio (Visualization)
```

## The 'Pivot vs. Persevere' Framework
Marketing insights are driven by grouping lead-time trends into key buckets:

- **0-14 Days**: Immediate bookings (short-term market behavior).
- **15-28 Days**: Near-future bookings (mid-term trends).
- **29-42 Days**: Long-term planning (early warning signals for market shifts).
- **42+ Days**: Strategic foresight (far-out trends impacting advertising budgets).

These lead-time buckets serve as predictive signals to guide decisions:
- **Pivot**: Explore alternative strategies when lead time trends deviate radically.
- **Persevere**: Invest confidently in campaigns that maintain predictable booking behaviors.

## Business Impact
This BI pipeline ensures marketing resources are used effectively by:

1. **Monitoring Market Dynamics**:
   - Enables real-time tracking of booking behaviors, segmented by lead times.

2. **Preventing Wasted Ad Spend**:
   - Quickly identifies when booking patterns diverge, signaling a need to cut losses or double down on effective markets.

3. **Improving ROI**:
   - Boosts overall profitability by refining campaign decisions based on robust data analysis.

By proactively identifying behavioral shifts in markets, this project helps hospitality businesses maintain market agility, optimize advertising spend, and stay ahead of the competition.

---

**Author:** [saptayh-8910](https://github.com/saptayh-8910)  
**Repository ID:** 1117926841