library(dplyr)
library(shiny)
library(plotly)
library(shiny)
library(leaflet)
library(geojsonio)

my_ui <- fluidPage(
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
    ),
    tabPanel(
      "Country Map",
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            inputId = "gdp",
            label = "GDP per capita",
            min = 0,
            max = 1.87,
            value = 0.5,
            round = -2
          ),
          sliderInput(
            inputId = "life_exp",
            label = "Life expectancy",
            min = 0,
            max = 0.95,
            value = 0.5,
            round = -2
          ),
          sliderInput(
            inputId = "freedom",
            label = "Freedom score",
            min = 0,
            max = 0.66,
            value = 0.5,
            round = -2
          ),
          sliderInput(
            inputId = "generosity",
            label = "Generosity",
            min = 0,
            max = 0.84,
            value = 0.1,
            round = -2
          ),
          sliderInput(
            inputId = "happy",
            label = "Happiness",
            min = 2.7,
            max = 7.54,
            value = 5,
            round = -2
          ),
        ),
        mainPanel(
          tableOutput(
            outputId = "name"
          ),
          leafletOutput("world_map")
        )
      )
    )
  )
)