test_that("calc_power produces correct output", {
  data("Azores", package = "relaxedDAISIE")

  data_name <- "Azores"
  model <- "cr_dd"
  rng_stream_index <- 1
  cond <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    rng_stream_index = rng_stream_index
  ))

  # Place files need to run bootstrap
  reference_files <- list.files("testdata/", full.names = TRUE)
  expect_true(all(file.copy(reference_files, results_folder)))
  output <- calc_power(data = Azores)

  expected_output <- 0.166666666666667
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)

})

test_that("calc_power produces error", {
  expect_error(calc_power(data = "nonsense"))
})
