# 📊 SQL Layoffs Analysis  

## 📌 Overview  
This project analyzes company layoffs over the past 3-4 years using SQL. The dataset consists of raw layoff records that were cleaned and explored to derive meaningful insights.  

### 🔹 Key Operations:  
1. **Data Cleaning**: Removed duplicates, handled missing values, and standardized data formats.  
2. **Exploratory Data Analysis (EDA)**: Analyzed trends in layoffs across industries, companies,country,stage and time periods.  

## 🗂️ Repository Structure  
📁 sql-layoffs-analysis/
│-- 📄 data_cleaning.sql # SQL queries for cleaning the raw dataset
│-- 📄 eda_queries.sql # SQL queries for analyzing trends
│-- 📄 README.md # Project documentation


## 🛠️ SQL Operations  

### ✅ **Data Cleaning (`data_cleaning.sql`)**  
- Removed duplicate records  
- Handled missing/null values  
- Standardized data formats (date, text case, etc.)
- Remove any columns and rows that are not necessary  

### 📊 **Exploratory Data Analysis (`eda_queries.sql`)**  
- Industry-wise ,country-wise,stage-wise and company-wise layoffs
- Layoff trends over time/date  
- Identified peak layoff periods
- some more insights like Rolling Total 

## 📂 Dataset  
- **Source:** [https://www.kaggle.com/datasets/swaptr/layoffs-2022]  
- **Records:** [ total number of rows 2361 and 9 columns]  
- **Columns:** Company,location, Industry,total_laid_off,percentage_laid_off, Date,stage,country,funds_raised millions.  

## 🚀 How to Use  
1. Click the **"Code"** button at the top of this repository.  
2. Select **"Download ZIP"** and extract the files on your computer.  
3. Open your preferred SQL tool (MySQL, PostgreSQL, SQLite, etc.).  
4. Run `data_cleaning.sql` to clean the dataset.  
5. Run `eda_queries.sql` to analyze layoff trends.  

Alternatively, you can open the `.sql` files and copy-paste the queries into your SQL environment.  

## 💡 Insights & Findings  
- consumer industry faced the highest layoffs in the time of covid pandemic.  
- Layoffs peaked in Q1 of 2023 and exceed the past years laidoffs in just Q1.  
- Companies which are considerd as the start-ups  mostly had the 100 percent laidoffs. 

## 🏗️ Future Improvements  
- Adding visualization using Python (Matplotlib, Seaborn).  
- Expanding analysis to include more industries.  

## 🤝 Contributing  
Feel free to fork this repo and suggest improvements!  

