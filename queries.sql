SELECT country, COUNT(*) AS total_titles
FROM netflix_titles_cleaned
WHERE date_added > '2019-01-01'  -- Filtering titles added after 2019
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

SELECT t1.show_id, t1.title, t1.director
FROM netflix_titles_cleaned t1
INNER JOIN netflix_titles_cleaned t2 ON t1.director = t2.director
WHERE t1.rating > 7
LIMIT 10;

SELECT t1.show_id, t1.title, t1.director
FROM netflix_titles_cleaned t1
LEFT JOIN netflix_titles_cleaned t2 ON t1.director = t2.director
LIMIT 10;

SELECT t2.director, t1.show_id, t1.title
FROM netflix_titles_cleaned t1
RIGHT JOIN netflix_titles_cleaned t2 ON t1.director = t2.director
LIMIT 10;

SELECT show_id, title, rating
FROM netflix_titles_cleaned
WHERE rating > (SELECT AVG(rating) FROM netflix_titles_cleaned)
LIMIT 10;

SELECT type, AVG(duration) AS avg_duration
FROM netflix_titles_cleaned
WHERE type = 'Movie'
GROUP BY type
ORDER BY avg_duration DESC
LIMIT 10;

-- Create a view for average rating by country
CREATE VIEW avg_rating_by_country AS
SELECT country, AVG(rating) AS avg_rating
FROM netflix_titles_cleaned
GROUP BY country;

-- Optimizing queries with an index on the 'release_year' column
CREATE INDEX idx_release_year ON netflix_titles_cleaned(release_year);

-- Querying the view created above
SELECT * FROM avg_rating_by_country
ORDER BY avg_rating DESC
LIMIT 10;