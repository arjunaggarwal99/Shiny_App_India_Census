# loading the necessary libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(styler)
library(lintr)
library(ggplot2)
library(shinythemes)

# india_census_df <- read.csv("data/india-districts-census-2011.csv",
#   stringsAsFactors = FALSE
# )

# Creating the overview: introduction page
overview_tab <- tabPanel(
  "Overview",
  titlePanel(h2(paste0(
    "Introduction to the project: ",
    "India Censuse 2011 Household ",
    "resource analysis"
  ))),
  sidebarPanel(
    img(
      src = "images/indiamap.jpg", alt =
        "Urban and Rural households in India", height = 300, width = 320
    ),
    h4("About the dataset"),
    tags$p(id = "message_1",
      paste0(
      "Every 10 years, the government of India conducts a ",
      "a National Census project wherein they collect information ",
      "about the population of the country based on several factors. ",
      "With this, the data studied in this project is the Census 2011 ",
      "which illustrates the information about population, households ",
      "of different Indian states and districts."
    )),
    tags$p(id = "message_2",
      "Considering that India has the second largest population ",
      "in the world, its population is distributed in a ",
      "manner which makes it interesting to study the data ",
      "about it population."
    ),
    tags$p(id = "message_3",
      paste0(
      "Along with this, there is a vibrant ",
      "distribution of the households in the country based ",
      "on various geographical, resource availibility and ",
      "socio-economic factors that affect the patterns ",
      "of distribution and the type of households in ",
      "in the different regions of the country. This makes ",
      "us more interested in doing the households study of ",
      "this country where the living patterns of people ",
      "is affected by a combination of ",
      "different factors which we were sure will be answered ",
      "in the National Census reports conducted by the ",
      "Government of India."
    ))
  ),
  mainPanel(
    img(
      src = "images/housesurbanrural.png",
      alt = "Urban and Rural in India", height = 400, width = 800
    ),
    h3("The purpose/importance of the project:"),
    p(
      "1. This project has been designed to serve the needs of ",
      "people who are interested in gathering information about ",
      "the various households throughout the states and regions ",
      "of India. ",
      "This information report will help them to gather ",
      "information on features of Indian households that ",
      "will determine how there have been distribution of ",
      "resources in differeent areas based on the current ",
      "level of resources and the type of rural and urban ",
      "households."
    ),
    p(
      "2. The importance of this data will be the potential ",
      "who are planning to invest in India will be able to ",
      "a more informed choice with respect to where they ",
      "invest based on the current numbers and facts."
    ),
    p(
      "3. This information will also help the government ",
      "of India when they decide on distrubuting national ",
      "budgets for region, state and district wise ",
      "distrubution of resources."
    ),
    p(
      "4. On the whole, this project is important for the ",
      "people of India as this project will promote the ",
      "idea of equal distrubution of resources and make ",
      "sure that households have similar resources ",
      "so that there is less discrimination of people ",
      "based on their living conditions and lack of ",
      "resources."
    ),
    h3("Data Source"),
    p("The source of the data of the project is:"),
    "1. ",
    a("Scraper Source",
      href =
        "https://github.com/nishusharma1608/India-Census-2011-Analysis"
    ),
    p(),
    "2. ",
    a("Data Source",
      href =
        "http://censusindia.gov.in/2011-Common/CensusData2011.html"
    ),
    h3("Target Users"),
    p(
      "Our target user is the government sector and the people ",
      "who are planning to invest in different areas of the country."
    ),
    h3("Questions of interest:"),
    p(paste0(
      "1. How are the current resources distributed in different ",
      "regions, states and districts of India? Is there any specific pattern?"
    )),
    p(
      "2. Which are the regions, districts and states ",
      "which have a lack of resources ",
      "in their households and have a scope of development ",
      "and more investment by foreign and government sectors?"
    ),
    p(paste0(
      "3. How is the urban and rural population divided in the ",
      "country based on households in different regions, states ",
      "and districts? ",
      "What does this show in terms of resource distribution ",
      "by the government within these regions?"
    ))
  )
)

