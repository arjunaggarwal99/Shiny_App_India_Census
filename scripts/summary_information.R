# Set up: Reading dataset file
india_census_df <- read.csv("data/india-districts-census-2011.csv",
                            stringsAsFactors = FALSE)

# Loading libraries
library("dplyr")
library("knitr")
library("tidyverse")

# Summary Information

## Total population of the country
total_pop <- india_census_df %>%
  select(Population) %>%
  sum()

## Male and Female Ratio across the country
male_female_ratio <- india_census_df %>%
  summarise(male_female_ratio =
              round((sum(Male) / sum(Female)), digits = 2)) %>%
  pull()

## State with Highest number of people
state_max_pop <- india_census_df %>%
  group_by(State.name) %>%
  summarise(state_population = sum(Population)) %>%
  filter(state_population == max(state_population, na.rm = TRUE)) %>%
  select(State.name) %>%
  pull()

## District with Lowest number of literate people
city_min_literate <- india_census_df %>%
  group_by(District.name) %>%
  summarise(literate_population = sum(Literate)) %>%
  filter(literate_population == max(literate_population, na.rm = TRUE)) %>%
  select(District.name) %>%
  pull()

## District with number of households with computer but not internet
computer_internet_diff_df <- india_census_df %>%
  mutate(all_households_with_comp_no_inter =
           Households_with_Computer - Households_with_Internet)

district_max_comp_without_inter <- computer_internet_diff_df %>%
  filter(all_households_with_comp_no_inter ==
           max(all_households_with_comp_no_inter, na.rm = TRUE)) %>%
  select(District.name) %>%
  pull()
