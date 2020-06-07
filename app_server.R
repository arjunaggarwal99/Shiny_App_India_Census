# loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(styler)
library(lintr)
source("analysis.R")

# Creating the output server function for the app
server <- function(input, output) {
  # Redering the plotly of the bar chart for technogical advacements
  # of districts of different Indian states.
  output$techdistrictschart <- renderPlotly({
    districttechplotyl <- plot_ly(
      data = india_census_df_tech %>% filter(State.name == input$selectstate),
      x = ~District.name,
      y = ~ get("Households"),
      type = "bar",
      name = "Total Households",
      width = 850,
      height = 400
    ) %>%
      layout(
        title = paste0(
          "The number of households with computer and ",
          "internet in different districts of ",
          input$selectstate
        ),
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
  output$regionstransportchart <- renderPlotly({
    # Defining the plotly chart to be printed
    transportpiechart <- plot_ly(
      data = india_transport_by_regions %>%
        filter(Region == input$selectregion),
      labels = ~State.name,
      values = ~ get(input$transporttype),
      type = "pie"
    ) %>%
      layout(
        title = paste0(
          "Distribution of ", input$transporttype,
          "across regions of ", input$selectregion
        ),
        xaxis = list(
          showgrid = FALSE, zeroline = FALSE,
          showticklabels = FALSE
        ),
        yaxis = list(
          showgrid = FALSE, zeroline = FALSE,
          showticklabels = FALSE
        )
      )
    # Returning the above made plotly chart
    return(transportpiechart)
  })
  output$title_name_bar <- renderText({
    return(input$title_name_bar)
  })
  output$urbanruralchart <- renderPlotly({
    household_plot <- plot_ly(
      data = india_urban_rural_house_df %>%
        select(
          "Total Households", "Rural Households",
          "Urban Households", input$categorytype
        ),
      x = ~ get(input$categorytype),
      y = ~ get("Total Households"),
      type = "bar",
      name = "No. of Total Households",
      width = 850,
      height = 550
    ) %>%
      add_trace(
        y = ~ get(input$type_of_household),
        name = paste0("No. of ", gsub("_", " ", input$type_of_household))
      ) %>%
      layout(
        title = paste(input$title_name_bar),
        xaxis = list(title = paste0("Name of ", input$categorytype)),
        yaxis = list(title = "Number of households"),
        barmode = "group"
      )
    return(household_plot)
  })
}
