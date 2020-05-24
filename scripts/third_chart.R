library("dplyr")
library("ggplot2")
library("leaflet")
library("plotly")

census_file <- read.csv(file="data/india-districts-census-2011.csv")

temp <- census_file %>%
        group_by(State.name) %>%
        summarise(Male_Literate=sum(Male_Literate), Female_Literate=sum(Female_Literate))

plot_bar <- plot_ly(
  data = temp,
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
  layout(title = "Relationship between the literacy rates(males and females) and states"
         , xaxis = list(title = "Name of state"), yaxis =
           list(title = "No of male and female literates"), barmode = "group")
plot_bar




