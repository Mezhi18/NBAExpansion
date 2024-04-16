#### Preamble ####
# Purpose: Simulates NBA Data Based on Given Data
# Author: Yan Mezhiborsky
# Date: 18 April 2024
# Contact: yan.mezhiborsky@mail.utoronto.ca



#### Workspace setup ####
library(tidyverse)


#### Simulate data ####

sim_nba_data <- data.frame(
  Year = rep(1980:2023, times = 10),  # Simulate 10 records per year
  Num_Teams = c(rep(22, each = 1 * 10),
                rep(23, each = 8 * 10),
                rep(25, each = 1 * 10),
                rep(27, each = 6 * 10),
                rep(29, each = 9 * 10),
                rep(30, each = 19 * 10)),  # Adjusted each parameter as needed
  PTS = rnorm(440, mean = mean(full_nba_data$PTS), sd = sd(full_nba_data$PTS)),  
  AST = rnorm(440, mean = mean(full_nba_data$AST), sd = sd(full_nba_data$AST)), 
  TRB = rnorm(440, mean = mean(full_nba_data$TRB), sd = sd(full_nba_data$TRB)),  
  STL = rnorm(440, mean = mean(full_nba_data$STL), sd = sd(full_nba_data$STL)),  
  BLK = rnorm(440, mean = mean(full_nba_data$BLK), sd = sd(full_nba_data$BLK)),  
  TOV = rnorm(440, mean = mean(full_nba_data$TOV), sd = sd(full_nba_data$TOV)) 
)

sim_nba_data

