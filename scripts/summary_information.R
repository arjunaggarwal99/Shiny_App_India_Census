# This R file will show some summary information about
# the country India's census data: about the population.

india_census_df <- read.csv("data/india-districts-census-2011.csv",
              stringsAsFactors = FALSE)

# Set up: Reading dataset file

# Loading libraries
library("dplyr")
library("knitr")
library("tidyverse")

# Summary Information
# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(df) {
  new_list <- list(
    #The total number of districts in different states of India.
    length = df %>% nrow(),
    # Total population of the country
    total_pop = df %>% summarise(total_pop = sum(Population)),
    # male and female ratio across the country
    male_female_ratio = df %>%
      summarise(male_female_ratio = round((sum(Male)/ sum(Female)),
                                          digits = 2)) %>% pull(),
    ## total number of agricultural workers
    total_agr_workers = df %>% summarise(tot_agr_workers = sum(Agricultural_Workers)),
    #difference in total male and female literates
    difference_male_female = df %>% summarise(diff = sum(Male_Literate) - sum(Female_Literate)) %>% select(diff) %>% pull(diff)
  )
  return(new_list)
}

summary_info_list <- get_summary_info(india_census_df)