# Creating the tab for the chart based on technological advacements
# in different districts of selected Indian states.
tech_tab <- tabPanel(
  "Technology advanced districts",
  titlePanel(h2(paste0(
    "llustration of digital technology advancement ",
    "in different districts of states of India"
  ))),
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
      ),
      img(
        src = "images/computer.jpeg",
        alt = "Computers and Internet", height = 200, width = 300
      )
    ),
    # Creating main panel for data visualization and description on the page
    mainPanel(
      # Displaying the output for the chart.
      h4("Description about the bar chart above:"),
      p(
        "This column chart shows the different districts of ",
        "the selected Indian state on the basis of the,", strong("state "),
        "selected through the select widget. The user can also ",
        "select the ", strong("digital technology type"),
        "of households with ", strong("computer/internet "), "to ",
        "see the trends of different households' technogical advancements ",
        "in different states and districts in different ",
        "visualizations."
      ),
      plotlyOutput(
        outputId = "techdistrictschart"
      ),
      h4("Analysis:"),
      p(paste0(
        "With technology being the hourly need, households ",
        "in India manage to grab a personal computer. This ",
        "depends on various factors: location, income, ",
        "availability of electricity and many more. ",
        "According to the 2011 census, the following ",
        "analysis can be inferenced:"
      )),
      p(paste0(
        "•	Going further south towards Tamil Nadu, ",
        "Karnataka there has been a profound impact ",
        "on the number of computers every household has. ",
        "The reason behind this surge is because of the ",
        "sharp increase in the evolution of education sector ",
        "in cities like Chennai, Hyderabad, or Bangalore. ",
        "Another major factor is the upward surge in the ",
        "number of multinationals and tertiary sector services ",
        "in terms of IT advancement that makes Hyderabad ",
        "acquire the title of", strong("cyber city"), "Hence ",
        "these areas are urban because the right resources ",
        "given to them which can be seen with more computers ",
        "and households in these areas."
      )),
      p(paste0(
        "• Scrolling towards west, in states like Maharashtra ",
        "there has been scattering only in few cities like Thane, ",
        "Pune, Mumbai suburban. These is one of the densely populated ",
        "cities in India and also holds trade centers. As the government ",
        "provided more resources to the areas, there is more skilled employment ",
        "which in turn families draw interests in buying ",
        "computers and indeed, more access to internet. However, other ",
        "districts in the state of Maharashtra are not the same as they ",
        "lack resources of investment in employment and hence people ",
        "cannot afford ",
        "to buy technology like internet and computer which can be seen ",
        "in the chart above."
      ))
    )
  )
)

