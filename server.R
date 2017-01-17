#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # create models based on hp or cyl
  hpModel <- lm(mpg ~ hp, data = mtcars)
  cylModel <- lm(mpg ~ cyl, data= mtcars)
  
  # Predict mpg based on given hp using model
  hpModelPred <- reactive({
    # Get input from sliders
    hpInput <- input$sliderHp
    # Make prediction
    predict(hpModel, newdata = data.frame(hp = hpInput))
  })
  
  # Predict mpg based on cyl using model
  cylModelPred <- reactive({
    # Get input from slider
    cylInput <- input$sliderCyl
    # Make prediction
    predict(cylModel, newdata = data.frame(cyl = cylInput))
  })
  
  
  # Create the plot
  output$plot1 <- renderPlot({
    hpInput <- input$sliderHp
    
    plot(mtcars$mpg ~ mtcars$hp, xlab = "Horsepower",
         ylab = "Miles per gallon", bty = "n", pch = 16)
    
    # show model in plot if checkbox is selected
    if(input$showHpModel){
      abline(hpModel, col = "red", lwd = 2)
    }
    # Add legend to the plot
    legend(25,250,"Model prediction", col = "red", bty = "n", cex = 1.2, pch = 16)
    # show the models prediction
    points(hpInput, hpModelPred(), col = "red", pch = 16)
    })
  
  output$plot2 <- renderPlot({
    cylInput <- input$sliderCyl
    plot(mtcars$mpg ~ mtcars$cyl, xlab = "Cylinders",
         ylab = "Miles per gallon", bty = "n", pch = 16)
    # show model in plot if selected
    if(input$showCylModel){
      abline(cylModel, col = "red", lwd = 2)
    }
    # add legend
    legend(25,250,"Model prediction", col = "red", bty = "n", cex = 1.2, pch = 16)
    # Show the prediction
    points(cylInput, cylModelPred(), col = "red", pch = 16 )
    })
  
    # get predicted mpg from model
    output$pred1 <- renderText({
    hpModelPred()
    })
    
    output$pred2 <- renderText({
      cylModelPred()
    })


})
summary(mtcars$hp)
