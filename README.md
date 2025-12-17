# Market Timing & Lead Time Analysis

This module focuses on **Marketing Spend Efficiency**. By analyzing the "Lead Time" (days between booking and arrival) per country, we determine exactly when to launch advertising campaigns for different regions.

## Business Logic & SQL Techniques

### 1. Data Cleaning (The `COALESCE` Strategy)
Real-world data often comes with inconsistent date formats (some as timestamps, some as text strings).
* **The Problem:** Standard date functions fail if the input format changes.
* **The Solution:** I implemented a robust `COALESCE` logic that attempts to cast the date as a Timestamp first; if that fails (returns NULL), it falls back to parsing it as a specific String format (`%m/%d/%Y`). This ensures 100% data coverage without errors.

### 2. Lead Time Bucketing (Segmentation)
Instead of a simple average, I segmented customers into actionable "Time Windows" using `CASE WHEN` logic:
* **Last Minute (0-14 Days):** Targets for "Flash Sales" and urgent inventory clearing.
* **Short Notice (15-28 Days):** Standard monthly campaigns.
* **Early Birds (42+ Days):** High-value targets for long-term brand awareness campaigns.

### 3. Visualization Optimization
* **Sorting Hack:** The query formats months as `'01. January', '02. February'` instead of just `'January'`. This forces the Visualization tool (Looker Studio) to sort months chronologically rather than alphabetically, fixing a common reporting UX issue.

## Data Pipeline

```mermaid
graph LR
    A["Raw Booking Data<br/>(Mixed Formats)"] -->|Ingest| B("BigQuery<br/>Staging")
    B -->|"SQL Transformation<br/>(Clean & Bucket)"| C{"BigQuery<br/>Lead Time Logic"}
    C -->|"Segmented Data"| D("Marketing<br/>Insights View")
    D -->|Visualizes| E["Looker Studio<br/>Heatmap"]
    
    style C fill:#f9f,stroke:#333,stroke-width:2px
```