# This tab will consist of a pie chart showing the
# transport distribution in Indian households
# based on region and states.
transport_tab <- tabPanel(
  "Transportation Indian regions",
  # Using the sidebar layout for the page
  titlePanel(h2(paste0(
    "Distribution of Mode of Transportation ",
    "across different regions of India"
  ))),
  sidebarLayout(
    sidebarPanel(
      h3("Filteration Panel"),
      # Creating a widget for selecting the India country region
      selectInput(
        inputId = "selectregion",
        label = h5("Select x-axis of state:"),
        choices = list(
          "West", "South", "Northeast",
          "Central", "North", "East"
        ),
        selected = "Northeast"
      ),
      # Creating a widget to select the type of vehicle
      radioButtons(
        inputId = "transporttype",
        label = h5(paste0(
          "Select division category on the ",
          "basis of transport type:"
        )),
        choices = list(
          "Bicycle Households",
          "Car, Jeep, Van Households",
          "Scooter, Motorcycle, Moped Households"
        ),
        selected = "Car, Jeep, Van Households"
      ),
      img(
        src = "images/vehicles.png",
        alt = "Vehicles road", height = 200, width = 300
      )
    ),
    # displaying the plot in the main panel
    mainPanel(
      # Displaying the title name that was input in the side bar panel.
      h4("Description about the pie chart above:"),
      p(paste0(
        "The pie chart above shows the distribution of types ",
        "different transport vehicles within the households of ",
        "different regional states of India. The pie chart ",
        "can be filtered on the basis of region which shows ",
        "the states in that region. Next, the pie sectors can ",
        "be shown on the basis of type of vehicles in the ",
        "different states within that region."
      )),
      plotlyOutput("regionstransportchart"),
      h4("Analysis:"),
      p(paste0(
        "The road transport in India is considered on the ",
        "busiest in the globe and grabs the second-largest ",
        "position. India is categorized in six main regions: ",
        "North, South, East, West, Northeast, Central. ",
        "According to the 2011 census, the following anaylsis ",
        "can be done from the chart above: "
      )),
      p(paste0(
        "•	Within the Northeast region, the largest number of ",
        "households with type of vehicle are in the state of Assam. ",
        "This shows how the state of Assam is the centric point ",
        "point of investment and development in the Northeast ",
        "region which tells goverment and investors to expand ",
        "transportation facilities in other states like ",
        strong("Sikkim "), "which has least number all households ",
        "with any type of vehicles."
      )),
      p(paste0(
        "•	In the North region, more than 3/4th of the households ",
        "in Uttar Pradesh used bicycle as the mode of the transport. ",
        "This shows how the households in Uttar Pradesh cannot ",
        "afford expensive transportation in their households. ",
        "This calls for a scope of investment in education ",
        "resource and development of more skilled labor ",
        "in the state of Uttar Pradesh within the North region."
      )),
    )
  )
)

rural_urban_tab <- tabPanel(
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
        value = paste0(
          "Number of Rural/Urban Households ",
          "across States of India"
        )
      ),
      selectInput(
        inputId = "categorytype",
        label = h5("Select division category on the basis of:"),
        choices = list(
          "State" = "State.name",
          "Region"
        ),
        selected = "State.name"
      ),
      # takes in the name of the state
      radioButtons(
        inputId = "type_of_household",
        label = h5("Select the type of Household"),
        choices = list(
          "Rural Households",
          "Urban Households"
        ),
        selected = "Rural Households"
      ),
      img(
        src = "images/urbanrural.jpg",
        alt = "Households in India", height = 200, width = 300
      )
    ),
    # displaying the plot in the main panel
    mainPanel(
      h4("Description of the chart"),
      p(paste0("This Bar chart plots talks about the number of Rural/Urban ",
               "Households on the basis of the States and regions in India. ",
               "Also, you can add your own customized title for the graph.")),
      # Displaying the title name that was input in the side bar panel.
      plotlyOutput("urbanruralchart"),
      h4("Analysis"),
      p(paste0("There has been a great dichotomy India when ",
               "it comes to dividing it in terms of Urban and ",
               "Rural. The Urban India has been often seen as the ",
               "modern, fast growing part while the Rural India is ",
               "still deemed as backwards. Agriculture is one of ",
               "the main occupations amongst rural households in ",
               "India and it is the only source of income of ",
               "the rural population of India.")),
      p(paste0("•  If we consider the regional distribution of ",
              "urban and rural households, apart from the South ",
              "and West regions which have a more equal distrubution ",
              "of urban and rural households, the rest of the ",
              "regions have a great disparity in the number of ",
              "urban and rural households. Agriculture plays a ",
              "vital role in rural households exhistence. The ",
              "dark side of these areas is that job employment ",
              "is not secure here which in turn opens up large ",
              "platforms for unemployment. With unemployment, ",
              "people self employ themselves with agriculture ",
              "leading to less earnings and more scope for rural ",
              "households. Hence, the government and investors ",
              "should plan for more equitable regional distribution ",
              "of employment skilled opportunities to promote urabn ",
              "households living throughout all regions of the country. ",
              "The rural households also have less better transport and ",
              "technological resources which continue their rural ",
              "household state."
      )),
      p(paste0("•	 If we consider the state wise distribution, we can ",
               "see that in some states which are the center points of ",
               "of different regions of the country have much more urban ",
               "households than rural households. For example, in the ",
               "states of ", strong("Delhi in North region, Assam in ",
                                    "Northeast region and Bihar in East region "),
               " have a high difference in the urban and rurual households ",
               "number. In states like these, the industry and the evolution ",
               "of IT sector has shown much better growth over years leading ",
               "to better employment opportunities, pay scales and in turn, ",
               "development of more urban areas. This calls in a scope for more ",
               "IT industries to spread across the different states within ",
               "different regions of the country so that people are able to ",
               "urbanise and advance themselves more equally. It can be also ",
               "be seen that these states have a good amount of households ",
               "which can afford modern and expensive transport, internet and ",
               "computer facilities which leads to good education and more ",
               "better income which makes these households urban."))
    )
  )
)

