library(shiny)
library(plotly)
library(dplyr)
india_census <- read.csv("data/india-districts-census-2011.csv")

# Creating the tab for the chart based on rural and urban
# households
second_page <- tabPanel(
  "Rural/Urban",
  titlePanel("Rural/Urban Households"),
  # Using the sidebar layout for the first page
  sidebarLayout(
    sidebarPanel(
      h3("Census analysis using a Bar Chart"),
      textInput(
        inputId = "title_name_bar",
        label = h5("Enter the title you want for this graph"),
        placeholder = "Enter title here",
        value = paste0("Number of Rural/Urban Households across States of India")
      ),
      
      radioButtons(
        inputId = "categorytype",
        label = h5("Select division category on the basis of:"),
        choices = list("State" = "State.name",
                       "Region"),
        selected = "State.name"
      ),
      
      # takes in the name of the state
      radioButtons(
        inputId = "type_of_household",
        label = h5("Select the type of Household"),
        choices = list("Rural Households",
                       "Urban Households"),
        selected = "Rural Households"
      )
    ),
    # displaying the plot in the main panel
    mainPanel(
      # Displaying the title name that was input in the side bar panel.
      plotlyOutput("chart_1"),
      h6("This Bar chart plots the number of Rural/Urban 
      Households on the basis of the States in India.
      Also, you can add your own customized title for the graph."),
    )
  )
)

# Putting together the UI
ui <- navbarPage(
  "Census",
  second_page
)