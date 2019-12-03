library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(leaflet)
library(dplyr)
library(geojsonio)
library(countrycode)
happiness_2017 <- read.csv(file = "./data/world-happiness/2017.csv", stringsAsFactors = FALSE)
world_map_data <- geojson_read("./data/world-border/countries.geo.json", what = "sp")

happiness_lite <- happiness_2017 %>% 
  dplyr::select(Country, Economy..GDP.per.Capita., Happiness.Score,
                Health..Life.Expectancy., Freedom, Generosity) %>%
  mutate(total = -8*(Economy..GDP.per.Capita. + Health..Life.Expectancy. +
                          Freedom  + Generosity + Happiness.Score)) %>%
  mutate(code = countrycode(happiness_2017$Country,"country.name","iso3c"))

name_to_index <- function(given_country){
  country_list <- world_map_data$id
  index <- match(given_country,country_list)
  if (is.na(index))
  {
    return(sample((1:length(country_list)),1))
  }
  else{
    return(index)    
  }
}

my_server <- function(input,output){
  output$countries <- renderPlotly({
    gener_vs_score <- happiness_2017 %>%
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
  
  get_country_name <- reactive({
    country_name <- happiness_lite %>%
      mutate(diff = total + input$gdp*Economy..GDP.per.Capita. +
               input$life_exp*Health..Life.Expectancy. +
               input$freedom*Freedom +
               input$generosity*Generosity +
               input$happy*Happiness.Score) %>%
      dplyr::select(code,diff) %>%
      arrange(-diff) %>% top_n(1,diff) %>% pull(code) %>% as.character()
  })
  
  get_country_table <- reactive({
    country_name <- happiness_lite %>%
      mutate(diff = total + input$gdp*Economy..GDP.per.Capita. +
               input$life_exp*Health..Life.Expectancy. +
               input$freedom*Freedom +
               input$generosity*Generosity +
               input$happy*Happiness.Score) %>%
      dplyr::select(Country,diff) %>%
      arrange(-diff) %>% top_n(5,diff) %>% select(Country)
  })
  
  
  index <- reactive({
    name_to_index(get_country_name())
  })
  
  get_map <- reactive({
    map <- leaflet(world_map_data@polygons[[index()]]) %>%
    addTiles() %>% addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 0.3)
  })    

  output$world_map <- renderLeaflet({
      get_map()
    })
  
  output$name <- renderTable({
    get_country_table()
  })
#  A world map color-coded by each country’s overall happiness score in 2017
  
  worldmap <- map_data("world")
  names(worldmap)[names(worldmap)=="region"] <- "Country"
  worldmap$Country[worldmap$Country == "USA"] <- "United States"
  happy_world <- happiness_2017 %>%
    full_join(worldmap, by = "Country")
  
  map_theme <- theme(
    axis.title.x = element_blank(),
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank(),
    panel.background = element_rect(fill = "white"))
  
  happy_score_map <- ggplot(data = happy_world, mapping = aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = `Happiness.Score`))  +
    scale_fill_continuous(low="light blue", high="dark blue", na.value="snow2") +
    coord_quickmap() +
    labs(title = "Happiness Around the World - 2017") +
    map_theme
  
  freedom_score_map <- ggplot(data = happy_world, mapping = aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = `Freedom`))  +
    scale_fill_continuous(low="red", high="blue", na.value="snow2") +
    coord_quickmap() +
    labs(title = "Freedom Around the World - 2017") +
    map_theme
  

  output$happy_map <- renderPlot({
    if (input$world_map1 == "Happiness Score"){
      return(happy_score_map)
    } else {
      return(freedom_score_map)
    }
  })

}
  
