# SQL Join exercise
#
#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
select * from world.city where name like "ping%" order by population asc;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
select * from world.city where name like "ran%" order by population desc;
#
# 3: Count all cities
select count(*) from world.city;
#
# 4: Get the average population of all cities
select AVG(population) from world.city;
#
# 5: Get the biggest population found in any of the cities
select max(Population) from world.city;
#
# 6: Get the smallest population found in any of the cities
select min(population) from world.city;
#
# 7: Sum the population of all cities with a population below 10000
select sum(population) from world.city where population < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
select count(*) from world.city where CountryCode in ("MOZ","VNM");
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
select count(*) from world.city where CountryCode in ("MOZ","VNM") group by CountryCode;
#
# 10: Get average population of cities in MOZ and VNM
select avg(population) from world.city where CountryCode in ("MOZ","VNM");
#
# 11: Get the countrycodes with more than 200 cities
select count(*) as citycount from world.city group by countrycode having citycount > 200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
select count(*) as citycount from world.city group by countrycode having citycount > 200 order by citycount asc;
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
select language from world.countrylanguage where CountryCode in (select CountryCode from world.city where Population between 400 and 500);
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
select city.name, countrylanguage.language 
from world.countrylanguage 
inner join world.city on city.countrycode = countrylanguage.countrycode 
where city.population between 500 and 600;
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
select name from world.city where CountryCode = (select CountryCode FROM world.city where Population = 122199);
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
select name from world.city where CountryCode = (select CountryCode FROM world.city where Population = 122199) and id != (select id from world.city where Population = 122199);
#
# 17: What are the city names in the country where Luanda is capital?
select name 
from world.city 
where CountryCode = (select CountryCode  from world.country inner join world.city on city.id = country.capital where world.city.Name = "luanda");
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
select city.name 
from world.city inner join world.country on city.id = country.capital 
where country.region = (select region from world.country where code = (select CountryCode from world.city where Name ="yaren"));
#

# 19: What unique languages are spoken in the countries in the same region as the city named Riga
select distinct language 
from world.countrylanguage 
where CountryCode in (
	#finding multiple countrycodes in the region
	select code 
	from world.country 
	where region = (
		#finding the distinct region of riga
		select distinct country.region
		from world.city inner join world.country on city.CountryCode = country.Code 
		where city.countrycode = (
			#the one countrycode of riga
			select CountryCode 
			from world.city 
            where name = "riga"
		)
	)
);
#
# 20: Get the name of the most populous city
#
select name from world.city order by Population desc limit 1;
