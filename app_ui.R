library(dplyr)
library(shiny)
library(plotly)
library(shiny)
library(leaflet)
library(geojsonio)

image <- base64enc::dataURI(file="images.jpeg")
my_ui <- fluidPage(
  theme = "style.css",
  navbarPage(
    "Happiest Countries Data",
    tabPanel("Introduction",
             mainPanel ("Through investigating the data, we want to know that how different factors would influence people's happiness score.
                        The data we are using is called World Happiness Index. The World Happiness Index measures happiness based on respondent's ratings of their own lives.
                        The report offers a way to measure people's quality of life and the effectiveness of the governments beyond gross domestic product and other economic indicators. 
                        By focusing on national well being, a country can take a more wholistic approach to improving their populace's lives.
                        The United Nations conducts the survey based on a ladder system by asking respondents to rate the best possible life at 10 and the worst possible life being a 0. 
                        Respondents from 155 countries are then asked to rate their own current lives on that 0 to 10 scale."
             ),
             img(src = image)),
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
            max = 10,
            value = 5,
            round = -2,
            step = 0.1
          ),
          sliderInput(
            inputId = "life_exp",
            label = "Life expectancy",
            min = 0,
            max = 10,
            value = 5,
            round = -2,
            step = 0.1
          ),
          sliderInput(
            inputId = "freedom",
            label = "Freedom score",
            min = 0,
            max = 10,
            value = 5,
            round = -2,
            step = 0.1
          ),
          sliderInput(
            inputId = "generosity",
            label = "Generosity",
            min = 0,
            max = 10,
            value = 5,
            round = -2,
            step = 0.1
          ),
          sliderInput(
            inputId = "happy",
            label = "Happiness",
            min = 0,
            max = 10,
            value = 5,
            round = -2,
            step = 0.1
          )
        ),
        mainPanel(
          tableOutput(
            outputId = "name"
          ),
          leafletOutput("world_map")
          ,"This map does not highlight Singapore,
          Bahrain, Mauritius, and Hong Kong SAR China"
        )
      )
    ),
    tabPanel("Summary",
             mainPanel ("We selected some factors that influence the World Happiness 
             Index to analysis, and drew a country map to more directly present the factors 
             and the happiness score in the corresponding countries.
                        
                        We first chose the generosity and happiness score and tried to find 
             out the correlation between them. In the chart we present, we only chose 10 countries, 
             so perhaps there is no obvious correlation that when a country has a high generosity score, 
             it will has a high happiness score. But we can roughly see that happiness socres are higher 
             when generosity score is higher from the trend presented (with a few exceptions).
                        
                        xxxx Then we chose the freedom and happiness score.xxxxx
                        Finally we did a country map to collet and show factor GDP, life expecticy, freedom
             generosity and happiness scores.
                        "
                        
             )
    )
  )
)

