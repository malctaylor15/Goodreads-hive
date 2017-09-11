

CREATE TABLE book_rating_stats AS 
SELECT stats.* ,count1, count5
FROM ratings_prelim_stats AS stats
JOIN (
SELECT book_id, COUNT(*) AS count1
FROM ratings
WHERE rating = 1
GROUP BY book_id
ORDER BY count1
) AS low_counts 
ON stats.book_id = low_counts.book_id 

JOIN (
SELECT book_id, COUNT(*) AS count5
FROM ratings
WHERE rating = 5
GROUP BY  book_id
ORDER BY count5
) AS high_counts
ON stats.book_id = high_counts.book_id ;


INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q6/bookstats.txt'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * 
FROM book_rating_stats
LIMIT 70; 
