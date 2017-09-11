DROP TABLE IF EXISTS ratings;

CREATE EXTERNAL TABLE ratings (
	book_id BIGINT, 
	user_id INT, 
	rating INT
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION 's3://goodreads-hive/hiveInput/';


DROP TABLE IF EXISTS books; 

CREATE EXTERNAL TABLE books (
id INT,
book_id BIGINT,
best_book_id BIGINT,
work_id BIGINT,
books_count INT,
isbn DOUBLE,
isbn13 DOUBLE,
authors STRING,
original_publication_year INT,
original_title STRING,
title STRING,
language_code STRING,
average_rating FLOAT,
ratings_count INT,
work_ratings_count INT,
work_text_reviews_count INT,
ratings_1 DOUBLE,
ratings_2 DOUBLE,
ratings_3 DOUBLE,
ratings_4 DOUBLE,
ratings_5 DOUBLE,
image_url STRING,
small_image_url STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION 's3://goodreads-hive/hiveInput/';


DROP TABLE IF EXISTS categories; 

CREATE EXTERNAL TABLE categories (
category STRING, 
count INT, 
book_id BIGINT
) 

ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION 's3://goodreads-hive/hiveInput/';



INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q1/pt3/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
-- Look at data 
SELECT * FROM categories LIMIT 10;


INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q1/pt1'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
-- Look at data 
SELECT * FROM books LIMIT 10;


INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q1/pt2/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
-- Look at data 
SELECT * FROM ratings LIMIT 10;

