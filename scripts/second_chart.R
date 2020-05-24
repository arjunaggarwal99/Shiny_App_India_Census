# This file contains the code to make a pie chart
# for the percentage of people following different religions
# in India

# Takes the data set from the read command in our summary table file
source("summary_table.R")

religion_table <- census_df %>%
  summarise("Hindu" = sum(Hindus) / sum(Population),
            "Muslim" = sum(Muslims) / sum(Population),
            "Christian" = sum(Christians) / sum(Population),
            "Sikh" = sum(Sikhs) / sum(Population),
            "Buddhist" = sum(Buddhists) / sum(Population),
            "Jain" = sum(Jains) / sum(Population),
            "Other" = sum(Others_Religions) / sum(Population)
            )

religion_df <- t(religion_table)

row_names <- rownames(religion_df)
row_values <- religion_df[row_names, ]

df <- data.frame(
  group = row_names,
  value = row_values
)

pie <- plot_ly(df, labels = ~group, values = ~value, type = 'pie') %>%
  layout(title = "India's religious percentages",
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
