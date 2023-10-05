CREATE DATABASE netflix;

USE netflix;

-- titles available on netflix

SELECT DISTINCT title
FROM titles;

-- what is the total number of shows and movies available?

SELECT type, (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_titles
from titles
 /*Number of titles that are shows*/
group by type
;


SELECT count(id) as number_of_titles
from titles /*Number of titles */
;

SELECT count(id) as number_of_titles
from titles
WHERE type='show' /*Number of titles that are shows*/
;

SELECT count(id) as number_of_titles
from titles
WHERE type='movie' /*Number of titles that are movies*/
;



-- What is the total number of votes received on IMDb for all Netflix titles?

SELECT sum(imdb_votes) AS num_of_votes
from titles;


-- What is the distribution of IMDb votes for titles categorized as shows?

SELECT sum(imdb_votes) AS num_of_votes
from titles
WHERE type='show';


-- What is the distribution of IMDb votes for titles categorized as movies?

SELECT sum(imdb_votes) AS num_of_votes
from titles
WHERE type='movie';


-- How many unique actors and directors are there in the titles dataset?

SELECT count(DISTINCT id) as unique_actors
from credits
where role= 'ACTOR';


SELECT count(DISTINCT id) as unique_directors
from credits
where role= 'DIRECTOR';


-- What are the top 10 most popular titles on Netflix based on TMDB popularity?

SELECT title, tmdb_popularity
FROM titles
ORDER BY tmdb_popularity DESC
LIMIT 10;


-- distribution of genres

SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_drama_titles
FROM titles
WHERE genres LIKE '%drama%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_drama_titles
FROM titles
WHERE genres 
LIKE '%comedy%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_romance_titles
FROM titles
WHERE genres 
LIKE '%romance%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_action_titles
FROM titles
WHERE genres 
LIKE '%action%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_animation_titles
FROM titles
WHERE genres 
LIKE '%animation%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_documentation_titles
FROM titles
WHERE genres 
LIKE '%documentation%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_war_titles
FROM titles
WHERE genres 
LIKE '%war%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_horror_titles
FROM titles
WHERE genres 
LIKE '%horror%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_thriller_titles
FROM titles
WHERE genres 
LIKE '%thriller%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_scifi_titles
FROM titles
WHERE genres 
LIKE '%scifi%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_fantasy_titles
FROM titles
WHERE genres 
LIKE '%fantasy%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_western_titles
FROM titles
WHERE genres 
LIKE '%western%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_history_titles
FROM titles
WHERE genres 
LIKE '%history%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_music_titles
FROM titles
WHERE genres 
LIKE '%music%';


SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_family_titles
FROM titles
WHERE genres 
LIKE '%family%';

SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_european_titles
FROM titles
WHERE genres 
LIKE '%european%';



-- -- Which genres have the highest average IMDb scores, and which genres have the lowest average IMDb scores?
-- for shows

SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', n), ',', -1) AS genre,
    AVG(imdb_score) AS avg_imdb_score, AVG (tmdb_score) as avg_tmdb_score
FROM titles
INNER JOIN (SELECT 1 AS n UNION SELECT 2 AS n UNION SELECT 3 AS n UNION SELECT 4 AS n) AS nums
ON n <= LENGTH(genres) - LENGTH(REPLACE(genres, ',', '')) + 1
WHERE type= "show"
GROUP BY genre
ORDER BY avg_imdb_score desc , avg_tmdb_score DESC
LIMIT 5;

-- for movies

SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', n), ',', -1) AS genre,
    AVG(imdb_score) AS avg_imdb_score, AVG (tmdb_score) as avg_tmdb_score
FROM titles
INNER JOIN (SELECT 1 AS n UNION SELECT 2 AS n UNION SELECT 3 AS n UNION SELECT 4 AS n) AS nums
ON n <= LENGTH(genres) - LENGTH(REPLACE(genres, ',', '')) + 1
WHERE type= "movie"
GROUP BY genre
ORDER BY avg_imdb_score desc , avg_tmdb_score DESC
LIMIT 5;


-- Display the titles which have an imdb score above 8.0 (imdb score above 8.0 is considered good)

-- for movies
SELECT id, title, imdb_score, genres
FROM titles
WHERE imdb_score > '8.0'
and type= 'movie'
order by imdb_score
desc ;

-- for shows
SELECT id, title, imdb_score, genres
FROM titles
WHERE imdb_score > '8.0'
and type= 'show'
order by imdb_score
desc ;


-- Types of age certifications
 
SELECT DISTINCT age_certification
from titles;


-- Distribution of titles based on age certification

SELECT 
    age_certification, (COUNT(*) / (SELECT COUNT(*) FROM titles)) * 100 AS percentage_of_age_certification
FROM titles
group by age_certification;


-- Which year had the highest number of title releases, and how many titles were released in that year?

SELECT release_year, count(*) as releases
from titles
group by release_year
order by  release_year desc
;

SELECT release_year, count(*) as releases
from titles
group by release_year
order by  releases desc
;


-- What is the average IMDb score for titles released in each year?

SELECT release_year, avg(imdb_score) as average_imdb_score
from titles
group by release_year
order by release_year
desc;

-- where movies

SELECT release_year, avg(imdb_score) as average_imdb_score
from titles
where type ='movie'
group by release_year
order by average_imdb_score
desc;

-- for show

SELECT release_year, avg(imdb_score) as average_imdb_score
from titles
where type ='show'
group by release_year
order by average_imdb_score
desc;


-- Is there a relation between the number of seasons and imdb score?

SELECT title, release_year, imdb_score, seasons
from titles
where type ='show'
and seasons > '1'
order by imdb_score
desc;

-- Average imdb score by year

SELECT release_year, avg(imdb_score) as average_imdb_score, avg(seasons) as average_seasons
from titles
where type ='show'
group by release_year
order by average_imdb_score
desc;


-- Which directors have the highest IMDb scores on average for the titles they are associated with?

SELECT c.name, AVG(t.imdb_votes) AS average_imdb_votes
FROM titles AS t
INNER JOIN credits AS c ON t.id = c.id
WHERE c.role = 'director'
GROUP BY c.name
ORDER BY average_imdb_votes 
DESC;


-- What is the average runtime (in minutes) of movies and TV shows available on Netflix?

SELECT type, avg(runtime) as average_runtime
FROM titles
group by type;


-- How many titles have the same actor both as an actor and a director?

SELECT COUNT(*) AS no_of_titles
FROM titles AS t
INNER JOIN credits AS c
ON t.id = c.id AND c.role = 'actor'
INNER JOIN credits AS dc
ON t.id = dc.id AND dc.role = 'director'
WHERE c.name = dc.name;


-- How many titles are categorized as movies, and how many are categorized as TV shows?


SELECT count(id) as num_of_shows
from titles
where type='show';


SELECT count(id) as num_of_movies
from titles
where type='movie';


-- Which titles have the highest IMDb scores and the highest TMDB scores?


SELECT title, MAX(imdb_score) AS max_imdb, 
			  MAX(tmdb_score) AS max_tmdb
FROM titles
GROUP BY title
ORDER BY max_imdb 
DESC, 
max_tmdb 
DESC;


-- for shows
SELECT title, MAX(imdb_score) AS max_imdb, 
			  MAX(tmdb_score) AS max_tmdb
FROM titles
where type='show'
GROUP BY title
ORDER BY max_imdb 
DESC, 
max_tmdb 
DESC;


-- for movies
SELECT title, MAX(imdb_score) AS max_imdb, 
			  MAX(tmdb_score) AS max_tmdb
FROM titles
where type='movie'
GROUP BY title
ORDER BY max_imdb 
DESC, 
max_tmdb 
DESC;

SELECT title, imdb_score, tmdb_score
FROM titles
WHERE imdb_score = (SELECT MAX(imdb_score) FROM titles)
   OR tmdb_score = (SELECT MAX(tmdb_score) FROM titles)
ORDER BY imdb_score DESC, tmdb_score 
DESC;


-- How many titles have multiple seasons, and what is the average number of seasons for TV shows on Netflix?



SELECT count(id) as number_of_titles
from titles
where seasons>1
AND type='show';

SELECT round(avg(seasons)) AS average_num_of_seasons
from titles
WHERE type='show';


-- Which directors have the highest IMDb scores on average for the titles they are associated with?


SELECT c.name, c.role, AVG(t.imdb_score) AS average_imdb_score
FROM credits AS c
INNER JOIN titles AS t ON c.id = t.id
where c.role= 'director'
GROUP BY c.name, c.role
ORDER BY average_imdb_score 
DESC;


-- Who are the top 10 most frequent actors and directors in Netflix titles based on their appearances?

SELECT name, role, COUNT(*) AS appearance_count
FROM credits
where role= 'director'
GROUP BY name, role
ORDER BY appearance_count 
DESC
LIMIT 10;


/* What is the average IMDb score for titles with different runtime durations 
(e.g., less than 90 minutes, 90-120 minutes, more than 120 minutes, etc.)*/

SELECT CASE
WHEN runtime < 90 THEN 'Less than 90 minutes'
WHEN runtime >= 90 AND runtime <= 120 THEN '90-120 minutes'
WHEN runtime > 120 THEN 'More than 120 minutes'
END AS runtime_category,
ROUND(AVG(imdb_score),2) AS average_imdb_score
FROM titles
GROUP BY runtime_category
ORDER BY average_imdb_score 
DESC;


/* What is the average tmdb score for titles with different runtime durations 
(e.g., less than 90 minutes, 90-120 minutes, more than 120 minutes, etc.)*/


SELECT
CASE
WHEN runtime < 90 THEN 'Less than 90 minutes'
WHEN runtime >= 90 AND runtime <= 120 THEN '90-120 minutes'
WHEN runtime > 120 THEN 'More than 120 minutes'
END AS runtime_category,
ROUND(AVG(tmdb_score),2) AS average_tmdb_score
FROM titles
GROUP BY runtime_category
ORDER BY average_tmdb_score 
DESC;


-- How does the average IMDb score vary across different age certification categories?

SELECT age_certification, round(avg(IMDb_score),2) as average_imdb_score
FROM titles
group by age_certification
ORDER BY average_imdb_score
DESC;








 