# Load the necessary libraries
library(dplyr)
library(readxl)
library(tidyverse)
library(writexl)
library(lubridate)

df <- read_excel("G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022_Featured.xlsx")

print(head(df))

# Normalize function - MinMAx method
normalize <- function(x) {
  return ((x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE)))
}

df <- df %>%
  mutate(
    Age = normalize(Age),
    Time_diff = normalize(Time_diff)
  )

# Define which colums will be categorical
categorical_columns <- c("Urgency", "City", "Car_name", "medical_code", "Evacuation_destination", "Day_of_Week")

encode_label <- function(data, columns) {
  for (column in columns) {
    data <- data %>%
      mutate(!!sym(column) := as.numeric(factor(!!sym(column))))
  }
  return(data)
}

df <- encode_label(df, categorical_columns)

print(head(df))

write_xlsx(df, "G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022_Featured_Encoded.xlsx")

df <- df %>%
  select(-Arrival_hour)



decode_label <- function(data, columns) {
  for (column in columns) {
    levels <- sort(unique(data[[column]]))
    data[[column]] <- factor(data[[column]], levels = levels, labels = levels)
  }
  return(data)
}

df_decoded <- read_excel("G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022_Featured_Encoded.xlsx")
df_decoded <- decode_label(df_decoded, categorical_columns)