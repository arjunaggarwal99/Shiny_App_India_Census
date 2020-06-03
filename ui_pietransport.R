library(shiny)
library(plotly)
library(dplyr)
india_census <- read.csv("data/india-districts-census-2011.csv")

# Fourth page for the shiny app
ui <- fluidPage(
  titlePanel(h2(paste0("Distribution of Mode of Transportation ",
  "across different regions of India"), align = "center")),
  # Using the sidebar layout for the page
  sidebarLayout(
    sidebarPanel(
      h3("Filteration Panel"),
      # Creating a widget for selecting the India country region
      selectInput(
        inputId = "selectregion",
        label = h5("Select x-axis of state:"),
        choices = list("West", "South", "Northeast",
                       "Central", "North", "East"),
        selected = "Northeast"
      ),
      # Creating a widget to select the type of vehicle
      radioButtons(
        inputId = "transporttype",
        label = h5("Select division category on the basis of transport type:"),
        choices = list("Bicycle Households",
          "Car, Jeep, Van Households",
          "Scooter, Motorcycle, Moped Households"),
        selected = "Car, Jeep, Van Households"
      )
    ),
    # displaying the plot in the main panel
    mainPanel(
      # Displaying the title name that was input in the side bar panel.
      plotlyOutput("regionstransportchart")
    )
  )
)
