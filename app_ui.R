library(shiny)


page_one <- tabPanel(titlePanel("introduction"),
                     mainPanel ("Through investigating the data, we want to know that how different factors would influence people's happiness score.
The data we are using is called World Happiness Index. The World Happiness Index measures happiness based on respondent's ratings of their own lives.
The report offers a way to measure people's quality of life and the effectiveness of the governments beyond gross domestic product and other economic indicators. 
By focusing on national well being, a country can take a more wholistic approach to improving their populace's lives.
The United Nations conducts the survey based on a ladder system by asking respondents to rate the best possible life at 10 and the worst possible life being a 0. 
Respondents from 155 countries are then asked to rate their own current lives on that 0 to 10 scale."
),
img(src = 'images.jpeg'))


my_ui <- navbarPage(
  "happiest data",
  page_one         # include the first page content    
)


