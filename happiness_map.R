# Calling in the various libraries I'll be using -
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(tidyr)
library(knitr)

df17 <- read.csv("data/world-happiness/2017.csv")
#  A world map color-coded by each country’s overall happiness score in 2017

# Source https://stackoverflow.com/questions/45843301/doing-map-using-shiny-and-ggplot2


worldmap <- map_data("world")
names(worldmap)[names(worldmap)=="region"] <- "Country"
worldmap$Country[worldmap$Country == "USA"] <- "United States"
happy_world <- df17 %>%
  full_join(worldmap, by = "Country")

map_theme <- theme(
  axis.title.x = element_blank(),
  axis.text.x  = element_blank(),
  axis.ticks.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.y  = element_blank(),
  axis.ticks.y = element_blank(),
  panel.background = element_rect(fill = "white"))

freedom_map <- ggplot(data = happy_world, mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = `Freedom`))  +
  scale_fill_continuous(low="light blue", high="dark blue", na.value="snow2") +
  coord_quickmap() +
  labs(title = "Happiness Around the World - 2017") +
  map_theme

