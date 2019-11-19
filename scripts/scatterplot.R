library(plotly)
library(tidytext)
library(dplyr)
library(ggplot2)

#dataset is read from a csv file
full_dataset <- read.csv("data/world-happiness/2017.csv", stringsAsFactors = FALSE)

#Filters down the dataset to contain relevant information. Has continuous and noncontinuous variables
filter_scatter_data <- function(full_dataset){
  data <- full_dataset %>%
    transmute(Country, Generosity = round(Generosity * 10, 2), Happiness.Rank, 
              Happiness.Score)
  return(data)
}

scatter_data <- filter_scatter_data(full_dataset)

#Function that takes in the relevant data from dataset and user input.
#Allows users to choose which variable can be on the x and y axis.



input_scatter_plot <- function(scatter_data, input_x, input_y){
  if(input_x == 'Generosity'){
    x <- "Generosity"
  } else if(input_x == 'Happiness.Score'){
    x <- "Happiness Score"
  } else if(input_x == 'Happiness.Rank'){
    x <- "Happiness Rank"
  } else if(input_x == 'Country'){
    x <- "Country"
  }
  
  
  if(input_y == 'Generosity'){
    y <- "Generosity"
  } else if(input_y == 'Happiness.Score'){
    y <- "Happiness Score"
  } else if(input_y == 'Happiness.Rank'){
    y <- "Happiness Rank"
  } else if(input_y == 'Country'){
    y <- "Country"
  }
  
  #Makes the scatterplot with a title and an x and y variable of the user's input.
  gg <- ggplot(scatter_data, aes(x = eval(parse(text = input_x)), 
                                 y = eval(parse(text = input_y)), hoverinfo = 'text')) +
    geom_point(position = 'jitter', na.rm = TRUE) +
    labs(title = paste0(x, 
                        " vs. ", 
                        y, " of Happiest Countries in The World"), 
         x = x, 
         y = y) +
    theme(legend.position = 'none')
  
  #This will convert it to a plotly graph.
  plot <- ggplotly(gg)
  
  return(plot)
}

generous_vs_happiness_plot <- input_scatter_plot(scatter_data, "Generosity", "Happiness.Rank")
