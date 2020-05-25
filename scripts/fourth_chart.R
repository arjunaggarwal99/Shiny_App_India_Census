#This code aims to draw the relation between the population
#(male and female) and the districts in New Delhi.The relation is
#depicted via a scatter plot

library("dplyr")
library("plotly")

#Reading the dataset file
india_census_df <- read.csv(file = "data/india-districts-census-2011.csv")

#Grouping all the districts of New Delhi
districts_of_delhi <- india_census_df %>%
  filter(State.name == "NCT OF DELHI")

#Drawing the plot for males
male_plot <- ggplot(data = temp2, aes(x = District.name, y = Male)) +
            geom_point()

#Drawing the plot for females
female_plot <- ggplot(data = temp2, aes(x = District.name, y = Female)) +
               geom_point()
