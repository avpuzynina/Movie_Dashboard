select *
from Movies.dbo.movies

-- 1. Most popular movie genre produced by countries: genre, country, count of released movies
select country, genre, popular_genre 
		from (select country, genre, count_genre, MAX(count_genre) over (partition by country order by country) as popular_genre 
			from (select distinct country, genre, COUNT(genre) as count_genre 
				from Movies.dbo.movies
				where country != '0'
				group by country, genre) as pol) as pok
where popular_genre = count_genre
order by popular_genre desc

-- 2. Highest-grossing film: name, director, gross
select name, director, gross
from Movies.dbo.movies
where gross = (select MAX(gross) from Movies.dbo.movies)

-- 3. Count of movies released by countries: country, count of movies released by year
select country, year, COUNT(year) as count_movies
from Movies.dbo.movies
where country != '0'
group by country, year

-- 4. Top 10 Highly Rated Movies: Name, Director, Score
select top 10 name, director, MAX(score) as max_score
from Movies.dbo.movies
group by name, director, votes
order by max_score desc


