-- CREATE DATABASE human_resources; 
USE human_resources;
-- Initial look at the table 
SELECT * FROM humanresources;
-- Renaming the table for ease
ALTER TABLE humanresources RENAME hr;
SELECT * FROM hr;
-- Renaming the first column appropriately
ALTER TABLE hr CHANGE COLUMN ï»¿id emp_id TEXT NULL;
DESCRIBE hr; -- Describing the entire table, listing columns and datatypes.

SELECT birthdate FROM hr;

-- Set SQL safe updates to zero
SET sql_safe_updates = 0;
SET GLOBAL sql_mode = "NO_ENGINE_SUBSTITUTION";
SET SESSION sql_mode = "NO_ENGINE_SUBSTITUTION";

--  birthdate has inconsistent date format, hence needs cleaning.
UPDATE hr SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Change birthdate data type from text/string to date data type
ALTER TABLE hr MODIFY COLUMN birthdate DATE;
DESCRIBE hr;
SELECT * FROM hr;
-- ===================================================================
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

DESCRIBE hr;

-- 4. Explore the hire_date column.
-- ================================
SELECT hire_date FROM hr;

-- hrie_date has inconsistent date format, hence needs cleaning.
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
SELECT * FROM hr;

-- 5. Change hire_date data type from text/string to data data type.alter
-- =======================================================================
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

DESCRIBE hr;

-- 6. Explore the termdate column.
-- ================================
SELECT termdate FROM hr;

-- Fill missing values
UPDATE hr
SET termdate = '0000-00-00 00:00:00 UTC'
WHERE termdate = '';

SELECT termdate FROM hr;


-- Change termdate format.
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'));

SELECT termdate FROM hr;

DESCRIBE hr;

-- 7. Change termdate data type from text/string to data type.alter
-- ================================================================
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

DESCRIBE hr;

-- 8. Add a column for Age
-- ========================
ALTER TABLE hr ADD COLUMN age INT;

DESCRIBE hr;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT age FROM hr;

-- Check for wrong Age
SELECT birthdate, age FROM hr
WHERE age < 0;

SELECT COUNT(age) FROM hr
WHERE age < 0;
-- ====The count of negated rows is 967=====

-- Count number of rows of age less than 18 
SELECT birthdate, age FROM hr
WHERE age < 18;

SELECT COUNT(*) FROM hr
WHERE age < 18;

-- ================Deleting the negated rows in "age" column========
SELECT COUNT(age) FROM hr WHERE age > 0;
SELECT COUNT(age) FROM hr;
-- =====The percentage of negated rows to the total number of rows is 4.35%,
-- and can be dropped without causing effects on the outcome===== --
SELECT * FROM hr WHERE age > 0;
SELECT * FROM hr;


-- =======QUESTIONS TO BE ANSWERED THROUGH VISUALIZATION============
-- 1. What is the gender breakdown of employees in the company?
-- 2. What is the race/ethnicity breakdown of employees in the company?
-- 3. What is the age distribution of employees in the company?
-- 4. How many employees work at headquarters versus remote locations?
-- 5. What is the average length of employment for employees who have been terminated?
-- 6. How does the gender distribution/count vary across departments and job titles?
-- 7. What is the distribution/count of job titles across the company?
-- 8. Which department has the highest turnover rate?
-- 9. What is the distribution/count of employees across locations by city and state?
-- 10. How has the company's employee count changed over time based on hire and term dates?

-- ===================================================================================
-- 1.
SELECT gender, COUNT(*) FROM hr WHERE age >= 18 AND termdate = "0000-00-00" GROUP BY gender;
-- 2.
SELECT race, COUNT(*) FROM hr WHERE age >= 18 AND termdate = "0000-00-00" GROUP BY race ORDER BY race;
-- 3.
SELECT CASE
	WHEN age >= 18 AND age <=24 THEN "18 - 24"
    WHEN age >= 25 AND age <=34 THEN "25 - 34"
    WHEN age >= 35 AND age <=44 THEN "35 - 44"
    WHEN age >= 45 AND age <=54 THEN "45 - 54"
    WHEN age >= 55 AND age <=64 THEN "55 - 64"
    ELSE "+65"
END AS age_group, COUNT(*) FROM hr WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY age_group ORDER BY age_group;
-- 4.
SELECT location, COUNT(*) FROM hr WHERE age >=18 AND termdate = "0000-00-00" GROUP BY location ORDER BY location;
-- 5. ***
-- SELECT (YEAR(hire_date) - YEAR(termdate)) AS length_of_stay FROM hr;
SELECT ROUND(AVG(stay), 0)
FROM (SELECT termdate, hire_date, YEAR(termdate)-YEAR(hire_date) AS stay FROM hr
WHERE age >= 18 AND termdate > "0000-00-00" AND termdate <= "2023-00-00") AS t;
-- 6.
SELECT department, jobtitle, gender, COUNT(*) FROM hr
WHERE age >= 18 AND termdate = "0000-00-00" 
GROUP BY department, jobtitle, gender ORDER BY department;
-- 7.
SELECT jobtitle, COUNT(*) AS staff_count FROM hr
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY jobtitle ORDER BY jobtitle;
-- 8.
SELECT department,
  total_count,
  terminated_count,
  terminated_count/total_count AS termination_rate
FROM (
  SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE
		WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() 
        THEN 1 ELSE 0 END) AS terminated_count
  FROM hr
  WHERE age >= 18
  GROUP BY department) AS t
ORDER BY termination_rate DESC;
-- 9. 
SELECT location, location_city, location_state, COUNT(*) AS num_of_employees
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location, location_city, location_state
ORDER BY location_state;
-- 10. 
SELECT year, hires, terminations, hires - terminations AS difference,
  ROUND(((hires - terminations)/hires) * 100, 2) AS difference_percentage
FROM (SELECT YEAR(hire_date) AS year, COUNT(*) AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
	FROM hr WHERE age >= 18 GROUP BY YEAR(hire_date)) AS t
ORDER BY year ASC;
