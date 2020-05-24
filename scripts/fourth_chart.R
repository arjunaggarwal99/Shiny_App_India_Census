library("dplyr")
library("ggplot2")
library("leaflet")
library("plotly")


census_file <- read.csv(file="data/india-districts-census-2011.csv")
temp2 <- census_file %>%
  filter(State.name=="NCT OF DELHI")

Scatter.1 = ggplot(data = temp2, aes(x = District.name, y = Male))+
  geom_point()
Scatter.1


Scatter.2 = ggplot(data = temp2, aes(x = District.name, y = Female))+
  geom_point()
Scatter.2
