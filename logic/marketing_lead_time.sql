/* FILENAME: marketing_lead_time.sql
   DESCRIPTION: Analyzes booking lead times per country to optimize marketing ad spend timing.
   LOGIC: 
     1. Cleans mixed date formats (Timestamp vs String) using COALESCE.
     2. Segments users into 4 behavioral buckets (Last Minute to Early Bird).
*/

SELECT
  Country,
  EXTRACT(YEAR FROM `Check-in`) AS checkin_year,
  -- FORMATTING: Adds month number (e.g., "01. January") so charts sort chronologically, not alphabetically.
  FORMAT_DATE('%m. %B', `Check-in`) AS checkin_month, 
  COUNT(DISTINCT `Booking Number`) AS total_bookings,
  
  -- Bucket 1: Last Minute (0 to 14 Days)
  -- Target: Urgent inventory clearing / Flash Sales
  SUM(CASE 
    WHEN DATE_DIFF(`Check-in`, 
      -- CLEANING LOGIC: Tries to read as Timestamp first; if NULL, parses as String (MM/DD/YYYY)
      COALESCE(
        EXTRACT(DATE FROM SAFE_CAST(`Reservation Date` AS TIMESTAMP)), 
        SAFE.PARSE_DATE('%m/%d/%Y', `Reservation Date`)
      ), DAY) BETWEEN 0 AND 14 THEN 1 
    ELSE 0 END) 
    AS bookings_0_to_14_days,

  -- Bucket 2: Short Notice (15 to 28 Days)
  -- Target: Standard monthly performance campaigns
  SUM(CASE 
    WHEN DATE_DIFF(`Check-in`, 
      COALESCE(
        EXTRACT(DATE FROM SAFE_CAST(`Reservation Date` AS TIMESTAMP)), 
        SAFE.PARSE_DATE('%m/%d/%Y', `Reservation Date`)
      ), DAY) BETWEEN 15 AND 28 THEN 1 
    ELSE 0 END) 
    AS bookings_15_to_28_days,

  -- Bucket 3: Standard Plan (29 to 42 Days)
  -- Target: "Always-on" marketing layer
  SUM(CASE 
    WHEN DATE_DIFF(`Check-in`, 
      COALESCE(
        EXTRACT(DATE FROM SAFE_CAST(`Reservation Date` AS TIMESTAMP)), 
        SAFE.PARSE_DATE('%m/%d/%Y', `Reservation Date`)
      ), DAY) BETWEEN 29 AND 42 THEN 1 
    ELSE 0 END) 
    AS bookings_29_to_42_days,

  -- Bucket 4: Early Birds (More than 42 Days)
  -- Target: Brand awareness & Long-term planning
  SUM(CASE 
    WHEN DATE_DIFF(`Check-in`, 
      COALESCE(
        EXTRACT(DATE FROM SAFE_CAST(`Reservation Date` AS TIMESTAMP)), 
        SAFE.PARSE_DATE('%m/%d/%Y', `Reservation Date`)
      ), DAY) > 42 THEN 1 
    ELSE 0 END) 
    AS bookings_plus_42_days,

  AVG(`Per Night`) AS average_nightly_rate_per_country

-- SANITIZED TABLE REFERENCE
FROM `your_project_id.marketing_data.main_bookings`
GROUP BY 
  Country, 
  checkin_year,
  checkin_month
ORDER BY 
  Country, 
  checkin_year DESC,
  checkin_month DESC;
