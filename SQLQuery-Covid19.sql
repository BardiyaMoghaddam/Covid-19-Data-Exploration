select*
from Covid19.dbo.CovidDeaths
order by 3,4

select*
from Covid19.dbo.CovidVaccinations
order by 3,4


select location,date,total_cases,new_cases,total_deaths,population
from Covid19.dbo.CovidDeaths
order by 1,2

--Total cases diagnosed with covid19 in different countries and how many of them are dead per day

select location,date,total_cases,new_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
from Covid19.dbo.CovidDeaths
order by 1,2

--lets see what is the percentage of death in Norway per day. The percentage shows the likelihood of daying due to covid19 in Norway per day.

select location,date,total_cases,new_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
from Covid19.dbo.CovidDeaths
where location='Norway'
order by 1,2

--Looking at the total cases vs the population per day
select location,date,total_cases, population,(total_cases/population)*100 AS got_Covid19
from Covid19.dbo.CovidDeaths
order by 1,2
--what percentage of population got Covid19 in Norway per day
select location,date,total_cases, population,(total_cases/population)*100 AS got_Covid19
from Covid19.dbo.CovidDeaths
where location='Norway'
order by 1,2

--What countries had the highest inffected covid19 based on the population

select location,max(total_cases) AS HighestInfection, population,MAX((total_cases/population)*100) AS got_Covid19
from Covid19.dbo.CovidDeaths
GROUP BY location, population
order by  got_Covid19 DESC

--what is the highest percentage of inffected people in Norway based on the population
select location,max(total_cases) AS HighestInfection, population,MAX((total_cases/population)*100) AS got_Covid19
from Covid19.dbo.CovidDeaths
where location='Norway'
GROUP BY location, population
order by  got_Covid19 DESC

--what is the highest percentage of death due to covid19 based on the population
select location,max(total_deaths) AS HighestDeath, population
from Covid19.dbo.CovidDeaths
GROUP BY location, population
order by  HighestDeath DESC

--it looks the data type for HighestDeath is not Correct and we have to cast the total death to int because right now it is varchar format which is text and is not numeric
select location,max(cast(total_deaths as int)) AS HighestDeath, population
from Covid19.dbo.CovidDeaths
GROUP BY location, population
order by  HighestDeath DESC

--there is a problem with the data location it includes not only the countries but also the continents

select*
from Covid19.dbo.CovidDeaths

--the data shows the continents as the location so we have to set the data where the continent is not null because when it is null it shows the continents in the country list
select location,max(cast(total_deaths as int)) AS HighestDeath, population
from Covid19.dbo.CovidDeaths
where continent is not null
GROUP BY location, population
order by  HighestDeath DESC

--which continents have higher death count per population

select continent, max(cast(total_deaths as int)) as HighestDeath
from Covid19.dbo.CovidDeaths
where continent is not null
GROUP BY continent
order by  HighestDeath DESC
