**Cyclistic-Rideshare-Project** 🚲
**Google Data Analytics Professional Certificate — Capstone Project**

Cyclistic is a fictional bike-share company operating in Chicago. This project follows the six-phase data analysis process — Ask, Prepare, Process, Analyze, Share, Act — to understand how annual members and casual riders use Cyclistic bikes differently, with the goal of informing a marketing strategy to convert casual riders into annual members.

**1. Ask**
How do annual members and casual riders use Cyclistic bikes differently?

**Business Problem:**
•	Goal: Increase annual membership, which is more profitable than casual riders.
•	Strategy: Convert casual riders into members.
•	Barrier: Casual riders and annual members have completely different usage habits.
•	Solution: Analyze rider behavior to build a targeted, data-driven campaign.

**Project requirements:**
•	How do annual members and casual riders use Cyclistic bikes differently?
•	Why would casual riders buy Cyclistic annual memberships?
•	How can Cyclistic use digital media to influence casual riders to become members?

**Objective:** Provide the Cyclistic marketing team with actionable insights to support this decision-making.

**2. Prepare**
•	Historical trip data provided by Motivate International Inc. under license
•	Data sourced as 12 monthly CSV files, imported into SQL Server
•	Scope: trip data across 12 months, April 2025 – March 2026
•	~3.67 million rides analyzed after cleaning
•	Fields include ride ID, rideable type, start/end times, start/end station, coordinates, and rider type (member/casual)
•	Data credibility assessed: source is licensed, first-party trip data, reasonably current and comprehensive for the analysis period

**3. Process**
•	Combined the 12 monthly files into a single file in SQL Server for exploration, cleaning, and analysis
•	Cleaned and validated in SQL Server, then connected to Tableau for visualization
•	Removed/handled invalid or incomplete records
•	Standardized categorical values (e.g. rideable type labels, day-of-week formatting)
•	Built a supplementary ride-level export (ride ID, station, rider type, lat/lng) to support accurate station-level mapping, after identifying that a pre-aggregated station dataset was masking rider-type differences
•	Cross-validated chart-level aggregates against direct SQL queries to confirm accuracy
•	Documented the data model to support both business stakeholders and analytical teams

**Tools used:**
•	SQL Server — data cleaning, transformation, and validation
•	Tableau — visualization and dashboard design
•	Tableau Public — hosting the interactive dashboard

**4. Analyze**
The dashboard includes the following views:

| # | Chart | Insight Focus |
|---|---|---|
| 1 | Bike Type: Member vs. Casual | Bike type preference by rider type |
| 2 | Seasonal Trends | Trip volume by month |
| 3 | Weekday vs. Weekend Pattern | Trip volume by day of week |
| 4 | Commute vs. Leisure Timing | Trip volume by hour of day |
| 5 | Average Daily Ride Duration | Ride duration by day of week |
| 6 | Start Station Trips — Member vs. Casual | Geographic usage intensity by rider type |

An intro KPI tile shows total trip volume for Members vs. Casual riders to anchor the dashboard.

**Key findings:**
•	**Volume:** Members account for a substantially higher share of total trips than casual riders across nearly all hours of the day.
•	**Bike type:** Casual riders show no strong preference between classic and electric bikes, using both at similar rates — a potential opening for targeted bike-type promotions.
•	**Timing:** Both rider types peak in the evening, with secondary peaks in the morning and around lunch. The gap between Member and Casual ridership widens most sharply at 8 AM and 5 PM, consistent with Members using bikes for commuting.
•	**Geography:** Station usage is concentrated in the same general area for both groups (near parks, museums, and the riverfront), but Casual riders show denser clustering around landmark and leisure destinations like Navy Pier.

**Section 5 (Share):**
View the interactive dashboard on Tableau Public → (link pending — dashboard is being finalized, including an update to the station map exports; link will be added once published)

**6. (Act):**
**1. Targeted, timing-aware advertising** — Use digital channels (social media, email newsletters, the mobile app) to highlight the convenience and cost savings of annual membership, timed to when casual ridership is highest: weekends and the August–September peak season.
**2. Membership-focused content** — Showcase the concrete benefits of membership (ease of access, availability of both bike types, exclusive perks) through content and testimonials from current members, aimed at casual riders who are already familiar with and using Cyclistic.
**3. Promotional campaigns tied to peak usage** — Run limited-time membership offers during peak season and weekends, paired with referral incentives for existing members, to convert riders who are already primed to upgrade.

**Repository Contents:**

├── README.md
├── data/                                       # SQL Server scripts — run in order
│   ├── 01_bulk_insert_consolidated_script.sql  # creates divvy_tripdata_consolidated (if not already present) and bulk-loads the 12 monthly CSVs
│   ├── 02_data_exploration_script.sql          # initial data profiling: data types, nulls, duplicates, date range, duration outliers
│   ├── 03_data_cleaning_script.sql             # creates divvy_tripdata_cleaned from the consolidated table (filters, calculated columns)
│   └── 04_data_analysis_script.sql             # summary queries used to build the Tableau dashboard
├── tableau/                                    # Tableau workbook (.twbx)
└── docs/                                       # data dictionary and full case study write-up

**License**
Cyclistic historical bike trip data provided by Motivate International Inc.

**About Me**
I'm Brian Otto, a data analyst and project manager with 20+ years of experience in banking and technology, including 15 years at JPMorgan Chase. I'm building on that foundation with hands-on SQL, Tableau, and Python projects like this one — pursuing certifications (Google Data Analytics, and currently the Salesforce Tableau Data Analyst cert) to formalize and extend those skills.

