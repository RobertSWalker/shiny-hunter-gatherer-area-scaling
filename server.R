# This is the server logic of a Shiny web application. You can run the application by clicking 'Run App' above.
library(shiny)
library(dplyr)
library(ggplot2)

df <- read.csv("hgs.csv", header = TRUE)
df <- df %>% dplyr::select("X","latitude","longitude","tlpop","area")
model <- lm( log(area) ~ log(tlpop) + abs(latitude), data = df)

# Define server logic
server = function(input,output,session){
  observeEvent( input$Enter, {
    latitude = input$latitude
    tlpop = input$tlpop
    t = data.frame(latitude,tlpop)
    t$area <- predict(model, t)
    t$area <- round(exp(t$area),1)
   
    output$plot_foo = renderPlot({
      ggplot(df, aes(x=tlpop, y=area)) + geom_point() + geom_smooth() + scale_x_continuous(trans="log10") + scale_y_continuous(trans="log10") +
       geom_point(data = t, col = 'red', size = 5) + ylab("Home range area (sq km)") + xlab("Total population")
        
    })
      
   output$text<-renderText({
        
          return(paste("<span style=\"color:red; font-size: 20px\">Predicted home range area in square kilometers is </span>", t$area))
          
              })
  })
}
