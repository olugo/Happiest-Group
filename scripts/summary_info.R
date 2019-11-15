library(dplyr)
happiness_2017 <- read.csv(file = "../data/world-happiness/2017.csv", stringsAsFactors = FALSE)
get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  ret$num_col <- ncol(dataset)
  ret$num_row <- nrow(dataset)
  
  ret$happiest_country <- dataset %>% 
    arrange(Happiness.Rank) %>% 
    select(Country,Happiness.Rank) %>% 
    top_n(1,-Happiness.Rank) %>% pull(Country)
  
  
  ret$unhappiest_country <- dataset %>% 
    arrange(-Happiness.Rank) %>% 
    select(Country,Happiness.Rank) %>% 
    top_n(1,Happiness.Rank) %>% pull(Country)
  
  return (ret)
} 

c1 <- happiness_2017 %>% get_summary_info()
