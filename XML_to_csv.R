
library(XML)

path <- "C:/Users/board/Downloads/goodbooks-10k/"
path2 <- "books_xml/books_xml"

full_path<- paste0(path,path2)

setwd(full_path)

xml_csv_parse <- function(xml_file){
  
data <- xmlParse(xml_file)
xml_data <- xmlToList(data)

popular_shelves <- xml_data$book$popular_shelves

# Pre allocate space 
popular_shelves_df <- data.frame(matrix(999, nrow = length(popular_shelves), ncol = 2))
names(popular_shelves_df)[1:2] <- c("category","count")


for (ps_row in 1:length(popular_shelves)){
  temp_df <- t(as.data.frame(popular_shelves[ps_row]))
  popular_shelves_df[ps_row,] <- temp_df
}

xml_number <- substr(xml_file, 1, nchar(xml_file)-4)
write.csv(popular_shelves_df, paste0(path,"/csv/",xml_number ,".csv"), row.names = FALSE)
return () 
}

L = list.files(".", ".xml")
# Got an error for 20829994.xml -- xml file is not in correct format 
L = L[-c(80)]

O = lapply(L, xml_csv_parse)

#################################
### CSV info to single df ####### 
#################################

csv_dir <- paste0(full_path,"/csv")
setwd(csv_dir)
csv_list <- list.files(".", ".csv")


master_df <- data.frame(matrix(0, nrow = 0, ncol = 3))
names(master_df)[1:3] <- c("category", "count", "bookid")

for (csv_file_name in csv_list){
  
  csv <- read.csv(csv_file_name)
  bookid <- substr(csv_file_name, 1, nchar(csv_file_name)-4) # Remove ".xml"
  book_csv_details <- data.frame(cbind(csv, bookid))
  
  master_df <- data.frame(rbind(master_df, book_csv_details))
  
}

head(master_df)

# Confirm number of book ids 
length(unique(master_df$bookid))
length(csv_list)

# Unique categories 
length(unique(master_df$category))

length(unique(master_df$category))/ length(master_df)



# Export list 
setwd(path)
#write.csv(master_df, "BookID_Count_Category.csv", row.names = FALSE)


