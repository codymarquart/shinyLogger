test_that("log something", {
  options("shiny.logForcePrint"=F)
  logger = Logger("INFO")

  err1 = logger$error("Show error")
  wrn1 = logger$warn("Show warning")
  inf1 = logger$info("Show info")
  dbg1 = logger$debug("Show debug")
  trc1 = logger$trace("Show trace")

  options("shiny.logLevel" = "TRACE")

  trc2 = logger$trace("Show trace")

  set.threshold("WARN")

  inf2 = logger$info("Show info")
  wrn2 = logger$warn("Show warning")

  testthat::expect_is(err1, "log")
  testthat::expect_is(wrn1, "log")
  testthat::expect_is(inf1, "log")
  testthat::expect_null(dbg1)
  testthat::expect_null(trc1)
  testthat::expect_is(trc2, "log")
  testthat::expect_null(inf2)
  testthat::expect_is(wrn2, "log")
})

test_that("log disabled", {
  options("shiny.logDate" = NULL)
  options("shiny.logColors" = TRUE)
  logger = Logger("DEBUG");
  show.msg = "Show something"
  hide.msg = "Hide something"
  shown.expected = "\033[32mDEBUG: \033[39mShow something"

  shown = logger$debug(show.msg)

  set.threshold(NULL)

  hidden = logger$debug(hide.msg)
  testthat::expect_null(hidden)

  set.threshold("DEBUG")
  shown.again = logger$debug(show.msg)

  # print("")
  # print(as.character(shown))
  # print(as.character(shown.again))
  # print("")
  testthat::expect_equal(shown, shown.again)
})

test_that("colorless logs", {
  options("shiny.logLevel" = "DEBUG")
  options("shiny.logColors" = FALSE)
  options("shiny.logDate" = NULL)
  logger = Logger();
  dbg1 <- logger$debug("Testing")
  testthat::expect_equal(as.character(dbg1), "DEBUG: Testing");
})

test_that("date logged", {
  options("shiny.logColors" = FALSE)
  options("shiny.logLevel" = "DEBUG")
  options("shiny.logDate" = "%Y-%b-%d %X")
  logger = Logger();
  with_date <- logger$debug("Testing")

  testthat::expect_true(grepl(x = with_date, pattern = "\\d{4}-\\w{3}-\\d{2}"))
})
test_that("date logged with color", {
  options("shiny.logForcePrint" = FALSE);
  options("shiny.logColors" = TRUE);
  options("shiny.logLevel" = "DEBUG");
  options("shiny.logDate" = "%Y-%b-%d %X");
  logger <- Logger();
  with_date <- logger$debug("Testing");
  with_date_chr <- as.character(with_date);

  testthat::expect_true(grepl(x = with_date, pattern = "\\d{4}-\\w{3}-\\d{2}"))
  testthat::expect_true(grepl(x = with_date_chr, pattern = "\\d{4}-\\w{3}-\\d{2}"))
  testthat::expect_match(with_date_chr, "\\\033\\[32mDEBUG: \\\033\\[39")
})
