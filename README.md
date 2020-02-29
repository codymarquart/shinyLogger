# shinyLogger - Logging Utility for R and Shiny Apps

## Overview

shinyLogger provides control over output messages within Shiny apps or long running R scripts.  It is often useful to see output throughout the life of an application or script for debugging or progress output.  However, typical output (e.g. `print` or `cat`) will flood the output and can even slow the app down if they are printing too frequently.  Commonly then, these statements are removed from scripts when moving to production to prevent such problems.

But at times, while in production, that extra output could be useful for debugging.  It's possible then to go back through the app and add back in some print statements, but wouldn't it be nice if those statements were already present waiting to be used when needed?  This is what shinyLogger aims to accomplish.  With five different logging levels, an application can have messages spread throughout at different levels of importatnce at all times.  For example, `error` and `warn` messages could be printed at all times, with `debug` and `trace` messages in more common spots without being printed.  Then in the case that more information on application status, the log level can be changed, allowing the the `debug` and/or `trace` output to print as well.

### Log Levels
  `log.levels <- c("ERROR","WARN","INFO","DEBUG","TRACE")`

### Log Colors
  `log.colors <- c("red","orange","white","green","blue")`

### Quick Example

Create logger at the INFO level. Default: TRACE

`logger = Logger("INFO")`

No output for DEBUG

`logger$debug("Debug message not shown")"`

Error message to display

`logger$error("Show error message")`
`## ERROR: Show error`

Decrease the logging threshold

`options("shiny.logLevel" = "DEBUG")`

Now debug messages will appear

`logger$debug("Debug message to show")"`


## Options

There are a few options that the package uses to configure output.  

```
# Update log level
options("shiny.logLevel" = "DEBUG")
  
# Log colors enabled
options("shiny.logColors" = T)

# Disable auto-printing messages
options("shiny.logForcePrint" = F)
```
