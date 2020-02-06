# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.

library(shiny)
library(dplyr)
library(ggplot2)

# Define UI for application
shinyUI(fluidPage(
  
  # title
  titlePanel("Use latitude and population to predict home range area of hunter-gatherers (Binford dataset)"),
  
  # Sidebar with input variables 
  sidebarLayout(
    sidebarPanel(
       numericInput(inputId="latitude", label="Absolute latitude", 
                    value=10,min=0, max=90),
       numericInput(inputId="tlpop", label="Total population", 
                    value=1000,min=0, max=10000000)
       ),
    
    # get prediction
    mainPanel(
      actionButton("Enter", "Get prediction"),
    #  htmlOutput(""),
      htmlOutput("text"),
      plotOutput("plot_foo")
      
    )
  )
))
