-- Selecting all of the data to work with
-- Deleting all the rows that was not part of the data set back to original form

select *
from Bella_beats.[dailyCalories_merged v1.1]

select *
from Bella_beats.[dailyIntensities_merged v1.1]

select *
from Bella_beats.[dailySteps_merged v1.1]

select *
from Bella_beats.[sleepDay_merged v1.1]

select *
from Bella_beats.[weightLogInfo_merged V1.1]

select *
from Bella_beats.heartrate_seconds_merged



-- Formating date in correct format

alter table Bella_beats.[dailyCalories_merged v1.1]
alter column ActivityDay date

select *
from Bella_beats.[dailyCalories_merged v1.1]


alter table Bella_beats.[sleepDay_merged v1.1]
alter column SleepDay date

select *
from Bella_beats.[sleepDay_merged v1.1]

alter table Bella_beats.[weightLogInfo_merged V1.1]
alter column Date date
select *
from Bella_beats.[weightLogInfo_merged V1.1]


alter table Bella_beats.[dailyIntensities_merged v1.1]
alter column ActivityDay date
select *
from Bella_beats.[dailyIntensities_merged v1.1]


alter table Bella_beats.[dailySteps_merged v1.1]
alter column ActivityDay date

select *
from Bella_beats.[dailySteps_merged v1.1]



alter table Bella_beats.heartrate_seconds_merged
alter column time date

select *
from Bella_beats.heartrate_seconds_merged
where Time is not null

--amount of test subjects
--33 distinct OBS

select count(distinct(Id)) as Distinct_ID
from Bella_beats.[dailyCalories_merged v1.1]

--33 distinct OBS

select count(distinct(Id)) as Distinct_ID
from Bella_beats.[dailyIntensities_merged v1.1]

--33 distinct OBS

select count(distinct(Id)) as Distinct_ID
from Bella_beats.[dailySteps_merged v1.1]

--24 distinct OBS

select count(distinct(Id)) as Distinct_ID
from Bella_beats.[sleepDay_merged v1.1]

--8 distinct OBS

select count(distinct(Id)) as Distinct_ID
from Bella_beats.[weightLogInfo_merged V1.1]

--Converting min to hours

select cast(TotalMinutesAsleep/60.00 as decimal (5,2)) as SleepHours
from Bella_beats.[sleepDay_merged v1.1]

--Selecting some aggregate functions from the different data sets

select distinct(Id),max(Calories)
from Bella_beats.[dailyCalories_merged v1.1]
group by Id


select distinct(Id),avg(cast(VeryActiveDistance as decimal(5,2))) as Very_Active_Distance
from Bella_beats.[dailyIntensities_merged v1.1]
group by Id
order by 2 desc


select distinct(id), max(StepTotal) as Max_Steps,min(StepTotal) as Min_Steps,avg(cast(StepTotal as int)) as AVG_Steps
from Bella_beats.[dailySteps_merged v1.1]
group by Id
--order by 2 desc


select distinct (Id),MAX( TotalSleepRecords) as Max_Sleep_Minutes_Record,max(TotalMinutesAsleep) as Max_Minutes_Asleep,max(TotalTimeInBed) as Max_Time_In_Bed
from Bella_beats.[sleepDay_merged v1.1]
group by Id
order by 2 desc

select distinct (Id),min( TotalSleepRecords) as Min_Sleep_Minutes_Record,Min(TotalMinutesAsleep) as Min_Minutes_Asleep,min(TotalTimeInBed) as Min_Time_In_Bed
from Bella_beats.[sleepDay_merged v1.1]
group by Id
order by 2 desc



--Comparing total sleep

select  distinct(id),
max(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as SleepHours,
sum(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as Total_SleepHours,
avg(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as AVG_SleepHours
--datename(month,SleepDay) as Month
from Bella_beats.[sleepDay_merged v1.1]
--where Month like ('April')
group by Id
--order by Id, month asc

--Joining tables

select distinct(dc.Id),*
from Bella_beats.[dailyCalories_merged v1.1] DC
left outer join Bella_beats.[dailyIntensities_merged v1.1] DI
on DC.Id=DI.Id
left outer join Bella_beats.[dailySteps_merged v1.1] DS
on DS.Id=DC.Id


-- Extracting month name from date

select DATEname(MONTH, ActivityDay)
from Bella_beats.[dailySteps_merged v1.1]


--Comparing total sleep

select  distinct(id),
max(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as SleepHours,
sum(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as Total_SleepHours,
avg(CAST( TotalMinutesAsleep/60.00 as decimal(5,2))) as AVG_SleepHours
--datename(month,SleepDay) as Month
from Bella_beats.[sleepDay_merged v1.1]
--where Month like ('April')
group by Id
--order by Id, month asc

--Working out the avrage heart rate per user per day
-- and per month
select Time, AVG(value) as AVG_Heart_Rate,Id
from Bella_beats.heartrate_seconds_merged
--where Time is not null
group by time,Id
order by Time asc

-- April
select Time, AVG(value) as AVG_Heart_Rate,Id
from Bella_beats.heartrate_seconds_merged
where Time between '2016-04-12' and '2016-04-30'
group by time,Id
order by Time asc

--May
select Time, AVG(value) as AVG_Heart_Rate,Id
from Bella_beats.heartrate_seconds_merged
where Time between '2016-05-01' and '2016-05-30'
group by time,Id
order by Time asc
