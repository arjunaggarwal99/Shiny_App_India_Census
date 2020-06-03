#loading the necessary libraries and packages
library("shiny")
library(plotly)
library(dplyr)
library(ggplot2)
source("ui_secondchart.R")
source("server_secondchart.R")
# source("char1_ui.R")
# source("chart1_server.R")

# Calling the other files
shinyApp(ui = ui, server = server)

