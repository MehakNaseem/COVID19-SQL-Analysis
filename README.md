# COVID19-SQL-Analysis
Analyzed global COVID-19 trends using SQL — includes case analysis, death rates, vaccination progress and continent level summaries using JOINs, window functions and subqueries.
## 🛠️ Tools Used
- SQL (MySQL)
- DB Fiddle
- Our World in Data (Dataset)

## 📊 Queries Built

| # | Query | Skills Shown |
|---|-------|-------------|
| 1 | Total cases & deaths per country | GROUP BY, MAX |
| 2 | Death rate per country | Calculated columns |
| 3 | Infection rate vs population | Percentage calculation |
| 4 | Monthly trend of new cases | Date functions |
| 5 | Rolling 7 day average of cases | Window functions |
| 6 | Vaccination rate by country | JOIN |
| 7 | Continent level summary | Subquery |
| 8 | Full cases + vaccinations summary | Multi table JOIN |

## 💡 Key Insights
- USA had the highest total cases and deaths
- UK had the highest vaccination rate
- India had the highest infection rate relative to population
- Window functions were used to calculate rolling averages to smooth out daily spikes

## 🔗 Live Project
[View on DB Fiddle](https://www.db-fiddle.com/f/gwQm5xRhMmBamHU9q5Gtbq/0)
