# This file contains the code to make a pie chart
# for the percentage of people following different religions
# in India

# Takes the data set from the read command in our summary table file
source("scripts/summary_table.R")



# Creating a table based on different religions in India
# and the proportion of people believing in those religions.
religion_table <- india_census_df %>%
  summarise("Hindu" = sum(Hindus) / sum(Population),
            "Muslim" = sum(Muslims) / sum(Population),
            "Christian" = sum(Christians) / sum(Population),
            "Sikh" = sum(Sikhs) / sum(Population),
            "Buddhist" = sum(Buddhists) / sum(Population),
            "Jain" = sum(Jains) / sum(Population),
            "Other" = sum(Others_Religions) / sum(Population)
            )

# Manipulating the table to make it suitable to create
# the pie chart.
religion_transpose_df <- t(religion_table)
row_names <- rownames(religion_transpose_df)
row_values <- religion_transpose_df[row_names, ]
india_religion_df <- data.frame(
  group = row_names,
  value = row_values
)

# Creates a functio that takes in the required data
# frame as a parameter and returns the pie chart.
pie_chart <- function(religion_transpose_df) {
# Code to create the pie chart.
pie_chart_religion_dis <- plot_ly(india_religion_df,
                                  labels = ~group,
                                  values = ~value,
                                  type = "pie") %>%
  layout(title = "India's religious percentages",
         xaxis = list(showgrid = FALSE,
                      zeroline = FALSE,
                      showticklabels = FALSE),
         yaxis = list(showgrid = FALSE,
                      zeroline = FALSE,
                      showticklabels = FALSE))
return(pie_chart_religion_dis)
}
