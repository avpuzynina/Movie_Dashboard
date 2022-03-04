select *
from Movies.dbo.movies

-- 1. Самый популярный жанр фильма выпускаемый странами: жанр, страна, число выпущенных фильмов
select country, genre, popular_genre 
		from (select country, genre, count_genre, MAX(count_genre) over (partition by country order by country) as popular_genre 
			from (select distinct country, genre, COUNT(genre) as count_genre 
				from Movies.dbo.movies
				where country != '0'
				group by country, genre) as pol) as pok
where popular_genre = count_genre
order by popular_genre desc

-- 2. Самый кассовый фильм: имя, режиссер, бюджет
select name, director, gross
from Movies.dbo.movies
where gross = (select MAX(gross) from Movies.dbo.movies)

-- 3. Количество выпускаемых фильмов странами: страна, количество выпускаемых фильмов по годам
select country, year, COUNT(year) as count_movies
from Movies.dbo.movies
where country != '0'
group by country, year

-- 4. Топ 10 фильмов с высокими оценками: имя, режиссер, оценка
select top 10 name, director, MAX(score) as max_score
from Movies.dbo.movies
group by name, director, votes
order by max_score desc


