# Happiness score/rank vs Freedom | Bar Chart - Orlando
library(dplyr)
library(ggplot2)
library(plotly)


get_happiness_analysis <- function(dataset){
  top_ten <- dataset %>%
    filter(rank(desc(Happiness.Score))<=10)
  
  happy_vs_free <- (subset(top_ten[,c("Country","Happiness.Score","Freedom")])) 
  names(happy_vs_free) <- c("Country","Happiness.Score", "Freedom")
  head(happy_vs_free)
  
  happy_vs_free$Freedom <- happy_vs_free$Freedom*10
  
  happy_free_plot <- plot_ly(
    data = happy_vs_free,
    x = ~Country,
    y = ~Freedom,
    type = "bar") %>% 
    layout(
      title = "Top 10 Happiest Countries: Freedom Scores",
      xaxis = list(title = "Country"),
      yaxis = list(title = "Freedom Score")
    )
  
  return(happy_free_plot)
}
