library(dplyr)
library(readxl)
library(tidyverse)
library(writexl)


df <- read_excel("G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022_AP.xlsx")
print(df)

# Feature Engineering

df <- df %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

df <- df %>%
  mutate(
    Month = month(Date),
    Day_of_Week = wday(Date, label = TRUE)
  )

df <- df %>%
  mutate(
    Arrival_hour = hour(Arrival_time)
  )

df <- df %>%
  mutate(
    Time_diff = as.numeric(difftime(Evacuation_end_time, Arrival_time, units = "mins"))
  )

print(head(df))

write_xlsx(df, "G:/R_projects/Data_Analysis_Final_Project/data/ER_Data_2022_Featured.xlsx")
