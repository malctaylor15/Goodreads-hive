INSERT OVERWRITE DIRECTORY 's3://goodreads-hive/hiveOutput/q3/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM ratings LIMIT 10; 