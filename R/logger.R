#####Shiny Logger#####
#' @title Shiny Logger
#' @description Main function for generating a logger to use within Shiny applications
#'
#' @param threshold Level at which to cut logging: See log.levels
#' @param colors Colors to use for logging, if the crayon package is available
#'
#' @export
#'
#' @examples
#' logger = Logger("INFO")
#' logger$error("Show error")
#' logger$warn("Show warning")
#' logger$info("Show info")
#' logger$debug("Show debug")
#' logger$trace("Show trace")
#' options("shiny.logLevel" = "TRACE")
#' logger$trace("Show trace")
#' set.threshold("WARN")
#' logger$info("Show info")
#' logger$warn("Show warning")
#'
#' @return List of class type `logging`
#####
Logger <- function(threshold = NULL, colors = log.colors) {
  can.color <- F;

  logLevel = options("shiny.logLevel")[[1]]
  if(is.null(threshold)) {
    threshold = logLevel;
  }

  set.threshold(threshold)

  logColors = options("shiny.logColors")[[1]];
  if(!is.null(logColors) && logColors == T) {
    if(requireNamespace("crayon", quietly = TRUE)) {
      can.color <- T

      for(c in colors) {
        assign(c, crayon::make_style(c));
      }
    }
  }

  check <- function(asked) {
    logLevel = options("shiny.logLevel")[[1]];
    askedLevel <- which(log.levels == asked);
    return(!is.null(logLevel) && askedLevel <= which(log.levels == logLevel));
  }
  logit <- function(reqLevel, ..., color = NULL, force.print = NULL) {
    print.opt = options("shiny.logForcePrint")[[1]]
    date.opt = options("shiny.logDate")[[1]]

    if(is.null(force.print)) {
      if(!is.null(print.opt))
        force.print = print.opt
      else
        force.print = T
    }

    if(check(reqLevel) == T) {

      level.txt = paste0(reqLevel, ": ")

      if(!is.null(color) && can.color == T) # && is.null(date.opt))
        level.txt = do.call(color, list(level.txt));

      msg = structure(paste0(level.txt, paste(...)), class = c("log", "character"))

      if(!is.null(date.opt))
        msg <- structure(paste(format(Sys.time(), date.opt), msg), class = class(msg))

      if(force.print) print(msg)
      else msg
    }
  }

  log.object = list(
     error = function(...) logit("ERROR", ..., color = colors[1])
    ,warn =  function(...) logit("WARN", ..., color  = colors[2])
    ,info =  function(...) logit("INFO",..., color   = colors[3])
    ,debug = function(...) logit("DEBUG", ..., color = colors[4])
    ,trace = function(...) logit("TRACE",..., color  = colors[5])
  )

  attr(log.object, "class") <- "Logger";
  return(log.object);
}

#' @title S3 print for log messages
#'
#' @param x object of class log
#' @param ... optional arguments to print (ignored)
#'
#' @export
print.log <- function(x, ...) cat(x, "\n")
