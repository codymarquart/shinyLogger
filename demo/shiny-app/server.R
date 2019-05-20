server <- function(session, input, output) {
  values <- reactiveValues(
    log = NULL,
    logLevel = NULL,
    bins = 30
  );
  updateLog <- function(x) {
    values$log = paste(c(values$log, x), collapse = "\n");
  }

  output$log <- reactive({ values$log });
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = values$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
  });

  observe({
    values$log = logger$debug("Start plot server.");
    logLevel = options("shiny.logLevel")[[1]]
    updateSelectInput(session, "log.level", selected = logLevel, choices = log.levels)
  });
  observeEvent(input$bins, {
    updateLog(logger$trace("Updating bins to: ", input$bins))

    values$bins = input$bins;
  });
  observeEvent(input$log.level, {
    set.threshold(input$log.level);
  });
}
