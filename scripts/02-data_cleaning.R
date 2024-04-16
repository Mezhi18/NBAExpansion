#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... 
# Author: 
# Date: 6 April 2023 
# Contact: 
# License: MIT
# Pre-requisites: 
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)

#### Cleaning Data ####
combined_data <- data.frame()

# Loop through the years 1980 to 2023
for(year in 1980:2023) {
  # Read the CSV file for the year
  file_path <- sprintf("../data/raw_data/NBA%d.csv", year)
  yearly_data <- read_csv(file_path)
  
  # Add a year column
  yearly_data$Year <- year
  
  # Combine with the main data frame
  combined_data <- bind_rows(combined_data, yearly_data)
}

# Add the number of teams to the combined data before selecting columns
combined_data <- combined_data %>%
  mutate(Num_Teams = case_when(
    Year <= 1980 ~ 22,
    Year > 1980 & Year <= 1988 ~ 23,
    Year == 1989 ~ 25,  
    Year > 1989 & Year <= 1995 ~ 27,
    Year > 1995 & Year <= 2004 ~ 29,
    TRUE ~ 30  # For years after 2004
  ))

# Now remove less important columns
full_nba_data <- combined_data %>%
  select(-G, -MP, -`2P`, -`2PA`, -`2P%`, -Rk)

# Creating table for league average
nba_data <- full_nba_data %>% 
  filter(Team == "League Average")

#### Saving Clean Data ####
write.csv(nba_data, "../data/clean_data/nba_data.csv", row.names = FALSE)
write.csv(full_nba_data, "../data/clean_data/full_nba_data.csv", row.names = FALSE)
