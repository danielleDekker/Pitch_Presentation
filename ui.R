#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Predict miles per gallon based on horsepower or cylinders"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Create sliders to select the input
      sliderInput("sliderHp", "Select how much horsepower the car has", min = 52, max = 335, value = 120),
      # Create checkbox to show the model
      h4("Check box to view the model"),
      checkboxInput("showHpModel", "Model based on hp", value = FALSE),
      
      # Create slider 2 to select the input
      sliderInput("sliderCyl", "Select how many cylinders the cars has", min = 4, max = 8, value = 6, step = 2),
      # create checkbox 2
      h4("Check box to view the model"),
      checkboxInput("showCylModel", "Model based on cylinders", value = FALSE)
      ),
    
    # Show a the predicted MPG by hp and by cyl
    mainPanel(
      # Show output
      plotOutput("plot1"),
      h4("Predicted mpg by hp"),
      textOutput("pred1"),
      
      plotOutput("plot2"),
      h4("Predicted mpg by cyl"),
      textOutput("pred2")
      
    )
  )
))

