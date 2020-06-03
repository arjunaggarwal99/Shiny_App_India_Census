# loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(styler)
library(lintr)
library(ggplot2)

india_census_df <- read.csv("data/india-districts-census-2011.csv",
                            stringsAsFactors = FALSE
)
india_census_df_tech <- india_census_df %>%
  rename("Computer Households" = "Households_with_Computer",
         "Internet Households" = "Households_with_Internet")

# Grouping the dataset by state names
india_transport_by_states <- india_census_df %>%
  group_by(State.name) %>%
  summarise(
    Total_Households = sum(Households),
    "Bicycle Households" = sum(Households_with_Bicycle),
    "Car, Jeep, Van Households" = sum(Households_with_Car_Jeep_Van),
    "Scooter, Motorcycle, Moped Households" =
      sum(Households_with_Scooter_Motorcycle_Moped)
  )

# Grouping the dataset by regions(North, South, East, West, Northeast, Central)
india_transport_by_regions <- india_transport_by_states %>%
  mutate("Region" = c(
    "West", "South", "Northeast", "Northeast", "East", "North", "Central",
    "West", "West", "West", "West", "North", "North", "North",
    "East", "South", "South", "South", "Central", "West", "Northeast",
    "Northeast", "Northeast", "Northeast", "North", "East", "South",
    "North", "North", "Northeast", "South", "Northeast", "North",
    "North", "East"
  ))



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
}
