-- Query 1: Total Cases and Deaths per Country
SELECT country, 
       MAX(total_cases) AS total_cases,
       MAX(total_deaths) AS total_deaths
FROM covid_deaths
GROUP BY country
ORDER BY total_cases DESC;

-- Query 2: Death Rate per Country
SELECT country,
       MAX(total_cases) AS total_cases,
       MAX(total_deaths) AS total_deaths,
       ROUND((MAX(total_deaths) / MAX(total_cases)) * 100, 2) AS death_rate_percentage
FROM covid_deaths
GROUP BY country
ORDER BY death_rate_percentage DESC;

-- Query 3: Infection Rate vs Population
SELECT country,
       population,
       MAX(total_cases) AS total_cases,
       ROUND((MAX(total_cases) / population) * 100, 2) AS infection_rate_percentage
FROM covid_deaths
GROUP BY country, population
ORDER BY infection_rate_percentage DESC;

-- Query 4: Monthly Trend of New Cases
SELECT country,
       MONTH(date) AS month,
       YEAR(date) AS year,
       SUM(new_cases) AS total_new_cases,
       SUM(new_deaths) AS total_new_deaths
FROM covid_deaths
GROUP BY country, YEAR(date), MONTH(date)
ORDER BY country, year, month;

-- Query 5: Rolling 7 Day Average
SELECT country,
       date,
       new_cases,
       ROUND(AVG(new_cases) OVER (
           PARTITION BY country 
           ORDER BY date 
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) AS rolling_avg_cases
FROM covid_deaths
ORDER BY country, date;

-- Query 6: Vaccination Rate by Country
SELECT d.country,
       d.population,
       MAX(v.people_fully_vaccinated) AS fully_vaccinated,
       ROUND((MAX(v.people_fully_vaccinated) / d.population) * 100, 2) AS vaccination_rate_percentage
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.country = v.country
GROUP BY d.country, d.population
ORDER BY vaccination_rate_percentage DESC;

-- Query 7: Continent Level Summary
SELECT continent,
COUNT(DISTINCT country) AS total_countries,
SUM(total_cases_max) AS continent_total_cases,
SUM(total_deaths_max) AS continent_total_deaths,
ROUND(SUM(total_deaths_max) / SUM(total_cases_max) * 100, 2) AS continent_death_rate
FROM (
SELECT continent,
country,
MAX(total_cases) AS total_cases_max,
MAX(total_deaths) AS total_deaths_max
FROM covid_deaths
GROUP BY continent, country
) AS country_summary
GROUP BY continent
ORDER BY continent_total_cases DESC;

-- Query 8: Full JOIN Cases + Vaccinations
SELECT d.country,
       d.continent,
       d.population,
       MAX(d.total_cases) AS total_cases,
       MAX(d.total_deaths) AS total_deaths,
       ROUND((MAX(d.total_deaths) / MAX(d.total_cases)) * 100, 2) AS death_rate,
       MAX(v.people_fully_vaccinated) AS fully_vaccinated,
       ROUND((MAX(v.people_fully_vaccinated) / d.population) * 100, 2) AS vaccination_rate
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.country = v.country
AND d.date = v.date
GROUP BY d.country, d.continent, d.population
ORDER BY vaccination_rate DESC;
