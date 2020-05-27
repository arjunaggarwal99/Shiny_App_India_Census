# This R file will show some summary information about
# the country India's census data: about the population.
a <- read.csv("data/india-districts-census-2011.csv",
                            stringsAsFactors = FALSE)
# Set up: Reading dataset file

# Loading libraries
library("dplyr")
library("knitr")
library("tidyverse")

# Summary Information
# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(df) {
  ret <- list(
  #The total number of districts in different states of India.
  length <- length(df),
  # Total population of the country
  total_pop <- select(df$Population) %>% sum(),
  # male and female ratio across the country
  male_female_ratio <- summarise(male_female_ratio =
                                       round((sum(df$Male) / sum(df$Female)), digits = 2)) %>% pull(),
  ## State with Highest number of people
  state_max_pop <- india_census_df %>%
    group_by(State.name) %>%
    summarise(state_population = sum(Population)) %>%
    filter(state_population == max(state_population, na.rm = TRUE)) %>%
    select(State.name) %>%
    pull(),
  ## District with Lowest number of literate people
  district_min_literate <- df %>%
    group_by(District.name) %>%
    summarise(literate_population = sum(Literate)) %>%
    filter(literate_population == max(literate_population, na.rm = TRUE)) %>%
    select(District.name) %>%
    pull(),
  
  ## District with number of households with computer but not internet
  total_pop <- df %>%
    select(Population) %>%
    sum()
  )
  return (ret)
}


