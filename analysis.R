# This R file will be used for "Data manipulation":"Data wrangling"
# We have made a seperate file for data wrangling to keep our server code
# more clean and easy to read.


# Extracting data source
india_census_df <- read.csv("data/india-districts-census-2011.csv",
  stringsAsFactors = FALSE
)

######################

# Data manipulation for chart 1:
# Modfiying the dataset for the pupose of the
# technology advanced districts bar chart.

# Renaming some columns of the dataset
india_census_df_tech <- india_census_df %>%
  rename(
    "Computer Households" = "Households_with_Computer",
    "Internet Households" = "Households_with_Internet"
  )

######################

# Data manipulation for chart 2:
# Modfiying the dataset for the pupose of the
# transports pie chart.

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

######################

# Data manipulation for chart 2:
# Modfiying the dataset for the pupose of the
# transports pie chart.

# Adding a new column with the sum of the rural and
# urban households number
india_urban_rural_house_df <- india_census_df %>%
  mutate(Total_Households = Rural_Households + Urban_Households)

# Sum of total, urban and rural households by states and then
# adding a new column of the regional presence of every state
# in India.
india_urban_rural_house_df <- india_urban_rural_house_df %>%
  group_by(State.name) %>%
  summarise(
    "Total Households" = sum(Total_Households),
    "Rural Households" = sum(Rural_Households),
    "Urban Households" = sum(Urban_Households)
  ) %>%
  mutate("Region" = c(
    "West", "South", "Northeast", "Northeast", "East", "North", "Central",
    "West", "West", "West", "West", "North", "North", "North",
    "East", "South", "South", "South", "Central", "West", "Northeast",
    "Northeast", "Northeast", "Northeast", "North", "East", "South",
    "North", "North", "Northeast", "South", "Northeast", "North",
    "North", "East"
  ))
