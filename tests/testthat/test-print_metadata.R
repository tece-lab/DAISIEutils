test_that("print_metadata works", {
  data_name <- "test_name"
  model <- "cr_dd"
  seed <- 123
  # Note: hides messages and output within test, still tests
  suppressMessages(invisible(capture.output(expect_message(
    print_metadata(data_name = data_name, model = model, seed = seed)
  ))))
  suppressMessages(expect_output(
    print_metadata(data_name = data_name, model = model, seed = seed)
  ))
})
