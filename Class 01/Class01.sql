SELECT * FROM classicmodels.employees;

Select * From employees;

Select firstName, lastName from employees;

# display first 5 rows
Select * from employees limit 5;

# display last 5 rows
Select * from employees order by employeeNumber desc limit 5;

# Pagination 
Select * from employees limit 5 offset 0;
Select * from employees limit 5 offset 5;

#  alias changing names
Select firstName as fname  from employees; 

# Filtering concepts
Select * from employees where email = "dmurphy@classicmodelcars.com"; 

Select * from employees where firstName = "Anthony" and lastName = "Bow";

Select * from employees where firstName = "Anthony" and lastName = "Boh";

Select * from employees where firstName = "Anthony" or lastName = "Boh";

Select * from employees where lastName != "Bow";

Select * from employees where firstName in("Leslie", "Mary");
Select * from employees where firstName in("Anthony", "Diane");
Select * from employees where firstName not in("Leslie", "Mary");

Select * from employees where firstName = "Leslie" or firstName = "Mary";

Select * from employees where reportsTo = "null"; # it not works becuase it is a value
Select * from employees where reportsTo = null; # it not works 
Select * from employees where reportsTo is null; # it works
Select * from employees where reportsTo is not null; # it shows all values that are not null

Select * from employees where officeCode >= 1 and officeCode <= 5;

Select * from employees where officeCode between 1 and 5;




use sakila;

select * from film;

Select * from film limit 5;

Select * from film order by film_id desc limit 5;

Select title, release_year from film;

Select * from film order by release_year limit 1 offset 2;

Select * from film limit 6 offset 19;

Select title as  movie_name from film;

Select * from film where rental_rate = 2.99;

Select * from film where rental_rate = 2.99 and rating = "PG";

Select * from film where rating in("PG", "PG-13");

Select * from film where rating = "PG" or rating = "PG-13";

Select * from film where (rating = "PG" or rating = "PG-13") and (rental_rate = 0.99);


Select rating from film where rating != "PG-13" and rating != "PG";

Select * from film where special_features = "Deleted Scenes";

Select * from film where special_features like "%Deleted Scenes%";


# Sub Queries
use classicmodels;

Select * from employees;

Select * from employees where employeeNumber = 1002;


Select * from employees where employeeNumber = (Select employeeNumber from employees where employeeNumber = 1002);


# subquerie placements
# where
# columns
# from


 Select 
	firstName as emp_fname, 
	lastName as emp_lname, 
	(
		Select 
		firstName as mgr_fname 
		#lastName as mgr_lname
		from employees as mgr_1
		where mgr_1.reportsTo =  emp_1.employeeNumber limit 1
    ) as mgr_1
from employees as emp_1;


Select  * from offices;

Select 
	firstName as emp_fname, 
	lastName as emp_lname, 
	(
		Select 
		city
		from offices as office_city
		where office_city.officeCode =  emp_1.officeCode limit 1
    ) as office_city
from employees as emp_1;

Select firstName as fname, lastName as lname, officeCode from employees 
where officeCode = (Select officeCode from offices where city = "Boston");

Select * from products where productLine = (Select productLine from productlines where productLine = "Motorcycles");
















