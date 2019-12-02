library(leaflet)
library(dplyr)
library(geojsonio)

happiness_2017 <- read.csv(file = "./data/world-happiness/2017.csv")
world_map_data <- geojson_read("./data/world-border/countries.geo.json", what = "sp")

happiness_lite <- happiness_2017 %>% 
  dplyr::select(Country, Economy..GDP.per.Capita., Happiness.Score,
                Health..Life.Expectancy., Freedom, Generosity) %>%
  mutate(total = 5*(Economy..GDP.per.Capita. + Health..Life.Expectancy. +
                          Freedom  + Generosity + Happiness.Score))

name_to_index <- function(given_country){
  country_list <- world_map_data$name
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
  get_country_name <- reactive({
    country_name <- happiness_lite %>%
      mutate(diff = total - input$gdp*Economy..GDP.per.Capita. -
               input$life_exp*Health..Life.Expectancy. -
               input$freedom*Freedom -
               input$generosity*Generosity -
               input$happy*Happiness.Score) %>%
      dplyr::select(Country,diff) %>%
      arrange(-diff) %>% top_n(1,diff) %>% pull(Country) %>% as.character()
  })
  
  get_country_table <- reactive({
    country_name <- happiness_lite %>%
      mutate(diff = total - input$gdp*Economy..GDP.per.Capita. -
               input$life_exp*Health..Life.Expectancy. -
               input$freedom*Freedom -
               input$generosity*Generosity -
               input$happy*Happiness.Score) %>%
      dplyr::select(Country,diff) %>%
      arrange(-diff) %>% top_n(5,diff)
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
}
  
  
  
  