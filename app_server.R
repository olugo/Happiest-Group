library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

full_data <- read.csv("data/world-happiness/2017.csv", stringsAsFactors = FALSE)


server <- function(input, output){
  output$countries <- renderPlotly({
    gener_vs_score <- full_data %>%
                      filter(rank(desc(Country)) <= 10) 
  
    happy_vs_gen <- (subset(gener_vs_score[,c("Country","Happiness.Score","Generosity")])) 
    names(happy_vs_gen) <- c("Country","Happiness.Score", "Generosity")
    head(happy_vs_gen)
    happy_vs_gen$Generosity <- happy_vs_gen$Generosity * 10
    
    if(input$rank == "Happiness Score"){
      y <- happy_vs_gen$Happiness.Score
      yaxis <- "Happiness Scores"
      range <- c(0, 10)
    } else {
      y <- happy_vs_gen$Generosity
      yaxis <- "Generosity Score"
      range <- c(0, 8)
    }
    
    my_plot <- plot_ly(
      happy_vs_gen,
      x = happy_vs_gen$Country,
      y = y,
      marker = list(color = input$color),
      type = "bar"
    ) %>%
      layout(
        title = paste(input$rank, "of 10 Happiest Countries"),
        xaxis = list(title = "Country"),
        yaxis = list(title = yaxis, range = range)
      )
    return(my_plot)
  })
}