library(dplyr)
library(shiny)
library(plotly)
library(shinythemes)

ui <- fluidPage(
  theme = "style.css",
  navbarPage(
    "Happiest Countries Data",
    tabPanel(
      "Happiness Score vs. Generosity",
      sidebarLayout(
        sidebarPanel(
          radioButtons("rank",
                       "Choose Happiness Score or Generosity",
                       choices = c("Happiness Score", "Generosity")
                       
          ),
          
          selectInput("color",
                      "Choose a color:",
                      choices = c(
                        "Red", "Orange", "Yellow", 
                        "Green", "Blue", "Purple", 
                        "Pink", "Black"
                      )
          )
        ),
        
        mainPanel(plotlyOutput("countries"),
                  helpText("This page displays a bar chart that compares 10 random
                           countries with their happiness scores and their generosity 
                           scores. The purpose of choosing these two variables is to 
                           see if there were any correlation between them. From
                           looking at the bar charts and comparing countries with 
                           the two scores, it looks like there isn't much of a 
                           correlation between a country's happiness score and 
                           its generosity score.")
        )
      )
    )
  )
)