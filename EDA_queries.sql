-- Exploratory Data Analysis(EDA)

-- Here we are just going to explore the data and find trends or patterns or anything interesting like outliers

select * from layoffs_2;

-- The Time Period Of Data 
select min(`date`),max(`date`)
from layoffs_2;

-- Looking at total_laid_off to see how big these layoffs were
select  max(total_laid_off) from layoffs_2;

--  Which companies had percentage_laid_off=1 which is basically 100 percent of the company laid off
select *, percentage_laid_off
from layoffs_2
where percentage_laid_off = 1
order by total_laid_off desc;
-- these are mostly startups it looks like who all went out of business during this time

-- if we order by funds_raised_millions we can see how big some of these 100% layoffs companies were
SELECT *
FROM layoffs_2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Industry with there maximun laidoff 
select industry, max(total_laid_off) as high_laid_offs
from layoffs_2
group by industry 
order by high_laid_offs desc ;

-- Indusrty with there total laid offs in past 4-5 years or in the dataset
select industry, sum(total_laid_off) as total_laidoffs
from layoffs_2
group by industry 
order by total_laidoffs desc ;

-- Company with there total laid offs in past 4-5 years or in the dataset
select company , sum(total_laid_off) 
from layoffs_2
group by company
order by  2 desc;

-- Country with there total laid off in the dataset
select country , sum(total_laid_off) 
from layoffs_2
group by country 
order by  2 desc;

-- total laid offs as Per Year 
select year(`date`) as year_ , sum(total_laid_off)
from layoffs_2
group by year_
order by year_ desc;

-- stage with total laid off in the data set 
select stage, sum(total_laid_off) 
from layoffs_2
group by stage
order by  2 desc;

-- total laid offs in the data set as per the month
select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_laidoff
from layoffs_2
where substring(`date`,1,7) is not null
group by `month`
order by `month` ;

-- Rolling Total of layoffs per month 
with rolling_ as
(select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_laidoff
from layoffs_2
where substring(`date`,1,7) is not null
group by `month`
order by `month` )
select `month`,total_laidoff ,
sum(total_laidoff) over( order by `month` ) as rolling_total 
from rolling_;

-- Companies With there total laid offs within a year
select company, year(`date`),sum(total_laid_off)
from layoffs_2
where  year(`date`) is not null
group by company,year(`date`)
order by 2, 3 desc;

-- Now we create a CTE for further querying the above query 

-- In this CTE we assign the ranks to the company's laidoffs as per year and then further more filter using 'where' clause 

with ranking_ as 
(select company, year(`date`) as year_,sum(total_laid_off) as total_laidoff
from layoffs_2
where  year(`date`) is not null
group by company,year_
) , filter_rank as 
(select * , dense_rank() over (partition by year_ order by total_laidoff desc) as rank_
from ranking_
)
select * from filter_rank
where rank_ <=5;

















