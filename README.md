## Architecture & Automation

This project has been upgraded to an Automated Data Pipeline to ensure scalability and performance. By transitioning from static queries to automation, we have significantly reduced query costs and enhanced dashboard responsiveness.

### Automated Pipeline Flow
```mermaid
graph LR
    A[Google Sheets (Raw Booking Data)] --> |Scheduled Query| B[BigQuery (Lead-Time Bucketing + Cleaning)]
    B --> |Materialized Daily Results| C[Materialized Table]
    C --> |Live Connection| D[Looker Studio]
```

#### Why Automate the Pipeline?
- **Cost Efficiency**: Reduces query costs by using a materialized table instead of repeatedly querying raw spreadsheets.
- **Performance Optimization**: Ensures dashboards load instantly by connecting to a dedicated materialized table rather than the raw sheet.
- **Scalability**: Handles increasing data volumes effortlessly with scheduled tasks and streamlined processing.

---

## Data Engineering Logic

The pipeline leverages BigQuery to execute scheduled transformations, materializing results into a dedicated table for quick access.

### SQL Snippet for Data Transformation
```sql
CREATE OR REPLACE TABLE project_id.dataset.materialized_table AS
SELECT
    SAFE_CAST(COALESCE(raw_lead_time, '0') AS INT64) AS lead_time_bucket,
    PARSE_DATE('%Y-%m-%d', booking_date_column) AS cleaned_booking_date
FROM
    project_id.dataset.raw_table;
```

#### Value of Scheduled Queries
The pipeline runs a scheduled query (Cron job) at 6:00 AM daily, acting as a data snapshot to:
- Track booking behavior trends day-over-day.
- Maintain versioned snapshots for historical analysis.
- Guarantee freshly transformed data every morning.

---

## Business Value

By automating the pipeline to refresh data at 6:00 AM daily:
- **Marketing Team Efficiency**: Enables the team to start their day with fresh insights, no waiting for manual processes.
- **Enhanced Decision-Making**: Provides early signals on lead-time trends to optimize ad spend decisions immediately.
- **Maximized ROI**: Prevents resource waste by catching booking behavior changes early.

This automated solution is designed for scalability, ensuring the system performs optimally across larger datasets while delivering actionable insights to stakeholders promptly.
