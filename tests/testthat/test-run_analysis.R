test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  invisible(capture.output(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  ))


  colnames(expected_data_frame) <- column_names
  expect_equal(expected_data_frame, test_results[1, ],
               tolerance = 1e-6)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
