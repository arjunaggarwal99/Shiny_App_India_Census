# loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

india_census_df <- read.csv("data/india-districts-census-2011.csv",
  stringsAsFactors = FALSE
)
india_census_df <- india_census_df %>%
  rename("Computer Households" = "Households_with_Computer",
         "Internet Households" = "Households_with_Internet")

# Creating the output server function for the app
server <- function(input, output) {
  # Redering the plotly of the bar chart for technogical advacements
  # of districts of different Indian states.
  output$techdistrictschart <- renderPlotly({
    districttechplotyl <- plot_ly(
      data = india_census_df %>% filter(State.name == input$selectstate),
      x = ~District.name,
      y = ~ get("Households"),
      type = "bar",
      name = "Total Households",
      width = 850,
      height = 400
    ) %>%
      layout(
        title = paste0("The number of households with coumputer and",
                       "internet in different districts of ",
                       input$selectstate),
        xaxis = list(title = "Names of Districts"),
        yaxis = list(title = "Number of Households"),
        barmode = "group"
      )
    # Adding trace of the checkBox widget of different technology options
    for (trace in input$technologyoption) {
      districttechplotyl <- districttechplotyl %>%
        add_trace(
          y = as.formula(paste0("~`", trace, "`")),
          name = trace
        )
    }
    # displays the created plot
    return(districttechplotyl)
  })
}