summary_tab <- tabPanel(
  "Summary",
  titlePanel(h2(paste0(
    "Summary of the project: ",
    "India Censuse 2011 Household ",
    "resource analysis"
  ))),
  sidebarLayout(
    sidebarPanel(
      img(
        src = "images/indiacolormap.jpg",
        alt = "Households in India", height = 470, width = 360
      )
    ),
    mainPanel(
      h3("Conclusions from the data:"),
      h4("Takeaway 1"),
      strong(paste0(
        "How are the current resources distributed in different ",
        "states and districts of India? Is there any specific pattern?"
      )),
      p(paste0(
        "It can be seen from charts one and two that most of ",
        "the resources in every state, region are directed towards ",
        "one or two major districts. These major districts are ",
        "generally inclusive of the capital cities of every state.",
        "This shows how the resources distribution is biased and ",
        "and imbalanced within the state and the regions of India. ",
        "Hence, we conclude that their is not equal distribution of ",
        "resources and their is consolidation of resources to some areas."
      )),
      h4("Takeaway 2"),
      strong(paste0(
        "Which are the regions, districts and states which have a lack of ",
        "resources in their households and have a scope of development?",
        "and more investment by foreign and government sectors?"
      )),
      p(paste0("As talked about a little in the previous analysis, other ",
               "than the popular states and districts in the regions, all ",
               "of the other states and districts are in need of more",
               "resources. There is surely a need of more fair distribution. ",
               "of resources. ",
               "It can be seen that most of the rural households also ",
               "don't have amenties like computer and motor based vehicles which ",
               "gives them less opportunity to grow further and urbanise ",
               "themselves which makes them more rural and farther from ",
               "an opportunity to urbanise themselves. ",
               "If the government direct there resources to these areas which ",
               "have a lack of resources then things could be changed. ",
               "Also, if the external investors identiy and tap into these ",
               "potential, rural areas, then rural households could ",
               "urbanise as well when they are given right resources."
               )),
      h4("Takeaway 3"),
      strong(paste0(
        "How is the urban and rural population divided in the ",
        "country based on households in different regions, states and districts? ",
        "What does this show in terms of resource distribution by the government ",
        "within these regions?"
      )),
      p(paste0("Since India is still in a developing country, the rural ",
               "households represent the majority of the total households ",
               "in the country. Whenever ",
               "any new investment is done, its done in areas which are ",
               "already developed or are ahead in development, there ",
               "is no new resources directed towards rurul areas. ",
               "This is causing a high difference in the number of ",
               "rural and urban households amongst regions and states ",
               "and within region and states. The dispartities in number ",
               "of rural and urban households can be seen increasing.")),
    )
  )
)

# Combining all pages in a ui variable
# to creat a user interface page
ui <- fluidPage(  includeCSS("style.css"),
                  navbarPage(
  theme = shinytheme("flatly"),
  "Households data analysis of India",
  overview_tab,
  tech_tab,
  transport_tab,
  rural_urban_tab,
  summary_tab
  )
)
