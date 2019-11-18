library(plotly)
library(tidytext)
library(dplyr)
library(ggplot2)

#dataset is read from a csv file
full_dataset <- read.csv("data/world-happiness/2017.csv", stringsAsFactors = FALSE)

#Filters down the dataset to contain relevant information. Has continuous and noncontinuous variables
scatter_data <- function(full_dataset){
  data <- full_dataset %>%
    transmute(Country, Generosity = round(Generosity * 10, 2), Happiness.Rank, 
              Happiness.Score)
  return(data)
}

#Function that takes in the relevant data from dataset and user input.
#Allows users to choose which variable can be on the x and y axis.

scatter_plot <- function(scatter_data, input){
  if(input$ScatterX == 'Generosity'){
    x <- "Generosity"
  } else if(input$ScatterX == 'Happiness.Score'){
    x <- "Happiness Score"
  } else if(input$ScatterX == 'Happiness.Rank'){
    x <- "Happiness Rank"
  } else if(input$ScatterX == 'Country'){
    x <- "Country"
  }
  
  if(input$ScatterY == 'Generosity'){
    y <- "Generosity"
  } else if(input$ScatterY == 'Happiness.Score'){
    y <- "Happiness Score"
  } else if(input$ScatterY == 'Happiness.Rank'){
    y <- "Happiness Rank"
  } else if(input$ScatterY == 'Country'){
    y <- "Country"
  }
  
#Makes the scatterplot with a title and an x and y variable of the user's input.
gg <- ggplot(scatter_plot, aes(x = eval(parse(text = input$ScatterX, Country)), 
      y = eval(parse(text = input$ScatterY, Country)), hoverinfo = 'text')) +
  geom_point(position = 'jitter', na.rm = TRUE) +
  labs(title = paste0(x, " vs. ", y, " of Happiest Countries in The World"), x = x, y = y) +
  theme(legend.position = 'none')
  
#This will convert it to a plotly graph.
plot <- ggplotly(gg)
  return(plot)
  
}
plot
