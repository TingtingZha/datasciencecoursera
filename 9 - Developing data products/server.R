library(shiny)
library(datasets)
library(dplyr)
data("mtcars")

shinyServer(function(input, output) {
  output$table <- renderDataTable({
    mpg_seq <- seq(from = input$mpg[1], to = input$mpg[2], by = 0.1)
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.2)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    
    datatable <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg,Cylinders = cyl, Displacement = disp,
                           Horsepower = hp, Transmission = am)
    datatable <- filter(datatable, MilesPerGallon %in% mpg_seq, Cylinders %in% input$cyl, Displacement %in% disp_seq, 
                        Horsepower %in% hp_seq, Transmission %in% input$am)
    datatable <- mutate(datatable, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    
    datatable
     }  )
  
  output$plot <- renderPlot({
    mpg_seq <- seq(from = input$mpg[1], to = input$mpg[2], by = 0.1)
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.2)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
        
    datatable <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg,  Cylinders = cyl, Displacement = disp, 
                           Horsepower = hp, Transmission = am)
    datatable <- filter(datatable, MilesPerGallon %in% mpg_seq,Cylinders %in% input$cyl,Displacement %in% disp_seq, 
                        Horsepower %in% hp_seq, Transmission %in% input$am)
    datatable <- mutate(datatable, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    
    hist( datatable$MilesPerGallon,breaks = 5,xlab="Miles per Gallon", main="MPG Histogram", col="lightblue")
  
  })
})


