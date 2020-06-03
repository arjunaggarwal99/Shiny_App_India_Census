library(shiny)
library(plotly)
library(dplyr)
india_census <- read.csv("data/india-districts-census-2011.csv")

# Grouping the dataset by state names
india_transport_by_states <- india_census %>%
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

# Creating the function that has two parameters:
# input and output
server <- function(input, output) {
  # Rendering the pie chart plotly of the transport
  # distribution through different regions
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
