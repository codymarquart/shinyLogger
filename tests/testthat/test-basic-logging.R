test_that("log something", {
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
  logger = Logger();
  show.msg = "Show something"
  hide.msg = "Hide something"
  shown.expected = "\033[32mDEBUG:\033[39mShow something\n"

  shown = logger$debug(show.msg)

  set.threshold(NULL)

  hidden = logger$debug(hide.msg)

  set.threshold("DEBUG")

  shown.again = logger$debug(show.msg)

  testthat::expect_null(hidden)
  testthat::expect_true(shown == shown.expected)
  testthat::expect_equal(shown, shown.again)
})
