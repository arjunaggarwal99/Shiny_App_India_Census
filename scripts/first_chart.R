# This code aims to draw the relation between the male and.
#female workers in different districts of NCT of Delhi.The relation is
# depicted via a point plot

library("dplyr")
library("ggplot2")

#Reading the dataset file
india_census_df <- read.csv(file = "data/india-districts-census-2011.csv")

#Creating a dataframe of male and female workers from districts of New Delhi
male_fem_delhi_workers <- india_census_df %>%
  filter(State.name == "NCT OF DELHI") %>%
  select(Male_Workers, Female_Workers, District.name)

#Plotting the relation
male_and_female_plot <- ggplot(male_fem_delhi_workers,
aes(Male_Workers, Female_Workers, color = District.name)) +
geom_point() +
geom_text(aes(label = District.name),
stat = "identity", hjust = 0) +
labs(title
 = "Relation between male and female workers in districts of New Delhi",
     x = "Number of male workers",
    y = "Number of female workers")
