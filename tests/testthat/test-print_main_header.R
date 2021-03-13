test_that("print_main_header works", {
  run_name <- "test"
  m <- 5
  metadata <- 123
  # Note: hides messages and output within test, still tests
  suppressMessages(invisible(capture.output(expect_message(
    print_main_header(run_name = run_name, m = m, metadata = metadata)
  ))))
  suppressMessages(expect_output(
    print_main_header(run_name = run_name, m = m, metadata = metadata)
  ))
})
