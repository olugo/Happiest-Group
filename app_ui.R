library(shiny)
library(leaflet)
library(geojsonio)
prediction_page <- tabPanel(
  "page1",
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

my_ui <- navbarPage(
  "nav",
  prediction_page
  )