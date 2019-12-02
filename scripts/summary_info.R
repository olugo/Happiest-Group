library(dplyr)
#This function takes in a dataframe and returns a list that contains 
#information about the given dataframe
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
  
  ret$highest_happiness_score <- dataset %>% 
    arrange(Happiness.Score) %>% 
    select(Happiness.Score) %>% 
    top_n(1,Happiness.Score) %>% pull()
  
  ret$lowest_happiness_score <- dataset %>% 
    arrange(-Happiness.Score) %>% 
    select(Happiness.Score) %>% 
    top_n(1,-Happiness.Score) %>% pull()
  
  return (ret)
} 

