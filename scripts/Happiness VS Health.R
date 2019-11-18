year_2017 <- read.csv(file = "data/world-happiness/2017.csv", stringsAsFactors = FALSE)

library(ggplot2)
library(dplyr)

graph_2017 <- ggplot(data = year_2017, aes(x = Health..Life.Expectancy., y = Happiness.Score, group = 1)) +
  geom_line ()+
  geom_point ()+
  ggtitle("2017 Happiness Score V.S. Health Life.Expectancy")
graph_2017
