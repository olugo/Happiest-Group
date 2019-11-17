library(dplyr)
aggregate_table <- function(dataset){
  dataset %>% 
    mutate(
      GDP_per_capita = round(dataset$Economy..GDP.per.Capita.,2)
      ) %>% 
    select(Happiness.Score,GDP_per_capita) %>%
    group_by(GDP_per_capita) %>%
    summarise(Average_happiness_score = mean(Happiness.Score)) %>%
    arrange(GDP_per_capita)
}
