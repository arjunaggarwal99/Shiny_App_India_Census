# This code aims to draw the relation between the population
# (male and female) and the districts in New Delhi.The relation is
# depicted via a scatter plot

library("dplyr")
library("plotly")

#Reading the dataset file
india_census_df <- read.csv(file = "data/india-districts-census-2011.csv")

#Grouping all the districts of New Delhi
districts_of_delhi <- india_census_df %>%
  filter(State.name == "NCT OF DELHI")

#Drawing the plot for rural household
rural_households_plot <- ggplot(data = districts_of_delhi, aes(x = District.name, y = Rural_Households, group=1)) +
  geom_point() + geom_line(color="red") 

#Drawing the plot for urban household
urban_households_plot <- ggplot(data = districts_of_delhi, aes(x = District.name, y = Urban_Households, group=1)) +
  geom_point() + geom_line(color="blue")

rural_households_plot
urban_households_plot

