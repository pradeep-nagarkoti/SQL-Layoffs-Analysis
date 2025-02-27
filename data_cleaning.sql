-- SQL Project - Data Cleaning

# source of raw data 
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022



-- we follow few steps to clean our raw data 
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and remove them 
-- 4. remove any columns and rows that are not necessary - few ways


select* from layoffs;

 -- making a copy of raw data to perform operation on it
create table layoffs_
like layoffs;

  -- inserting all the data as present in raw table 
insert into layoffs_ 
select * from layoffs; 

  -- a layoffs_ is created which is clone of raw table 
select * from layoffs_;
                            --  DELETING DUPLICATE VALUES 
                            
 -- we use row_number with window function to find out the duplicate rows 
select * ,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_;
 
   -- checking how many duplicate row we have by where clause 
with cte_duplicates as
(select * ,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_
 )
 select * from cte_duplicates 
 where row_num >1;   # we can not directly delete duplicate in a cte table 
 
 -- for deleting duplicate we create a new table which contain an additional column row_num
CREATE TABLE layoffs_2 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   row_num int
);

select * from layoffs_2;

 -- inserting all the data in the new table with an additional data i.e  in row_num
insert into layoffs_2 
select * ,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_;
 
 -- delting the duplicate by using where condition on row_num column 
delete from layoffs_2
 where row_num>1;   #it find out the row which occure twice and more in the table 

select * from layoffs_2; # now we have a table which do not contain any duplicates 

                            -- standardizing data 
  -- trim the extra space in company column                           
select company , trim(company) 
 from layoffs_2;
  -- update the trim column into the table 
 update  layoffs_2 
 set company = trim(company);
 
                     -- select industry column for any update 
 select  distinct industry from layoffs_2
 order by industry;
 
 select * from layoffs_2
 where industry like 'crypto%';
 
 -- updating the company which have same functionality but have diffrent named entry in rows 
 update layoffs_2
 set industry = 'crypto'
 where industry like 'crypto%';
 
                           -- optimizing country column 
 select distinct country 
 from layoffs_2
 order by 1;
 
  -- trim any extra punctuation in the country name 
 select country , trim(trailing '.' from country )
 from layoffs_2;
 
  -- updating the data into the table 
 update layoffs_2
 set country = trim(trailing '.' from country );
 
                 -- changing data type of date table [taxt -> date ]
 
 select `date`,
str_to_date(`date`,'%m/%d/%Y') # use for text -> date 
 from layoffs_2;
 
update layoffs_2
set `date`= str_to_date(`date`,'%m/%d/%Y') ;

-- modify the data type of column on the table [text -> date]
alter table layoffs_2
modify column `date` date ;

                               --  REMOVING NULL values
                -- on industry column                
    # we should set the blanks to nulls since those are typically easier to work with                          
  update layoffs_2 
  set industry = null 
  where industry = '';
				
select * from layoffs_2
where industry is null ;

select * from layoffs_2
where company =  "Airbnb";

-- using a self join to populate the row which have null values by the similar row which have not null values 
select * from layoffs_2 t1
join layoffs_2 t2
on t1.company= t2.company
and t1.location= t2.location
where t1.industry is null 
and t2.industry is not null ;
 
 -- now update the null values by there corresponding values (populating the null values)
update layoffs_2 t1
join  layoffs_2 t2
on t1.company= t2.company
and t1.location= t2.location
 set t1.industry = t2.industry 
 where t1.industry is null 
 and t2.industry is not null ;
 
   # check out column total_laid_off and percantage_laid_off
   
  -- check out which company do not have any layoffs 
 select * from layoffs_2 
 where total_laid_off is null 
 and percentage_laid_off is null ;
 
 -- delete those rows which do not have any layoffs 
 delete from layoffs_2
 where total_laid_off is null 
 and percentage_laid_off is null ;
  
  -- droping the extra column which we added before, for our operations
alter table layoffs_2
drop row_num;

select * from layoffs_2;






                            














