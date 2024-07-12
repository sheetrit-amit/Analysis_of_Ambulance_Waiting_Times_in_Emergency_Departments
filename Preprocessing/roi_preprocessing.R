# Read the CSV file into a data frame
library(dplyr)
library(readxl)
library(tidyverse)

# Read the CSV file into a data frame
data <- read_excel("G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022.xlsx")
print(head(data))

summary(data$Age,na.rm = TRUE)

#test

colnames(data)<-c("Urgency","Date","City","Age","Car_name","Evacuation_destination","medical_code","Arrival_time","Evacuation_end_time") 

#we have 111 rows of people that bigger then 105. its probebly mistake so we decide to ...
#we remove 3 rows of age null.

data<-data[!is.na(data$Age), ]
filtered_df <- data[data$Age > 105, ]
print(filtered_df)
#data$Age[data$Age > 105] <- "-" 


#all date columns are valid
min_date <- min(data$Date)
max_date <- max(data$Date)
print(min_date)
print(max_date)
summary(data$Date)
summary(data$Arrival_time)
summary(data$Evacuation_end_time)


#without null values on date columns
na_age <- which(is.na(data$Date))
na_Arrival_time <- which(is.na(data$Arrival_time))
na_Evacuation_end_time <- which(is.na(data$Evacuation_end_time))
print(na_age)
print(na_Arrival_time)
print(na_Evacuation_end_time)


#valid
distinct_urgency_values <- unique(data$Urgency)
print(distinct_urgency_values)


distinct_counts <- data %>%
  summarise(across(everything(), n_distinct))
print(distinct_counts)

# Count null (NA) values in each column
null_counts <- data %>%
  summarise(across(everything(), ~ sum(is.na(.))))

# Print the results
print(null_counts)

data <- data %>%
  mutate(value = ifelse(is.na(City), "N/A", City))
print(data)

write_xlsx(data, "")
