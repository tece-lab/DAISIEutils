test_that("print_metadata works", {
  data_name <- "test_name"
  model <- "cr_dd"
  array_index <- 123
  seed <- 1
  methode <- "lsodes"
  optimmethod <- "subplex"
  # Note: hides messages and output within test, still tests
  suppressMessages(invisible(capture.output(expect_message(
    print_metadata(
      data_name = data_name,
      model = model,
      array_index = array_index,
      seed = seed,
      methode = methode,
      optimmethod = optimmethod)
  ))))
  suppressMessages(expect_output(
    print_metadata(
      data_name = data_name,
      model = model,
      array_index = array_index,
      seed = seed,
      methode = methode,
      optimmethod = optimmethod)
  ))
})
