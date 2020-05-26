# This file calculates the summary table of Rural and Urban
# households in India
# The table is grouped by each State

library(dplyr)

# Extracting data and storing it in a variable
india_census_df <- read.csv("data/india-districts-census-2011.csv",
                            stringsAsFactors = FALSE)

# Creating a table grouped by state
summary_table_households <- india_census_df %>%
  group_by(State.name) %>%
  summarise(rural_households = sum(Rural_Households),
            urban_households = sum(Urban_Households),
            total_households = sum(Rural_Households) +
            sum(Urban_Households)
  )

# Arranging the summary table in ascending order based
# on individual column values
summary_table_households <- arrange(summary_table_households,
                                    rural_households,
                                    urban_households,
                                    total_households)
