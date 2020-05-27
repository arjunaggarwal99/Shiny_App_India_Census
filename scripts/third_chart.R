#This code aims to draw the relation betwen the literacy rates
#and state. This relatonship is depicted via a grouped plot
library("dplyr")
library("plotly")

#Reading the dataset file
india_census_df <- read.csv(file = "data/india-districts-census-2011.csv")

#Grouping all the literates(male and females) from a state together
literate_of_male_female <- india_census_df %>%
  group_by(State.name) %>%
  summarise(Male_Literate = sum(Male_Literate),
            Female_Literate = sum(Female_Literate))

#Creates a function that takes in dataframe as a parameter
#and returns a grouped chart
group_chart <- function(literate_of_male_female) {
  literacy_rate_plot <- plot_ly(
  data = literate_of_male_female,
  x = ~State.name,
  y = ~Male_Literate,
  type = "bar",
  name = "Number of male literates",
  width = 1200,
  height = 600
  ) %>%
  add_trace(
  y = ~Female_Literate,
  name = "Number of female literates") %>%
  layout(title = "Relationship between the literacy
         rates(males and females) in different states",
          xaxis = list(title = "Name of state"),
         yaxis = list(title = "Number of literates"),
         barmode = "group")
return(literacy_rate_plot)
}
