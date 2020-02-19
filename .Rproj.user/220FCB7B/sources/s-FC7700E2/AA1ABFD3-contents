##
#' @title Set Logging Threshold
#' @description Set the level for logging messages
#' @details Used to set the level at which messages are printed out.  If set to INFO, messages of DEBUG and TRACE will not be printed.
#'
#' @export
#'
#' @param threshold Default value to set as the threshold
#'
#' @return NULL
##
set.threshold <- function(threshold = "DEBUG") {
  if(!is.null(threshold)) {
    threshold <- match.arg(threshold, log.levels);

    options("shiny.logLevel" = threshold)
  } else {
    options("shiny.logLevel" = NULL)
  }
}
