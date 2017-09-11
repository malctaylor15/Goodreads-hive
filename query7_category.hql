
INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q7/category_descriptions.txt'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT category, SUM(count) total_counts, SUM(DISTINCT book_id) number_of_books
FROM categories
GROUP BY category 
ORDER BY total_counts --2
LIMIT 30; 

INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q7/cat_ratings.txt'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT category, COUNT(*) numb_books_in_cat, AVG(avg_rating) avg_avg_rating
		  , AVG(sd_rating) avg_sd_rating
FROM categories 
JOIN book_rating_stats
ON categories.book_id = book_rating_stats.book_id
GROUP BY category
ORDER BY avg_avg_rating --2 
LIMIT 30; 


