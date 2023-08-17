SELECT *
FROM SQLPROJECT.dbo.VACCIN_RATE

SELECT dbo.DEATH_RATE.continent,dbo.DEATH_RATE.location,dbo.DEATH_RATE.date,dbo.DEATH_RATe.population,dbo.vaccin_rate.TOTAL_TESTS,
dbo.vaccin_rate.new_tests,dbo.vaccin_rate.total_vaccinations,dbo.vaccin_rate.new_vaccinations
from SQLPROJECT.dbo.DEATH_RATE
join SQLPROJECT.dbo.vaccin_rate
on dbo.DEATH_RATE.continent = dbo.vaccin_rate.continent
and dbo.DEATH_RATE.date = dbo.vaccin_rate.date
where dbo.DEATH_RATE.location like '%Nigeria%' and total_tests is not null

--Analyzing the relationship between population and vaccination rates in NIGERIA

CREATE TABLE #VACCIN_NIGERIA
(CONTINENT VARCHAR (50),
LOCATION VARCHAR (50),
DATE DATETIME,
POPULATION INT,
TOTAL_TESTS INT,
NEW_TESTS INT,
TOTAL_VACCINATIONS INT,
NEW_VACCINATIONS INT)

INSERT INTO #VACCIN_NIGERIA
SELECT dbo.DEATH_RATE.continent,dbo.DEATH_RATE.location,dbo.DEATH_RATE.date,dbo.DEATH_RATe.population,dbo.vaccin_rate.TOTAL_TESTS,
dbo.vaccin_rate.new_tests,dbo.vaccin_rate.total_vaccinations,dbo.vaccin_rate.new_vaccinations
from SQLPROJECT.dbo.DEATH_RATE
join SQLPROJECT.dbo.vaccin_rate
on dbo.DEATH_RATE.continent = dbo.vaccin_rate.continent
and dbo.DEATH_RATE.date = dbo.vaccin_rate.date
where dbo.DEATH_RATE.location like '%Nigeria%' and total_tests is not null

SELECT *
FROM #VACCIN_NIGERIA

--Divide by zero error encountered
SELECT CONTINENT,location,POPULATION,DATE,TOTAL_VACCINATIONS, (POPULATION/TOTAL_VACCINATIONS) AS VACCINATION_RATE
FROM #VACCIN_NIGERIA
WHERE TOTAL_VACCINATIONS IS NOT NULL

-- SORTED OUT divide by zero error encountered
SELECT CONTINENT,location,POPULATION,DATE,TOTAL_VACCINATIONS,
CASE
WHEN TOTAL_VACCINATIONS = 0 THEN NULL
ELSE (POPULATION/TOTAL_VACCINATIONS)
END AS VACCINATION_RATE
FROM #VACCIN_NIGERIA
WHERE POPULATION IS NOT NULL

SELECT CONTINENT,location,POPULATION,TOTAL_VACCINATIONS,DATE, population / (total_vaccinations + 0.0001) AS vaccination_rate
FROM #VACCIN_NIGERIA
WHERE population IS NOT NULL





