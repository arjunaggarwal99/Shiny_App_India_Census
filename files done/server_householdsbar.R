library(shiny)
library(plotly)
library(dplyr)
#Reading the dataframe
india_census_df <- read.csv("data/india-districts-census-2011.csv")

#Mutating a column that sums up rural and urban households
india_urban_rural_house_df <- india_census_df %>%
  mutate(Total_Households = Rural_Households + Urban_Households)

#Organizing states into 6 different regions
india_urban_rural_house_df <- india_urban_rural_house_df %>%
  group_by(State.name) %>%
  summarise("Total Households" = sum(Total_Households),
            "Rural Households" = sum(Rural_Households),
            "Urban Households" = sum(Urban_Households)) %>%
  mutate("Region" = c(
    "West", "South", "Northeast", "Northeast", "East", "North", "Central",
    "West", "West", "West", "West", "North", "North", "North",
    "East", "South", "South", "South", "Central", "West", "Northeast",
    "Northeast", "Northeast", "Northeast", "North", "East", "South",
    "North", "North", "Northeast", "South", "Northeast", "North",
    "North", "East"
  ))
# pp <- india_urban_rural_house_df %>%
#   select("Total Households", "Rural Households", "Urban Households", "Region") %>% group_by(Region) %>% sum("Total Households",  "Rural Households", "Urban Households")
#   # summarise("Total Households" = sum("Total Households"),
#   #           "Rural Households" = sum("Rural Households"),
#   #           "Urban Households" = sum("Urban Households"))

# Creating the function that has two parameters:
# input and output
server <- function(input, output) {
  output$title_name_bar <- renderText({
    return(input$title_name_bar)
  })
  
  output$chart_1 <- renderPlotly({
    household_plot <- plot_ly(
      data = india_urban_rural_house_df %>%
        select("Total Households", "Rural Households", "Urban Households", input$categorytype),
      x = ~get(input$categorytype),
      y = ~get("Total Households"),
      type = "bar",
      name = "No. of Total Households",
      width = 900,
      height = 400) %>%
      add_trace(
        y = ~get(input$type_of_household),
        name = paste0("No. of ", gsub( "_", " ", input$type_of_household))) %>%
      layout(title = paste(input$title_name_bar),
             xaxis = list(title = "Name of state"),
             yaxis = list(title = "Number of households"),
             barmode = "group")
    return(household_plot)
  })
}






