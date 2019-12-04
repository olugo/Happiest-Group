library(shiny)
library(leaflet)
library(dplyr)
library(maptools)
library(geojsonio)


source("app_ui.R")
source("app_server.R")
shinyApp(ui = my_ui, server = my_server)

