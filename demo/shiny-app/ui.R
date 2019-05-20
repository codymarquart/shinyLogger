ui <- fluidPage(
  titlePanel("shinyLogger Demo"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1, max = 50, value = 30),
      selectInput("log.level", "Log Level", log.levels, selected = "DEBUG")
    ),
    mainPanel(
      plotOutput(outputId = "distPlot"),
      verbatimTextOutput("log")
    )
  )
)
