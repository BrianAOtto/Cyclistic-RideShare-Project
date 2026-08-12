Cyclistic-Rideshare-Project 🚲
Google Data Analytics Professional Certificate — Capstone Project
Cyclistic is a fictional bike-share company operating in Chicago. This project follows the six-phase data analysis process — Ask, Prepare, Process, Analyze, Share, Act — to understand how annual members and casual riders use Cyclistic bikes differently, with the goal of informing a marketing strategy to convert casual riders into annual members.

1. Ask
How do annual members and casual riders use Cyclistic bikes differently?

Business Problem:
•	Goal: Increase annual membership, which is more profitable than casual riders.
•	Strategy: Convert casual riders into members.
•	Barrier: Casual riders and annual members have completely different usage habits.
•	Solution: Analyze rider behavior to build a targeted, data-driven campaign.

Project requirements:
•	How do annual members and casual riders use Cyclistic bikes differently?
•	Why would casual riders buy Cyclistic annual memberships?
•	How can Cyclistic use digital media to influence casual riders to become members?

Objective: Provide the Cyclistic marketing team with actionable insights to support this decision-making.

2. Prepare
•	Historical trip data provided by Motivate International Inc. under license
•	Data sourced as 12 monthly CSV files, imported into SQL Server
•	Scope: trip data across 12 months, April 2025 – March 2026
•	~3.67 million rides analyzed after cleaning
•	Fields include ride ID, rideable type, start/end times, start/end station, coordinates, and rider type (member/casual)
•	Data credibility assessed: source is licensed, first-party trip data, reasonably current and comprehensive for the analysis period

3. Process
•	Combined the 12 monthly files into a single file in SQL Server for exploration, cleaning, and analysis
•	Cleaned and validated in SQL Server, then connected to Tableau for visualization
•	Removed/handled invalid or incomplete records
•	Standardized categorical values (e.g. rideable type labels, day-of-week formatting)
•	Built a supplementary ride-level export (ride ID, station, rider type, lat/lng) to support accurate station-level mapping, after identifying that a pre-aggregated station dataset was masking rider-type differences
•	Cross-validated chart-level aggregates against direct SQL queries to confirm accuracy
•	Documented the data model to support both business stakeholders and analytical teams

Tools used:
•	SQL Server — data cleaning, transformation, and validation
•	Tableau — visualization and dashboard design
•	Tableau Public — hosting the interactive dashboard

4. Analyze
The dashboard includes the following views:

#	Chart	Insight Focus
1	Bike Type: Member vs. Casual	Bike type preference by rider type
2	Seasonal Trends	Trip volume by month
3	Weekday vs. Weekend Pattern	Trip volume by day of week
4	Commute vs. Leisure Timing	Trip volume by hour of day
5	Average Daily Ride Duration	Ride duration by day of week
6	Start Station Trips — Member vs. Casual	Geographic usage intensity by rider type

An intro KPI tile shows total trip volume for Members vs. Casual riders to anchor the dashboard.

Key findings:
•	Volume: Members account for a substantially higher share of total trips than casual riders across nearly all hours of the day.
•	Bike type: Casual riders show no strong preference between classic and electric bikes, using both at similar rates — a potential opening for targeted bike-type promotions.
•	Timing: Both rider types peak in the evening, with secondary peaks in the morning and around lunch. The gap between Member and Casual ridership widens most sharply at 8 AM and 5 PM, consistent with Members using bikes for commuting.
•	Geography: Station usage is concentrated in the same general area for both groups (near parks, museums, and the riverfront), but Casual riders show denser clustering around landmark and leisure destinations like Navy Pier.

5. Share
View the interactive dashboard on Tableau Public → (add link once published)
The dashboard is designed to walk a non-technical stakeholder (e.g. the marketing director) from overall volume down through timing, duration, bike-type, and geographic patterns, closing with the station maps as the most actionable, visual takeaway. This addresses the key business metrics around bike usage, rider behavior, and ridership trends for strategic decision-making.

6. Act
(add your 3 recommendations here based on the findings above)
1.	
2.	
3.	

Repository Contents
├── README.md
├── data/           # cleaning & SQL Server scripts (if included)
├── tableau/         # Tableau workbook (.twbx), if included
└── docs/            # supporting write-up / case study summary

License
Cyclistic historical bike trip data provided by Motivate International Inc.

About Me
I'm Brian Otto, a data analyst and project manager with 20+ years of experience in banking and technology, including 15 years at JPMorgan Chase. I'm building on that foundation with hands-on SQL, Tableau, and Python projects like this one — pursuing certifications (Google Data Analytics, and currently the Salesforce Tableau Data Analyst cert) to formalize and extend those skills.

