library(shiny)
shinyUI(fluidPage(
  titlePanel("Data with 'mtcars'"),
   sidebarLayout(
    sidebarPanel(
      sliderInput("mpg", "Miles Per Gallon", min=10, max=34, value=c(15,30), step=0.1),
      checkboxGroupInput("cyl", "Number of cylinders", c("4"=4, "6"=6, "8"=8), selected = c(4,6,8)),
      sliderInput("disp", "Displacement", min=70, max=480, value=c(70,480), step=5),
      sliderInput("hp", "Gross horsepower", min=50, max=340, value=c(80,300), step=5),
      checkboxGroupInput("am", "Transmission", c("Automatic"=0, "Manual"=1), selected = c(0,1))
                   ),
                   mainPanel(
                   tabsetPanel(
                         tabPanel("Table",  dataTableOutput("table")),
                         tabPanel("Plot",  plotOutput("plot"))
                         )
                            )
                   ))
)
