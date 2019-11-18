library(ggplot2)
library(dplyr)

# A function takes in the year and health data from dataset.
# Makes the Line chart with a title and an x and y variable.
# Convert it to a graph.
get_happiness_vs_health <- function(dataset){
  dataset <- ggplot(data = year_2017, aes(x = Health..Life.Expectancy., y = Happiness.Score, group = 1)) +
    geom_line ()+
    geom_point ()+
    ggtitle("2017 Happiness Score V.S. Health Life.Expectancy")
}
