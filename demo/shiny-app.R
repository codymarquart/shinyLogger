library(shiny)


options("shiny.logLevel"="DEBUG")
options("shiny.logForcePrint"=F)
logger = Logger()
runApp("demo/shiny-app/", display.mode = "normal")
