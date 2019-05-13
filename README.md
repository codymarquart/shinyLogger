# shinyLogger - Logging Utility for R and Shiny Apps

## Quick Example

```
logger = Logger("INFO") # Create logger at the INFO level. Default: TRACE

logger$error("Show error")
## ERROR: Show error

logger$debug # No output
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
