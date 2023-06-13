select *
from [Portfoilio_Project ]..Covid_Deaths
where continent is not null
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from [Portfoilio_Project ]..Covid_Deaths
order by 1,2


looking at the total cases vs total deaths
Shows likelyhood of dyiing if entract covid in your country
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
from [Portfoilio_Project ]..Covid_Deaths
where location like 'south africa'
order by 1,2

Looking at total Case vs population 

select location,date,total_cases,population, (total_cases/population)*100 as Invected_Percentage
from [Portfoilio_Project ]..Covid_Deaths
where location like 'south africa' and continent is not null
order by 1,2

Looking at countries with highestinfection rate compared to population
select location,population, max(total_cases) as highest_infeection_count,max((total_cases/population))*100 as Invected_Percentage
from [Portfoilio_Project ]..Covid_Deaths
where continent is not null
--where location like 'south africa'
group by location,population
order by Invected_Percentage desc

Showing Countries with Higest deat count per population

select location, max(cast(total_deaths as int)) as Total_Death_Count
from [Portfoilio_Project ]..Covid_Deaths
where continent is not null
Group by location
Order by Total_Death_Count desc

--Let's Breaks Things Down by Continent
select continent, max(cast(total_deaths as int)) as Total_Death_Count
from [Portfoilio_Project ]..Covid_Deaths
where continent is not null
Group by continent
Order by Total_Death_Count desc

 Global Numbers

select date,sum(new_cases) as New_Cases,sum(new_deaths) as New_Deaths,sum(new_deaths)/cast(sum(nullif(new_cases ,0))as float ) *100 as Death_Percentage
from [Portfoilio_Project ]..Covid_Deaths
where continent is not null 
group by date
order by 1,2



Lookinf at tottl population vs vaccinations

Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location,dea.date) 
as Rolling_People_Vaccinaited
from [Portfoilio_Project ]..Covid_Deaths dea
join [Portfoilio_Project ]..Covid_Vacinations vac
on dea.location = vac.location
and dea.date =vac.date
where dea.continent is not null
order by 2,3

Use CTE

With Pop_vs_Vac (continent,location,date,population,new_vaccinations,Rolling_People_Vaccinaited)
as 
(
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location,dea.date) 
as Rolling_People_Vaccinaited
from [Portfoilio_Project ]..Covid_Deaths dea
join [Portfoilio_Project ]..Covid_Vacinations vac
on dea.location = vac.location
and dea.date =vac.date
where dea.continent is not null
) 

Select * ,cast(Rolling_People_Vaccinaited as float)/cast(population as float)*100
from Pop_vs_Vac

Creating view to store data for visualizations

Create view Percentage_Population_Vaccinated as
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location,dea.date) 
as Rolling_People_Vaccinaited
from [Portfoilio_Project ]..Covid_Deaths dea
join [Portfoilio_Project ]..Covid_Vacinations vac
on dea.location = vac.location
and dea.date =vac.date
where dea.continent is not null