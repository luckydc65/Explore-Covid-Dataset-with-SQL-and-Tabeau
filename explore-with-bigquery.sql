-- 1. Untuk Melihat Total Kasus, Total Kematian, dan Persentase kematian per kasus pada Covid-19

SELECT SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, 
    (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM `belajar-328708.Portfolio.CovidDeaths`
WHERE NOT continent = '';

-- 2. Total Kematian di setiap Benua

SELECT continent, SUM(new_deaths) AS TotalDeathCount
FROM `belajar-328708.Portfolio.CovidDeaths`
WHERE NOT continent = ''
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- 3. Melihat Negara dengan tingkat infeksi tertinggi dibandingkan dengan Populasi

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, 
    MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM `belajar-328708.Portfolio.CovidDeaths`
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- 4. Tingkat infeksi dari tiap negara berdasarkan tanggal

SELECT location, population, date, MAX(total_cases) AS HighestInfectionCount, 
    MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM `belajar-328708.Portfolio.CovidDeaths`
GROUP BY location, population, date
ORDER BY location, date DESC;


-- 5. Urutan negara dengan populasi terbanyak
SELECT location,MAX(population) AS NumberPopulation
FROM `belajar-328708.Portfolio.CovidDeaths`
WHERE NOT continent = ''
GROUP BY location
ORDER BY NumberPopulation DESC;

-- 6. Negara yang sudah mendapatkan vaksin penuh
WITH vaccin AS
(
SELECT vac.location, dea.population ,MAX(vac.people_fully_vaccinated) AS vaccinations
FROM `belajar-328708.Portfolio.CovidVaccinations` vac
JOIN `belajar-328708.Portfolio.CovidDeaths` dea
ON vac.location = dea.location 
    AND vac.date = dea.date
WHERE NOT vac.continent = ''
GROUP BY vac.location, dea.population)

SELECT *, (vaccinations/population)*100 AS PercentVaccinations
FROM vaccin
ORDER BY 4 DESC;
