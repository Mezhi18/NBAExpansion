#### Preamble ####
# Purpose: Models... 
# Author: Rohan Alexander 
# Date: 11 February 2023 
# Contact: rohan.alexander@utoronto.ca 
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
NBA1980 <- read_csv("../data/raw_data/NBA1980.csv")
NBA1981 <- read_csv("../data/raw_data/NBA1981.csv")
NBA1982 <- read_csv("../data/raw_data/NBA1982.csv")
NBA1983 <- read_csv("../data/raw_data/NBA1983.csv")
NBA1984 <- read_csv("../data/raw_data/NBA1984.csv")
NBA1985 <- read_csv("../data/raw_data/NBA1985.csv")
NBA1986 <- read_csv("../data/raw_data/NBA1986.csv")
NBA1987 <- read_csv("../data/raw_data/NBA1987.csv")
NBA1988 <- read_csv("../data/raw_data/NBA1988.csv")
NBA1989 <- read_csv("../data/raw_data/NBA1989.csv")
NBA1990 <- read_csv("../data/raw_data/NBA1990.csv")
NBA1991 <- read_csv("../data/raw_data/NBA1991.csv")
NBA1992 <- read_csv("../data/raw_data/NBA1992.csv")
NBA1993 <- read_csv("../data/raw_data/NBA1993.csv")
NBA1994 <- read_csv("../data/raw_data/NBA1994.csv")
NBA1995 <- read_csv("../data/raw_data/NBA1995.csv")
NBA1996 <- read_csv("../data/raw_data/NBA1996.csv")
NBA1997 <- read_csv("../data/raw_data/NBA1997.csv")
NBA1998 <- read_csv("../data/raw_data/NBA1998.csv")
NBA1999 <- read_csv("../data/raw_data/NBA1999.csv")
NBA2000 <- read_csv("../data/raw_data/NBA2000.csv")
NBA2001 <- read_csv("../data/raw_data/NBA2001.csv")
NBA2002 <- read_csv("../data/raw_data/NBA2002.csv")
NBA2003 <- read_csv("../data/raw_data/NBA2003.csv")
NBA2004 <- read_csv("../data/raw_data/NBA2004.csv")
NBA2005 <- read_csv("../data/raw_data/NBA2005.csv")
NBA2006 <- read_csv("../data/raw_data/NBA2006.csv")
NBA2007 <- read_csv("../data/raw_data/NBA2007.csv")
NBA2008 <- read_csv("../data/raw_data/NBA2008.csv")
NBA2009 <- read_csv("../data/raw_data/NBA2009.csv")
NBA2010 <- read_csv("../data/raw_data/NBA2010.csv")
NBA2011 <- read_csv("../data/raw_data/NBA2011.csv")
NBA2012 <- read_csv("../data/raw_data/NBA2012.csv")
NBA2013 <- read_csv("../data/raw_data/NBA2013.csv")
NBA2014 <- read_csv("../data/raw_data/NBA2014.csv")
NBA2015 <- read_csv("../data/raw_data/NBA2015.csv")
NBA2016 <- read_csv("../data/raw_data/NBA2016.csv")
NBA2017 <- read_csv("../data/raw_data/NBA2017.csv")
NBA2018 <- read_csv("../data/raw_data/NBA2018.csv")
NBA2019 <- read_csv("../data/raw_data/NBA2019.csv")
NBA2020 <- read_csv("../data/raw_data/NBA2020.csv")
NBA2021 <- read_csv("../data/raw_data/NBA2021.csv")
NBA2022 <- read_csv("../data/raw_data/NBA2022.csv")
NBA2023 <- read_csv("../data/raw_data/NBA2023.csv")
NBA2024 <- read_csv("../data/raw_data/NBA2024.csv")

### setup data###
combined_data <- data.frame()

# Loop through the years 1980 to 2023
for(year in 1980:2024) {
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
  select(-G, -MP, -Rk)

# Creating table for league average
nba_data <- full_nba_data %>% 
  filter(Team == "League Average")

# Fit a multiple linear regression model
nba_model <- lm(PTS ~ Year + AST + TRB + STL + BLK + TOV + Num_Teams, data = nba_data)

create_future_data <- function(additional_teams) {
  latest_data <- tail(nba_data, 1)
  adjustment_factor <- 1 - 0.03 * additional_teams  # Each new team reduces stats by 3%
  data.frame(
    Year = c(2025, 2026, 2027),
    Num_Teams = latest_data$Num_Teams + additional_teams,
    AST = rep(latest_data$AST * adjustment_factor, 3),
    TRB = rep(latest_data$TRB * adjustment_factor, 3),
    STL = rep(latest_data$STL * adjustment_factor, 3),
    BLK = rep(latest_data$BLK * adjustment_factor, 3),
    TOV = rep(latest_data$TOV * adjustment_factor, 3)
  )
}

# Create data frames for each scenario
data_no_new_teams = create_future_data(0)
data_one_new_team = create_future_data(1)
data_two_new_teams = create_future_data(2)

predict_points <- function(data, scenario_name) {
  predictions <- predict(nba_model, newdata = data)
  return(data.frame(Teams = scenario_name, Year = c(2025, 2026, 2027), Predicted_PTS = predictions))
}

# Generate predictions for each scenario
predictions_no_new_teams <- predict_points(data_no_new_teams, "30")
predictions_one_new_team <- predict_points(data_one_new_team, "31")
predictions_two_new_teams <- predict_points(data_two_new_teams, "32")

# Combine predictions into a single data frame
all_predictions <- bind_rows(predictions_no_new_teams, predictions_one_new_team, predictions_two_new_teams)

# Reshape the data frame
wide_predictions <- all_predictions %>%
  pivot_wider(names_from = Year, values_from = Predicted_PTS, values_fill = list(Predicted_PTS = NA))



pred_table <- gt(wide_predictions) %>%
  tab_header(
    title = "Predicted Points Across Different Team Scenarios"
  ) %>%
  tab_style(
    style = list(
      cell_fill(color = "gray"),
      cell_text(color = "white", weight = "bold")
    ),
    locations = cells_column_labels(columns = everything())
  )
summary(nba_model)


#### Save model ####
saveRDS(nba_model,"../models/nba_model.rds")


