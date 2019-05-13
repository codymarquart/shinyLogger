# shinyLogger - Logging Utility for R and Shiny Apps

[![build status](https://gitlab.com/clmarquart/shinyLogger/badges/master/build.svg)](https://gitlab.com/clmarquart/shinyLogger/pipelines)


## Quick Example

```
# Create logger at the INFO level. Default: TRACE
logger = Logger("INFO")

# No output for DEBUG
logger$debug("Debug message not shown")"

# Error message to display
logger$error("Show error message")
## ERROR: Show error

options("shiny.logLevel" = "DEBUG")

# Now debug messages will appear
logger$debug("Debug message to show")"
```

## Options

```
# Update log level
options("shiny.logLevel" = "DEBUG")
  
# Log colors enabled
options("shiny.logColors" = T)

# Disable auto-printing messages
options("shiny.logForcePrint" = F)
```
