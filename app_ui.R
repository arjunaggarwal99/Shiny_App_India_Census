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

# Creating the tab for the chart based on technological advacements
# in different districts of selected Indian states.
page_one <- tabPanel(
  titlePanel(h2(paste0(
    "Illustration of digital technology advancement ",
    "in different districts of states of India"
  ),
  align = "center"
  )),
  sidebarLayout(
    # Creating side bar with widgets
    sidebarPanel(
      h3("Filteration panel"),
      # Creating a radio button widget to select the state
      selectInput(
        inputId = "selectstate",
        label = h5("Select x-axis of state to show districts of that state:"),
        choices = list(
          "JAMMU AND KASHMIR", "HIMACHAL PRADESH", "PUNJAB", "CHANDIGARH",
          "UTTARAKHAND", "HARYANA", "NCT OF DELHI", "RAJASTHAN",
          "UTTAR PRADESH", "BIHAR", "SIKKIM", "ARUNACHAL PRADESH",
          "NAGALAND", "MANIPUR", "MIZORAM", "TRIPURA", "MEGHALAYA",
          "ASSAM", "WEST BENGAL", "JHARKHAND", "ORISSA",
          "CHHATTISGARH", "MADHYA PRADESH", "GUJARAT",
          "DAMAN AND DIU", "DADRA AND NAGAR HAVELI", "MAHARASHTRA",
          "ANDHRA PRADESH", "KARNATAKA", "GOA", "LAKSHADWEEP", "KERALA",
          "TAMIL NADU", "PONDICHERRY", "ANDAMAN AND NICOBAR ISLANDS"
        ),
        selected = "NCT OF DELHI"
      ),
      # Creating a checkbox widget to select the type of technology
      checkboxGroupInput(
        inputId = "technologyoption",
        label = h5("Select digital technology type:"),
        choices = list("Computer Households", "Internet Households"),
        selected = "Computer Households"
      )
    ),
    # Creating main panel for data visualization and description on the page
    mainPanel(
      # Displaying the output for the chart.
      plotlyOutput(
        outputId = "techdistrictschart"
      ),
      h4("Description about the bar chart above:"),
      p(
        "This column chart shows the different counties of ",
        "the selected Midwest state on the basis of the,", strong("state "),
        "selected through the buttons widget. The user can also ",
        "select the ", strong("population group"),
        "of children/adult/elder to ",
        "see the trends of different population demographics of ",
        "different states and population groups in different ",
        "visualizations."
      ),
    )
  )
)

# Fourth page for the shiny app
page_two <- tabPanel(
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


# Combining the page 1 and page 2 in a ui variable
# to creat a user interface page
ui <- navbarPage(
  "Households data analysis of India",
  page_one,
  page_two
)
