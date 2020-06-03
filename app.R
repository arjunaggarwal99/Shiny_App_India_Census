#loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(styler)
library(lintr)
library(ggplot2)
# source("server_householdsbar.R")
# source("ui_householdsbar")
# source("server_pietransport.R")
# source("ui_pitransport.R")
# source("ui_techbar")
# source("server_techbar")

source("app_ui.R")
source("server_ui.R")

# Calling the other files
shinyApp(ui = ui, server = server)
