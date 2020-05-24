# This file calculates the summary table
# The table is grouped by each State

library(dplyr)

# Extracting data and storing it in a variable
census_df <- read.csv("data/india-districts-census-2011.csv")

# Creating a table grouped by state
summary_table <- census_df %>%
  group_by(State.name) %>%
  summarise("Total Population" = sum(Population),
            "No. of rural househols" = sum(Rural_Households),
            "No. of Urban Households" = sum(Urban_Households),
            "Total number of households" = sum(Rural_Households) + sum(Urban_Households)
  )
