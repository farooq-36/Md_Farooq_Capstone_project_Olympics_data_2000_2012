-- Normalisation
--  1NF
	-- Columns should have atomic values 
	   -- each cell should have 1 value
       -- each value is not divisible
--  2NF
       -- No partial dependencies
	   -- All the non primary attributes should be fully functionally dependent on the candidate key
       -- Data base must be in first normal form
--  3NF 
       -- Remove Transitive Dependency 
       -- Non prime attribute should not give non prime attribute
       -- All fileds must be determine by only primary/composite key, not by any other key.
       
-- To make Olympic_data - normalize  , we create two tables - player_info and medal 

use olympics;    # use data base olympix

ALTER TABLE olympics.olypix ADD id Int NOT NULL AUTO_INCREMENT PRIMARY KEY;  # add id into olypix and set primary key

-- create table player_info
create table player_info(
id int(11) not null primary key auto_increment,
name varchar(50),
age varchar(25),
country  varchar(50),
year int(11),
Date_Given varchar(30),
sports varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
#  we created table and set id as primary key    

-- create table medal
create table medal(
id int(11) not null primary key auto_increment,
gold_medal int(11),
silver_medal int(11),
brone_medal  int(11),
total_medal int(11),
CONSTRAINT medal_fk
FOREIGN KEY (id) REFERENCES player_info (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
#  we created table and set id as primary key and foreign key      


-- inset values into table player_info from master table olympic_data
insert into player_info                      
select id, name, age, country, year, Date_Given, sports from olympix_data;   # here we selected specific columns to add values into player_info table

-- inset values into table medal from master table olympic_data
insert into medal 
select id, gold_medal, silver_medal, brone_medal, total_medal from olympix_data; # here we selected specific columns to add values into medal table

# Quries


-- Q1. Find the average number of medals won by each country
select country, avg(total_medal) from olypix  group by country;     
# use avg function and group by

-- Q2. Display the countries and the number of gold medals they have won in decreasing order
select country, sum(gold_medal) from  olypix group by country order by (sum(gold_medal)) desc; 
 # use group by and order by sum of gold_medal

-- Q3. Display the list of people and the medals they have won in descending order, grouped by their country
select  name, sum(total_medal) from olypix group by name order by (sum(total_medal)) desc; 
 # group by name and order by sum of total medal

-- Q4. Display the list of people with the medals they have won according to their their age
select name, age, sum(total_medal) from olypix  group by name order by age; 
 # use group by name order by age in ascending
select name, age, sum(total_medal) from olypix  group by name order by age desc;  
# use group by name order by age in descending

-- Q5. Which country has won the most number of medals
select  country, sum(total_medal) from olypix group by country order by (sum(total_medal)) desc limit 1;  
 # use of  max to get country won most number of medals
