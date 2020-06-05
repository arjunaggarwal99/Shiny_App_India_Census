#loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
source("app_ui.R")
source("app_server.R")

# Calling the other files
shinyApp(ui = ui, server = server)
