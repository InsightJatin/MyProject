-- NETFLIX CONTENT ANALYSIS........
select * from Netflix_Movies_and_TV_Shows;
select * from netflix_data;
rename table Netflix_Movies_and_TV_Shows to
netflix_data;

select count(*) from netflix_data;

update netflix_data set duration = case 
when duration like '%min%' then 'minutes'
else 'seasons'
end;
set sql_safe_updates = 0;

select * from netflix_data where country = 'unknown' and country is null;

select * from netflix_data where Rating = 'unknown' and country is null;

select  Rating , count(*) total_movies from netflix_data group by Rating;

update netflix_data set Rating = 
case
when Rating in('G','PG','TV-PG') then 'Kids'
when Rating in('PG-13','TV-14') then 'Teens'
when Rating in('R','TV-MA') then 'Adulte' 
else 'other'     
end;

alter table netflix_data rename column `Release Year` to Release_Year;

select Release_Year , Rating ,count(*)
total from netflix_data
group by Release_Year,Rating order by Release_Year;

select type,country , count(*) total from netflix_data
group by type,country order by type, total desc;

select country,Rating, count(*) total from netflix_data group by  Rating,
country order by Rating ,total desc;

select country , count(*) total,rank()
over(order by count(*)
desc)rnk_country from netflix_data group by country;

select country , round (count(*) * 100 / (select count(*) from 
netflix_data),2) percentage from netflix_data group by country order by percentage desc;




