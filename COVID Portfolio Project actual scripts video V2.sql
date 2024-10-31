Select *
from PortfolioProject..CovidDeaths

Select *
from PortfolioProject..CovidDeaths
Where Continent is not null
order by 3,4

Select *
from PortfolioProject..CovidDeaths
order by 3,4

Select *
from PortfolioProject..CovidVaccinations
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)
From PortfolioProject..CovidDeaths
order by 1,2

SELECT Location, date, total_cases, total_deaths,
CASE
   WHEN total_cases = 0 THEN NULL
   ELSE (total_deaths / total_cases)
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2

SELECT Location, date, total_cases, total_deaths,
CASE
   WHEN total_cases = 0 THEN NULL
   ELSE (total_deaths / total_cases)*100
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2

SELECT Location, date, total_cases, total_deaths,
CASE
   WHEN total_cases = 0 THEN NULL
   ELSE (total_deaths / total_cases)*100
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%America%'
ORDER BY 1, 2

-- Loking at Total cases vs Population
-- Shows what percentage of population got Covid
Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
order by 1,2

Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentagePopulationInfected 
From PortfolioProject..CovidDeaths
Where location like '%America%'
order by 1,2


-- Looking at countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%America%'
Group by Location, Population
order by PercentagePopulationInfected desc

-- Showing Countries with Highest Death Count per Population
Select Location, MAX(Total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%America%'
Group by Location
order by TotalDeathCount desc

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%America%'
Group by Location
order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

-- Showing Countries with Highest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%America
Where continent is null
Group by Location
order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing contintents with the highesr death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS

SELECT Location, date, total_cases, total_deaths,
CASE
   WHEN total_cases = 0 THEN NULL
   ELSE (total_deaths / total_cases)*100
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
-- Where location like '%America%'
Where continent is not null
ORDER BY 1, 2


SELECT date, total_cases, total_deaths,
CASE
   WHEN total_cases = 0 THEN NULL
   ELSE (total_deaths / total_cases)*100
END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
-- Where location like '%America%'
Where continent is not null
ORDER BY 1, 2

elect date, SUM(new_cases), SUM(new_deaths) as DeathPercentage
From PortfolioProject..CovidDeaths
-- Where Location like '%America%'
Where continent is not null
Group By date
order by 1,2


SELECT date, 
       SUM(new_cases) AS total_cases, 
       SUM(new_deaths) AS total_deaths, 
       CASE 
           WHEN SUM(new_cases) = 0 THEN NULL
           ELSE (SUM(new_deaths) / SUM(new_cases)) * 100
       END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2


SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
       CASE 
           WHEN SUM(new_cases) = 0 THEN NULL
           ELSE (SUM(new_deaths) / SUM(new_cases)) * 100
       END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2


-- PortfolioProject..CovidVaccinations

Select *
From PortfolioProject..CovidVaccinations

Select *
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date

-- Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
order by 1,2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopeVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
order by 2,3


-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_vaccinations,  RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3
)
Select *
From PopvsVac



With PopvsVac (Continent, Location, Date, Population, New_vaccinations,  RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


--- TEMP TABLE

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into  #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From  #PercentPopulationVaccinated


DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into  #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
-- Where dea.continent is not null
-- order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From  #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea. location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3

Select * 
From PercentPopulationVaccinated
