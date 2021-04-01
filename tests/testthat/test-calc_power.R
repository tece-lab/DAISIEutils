test_that("calc_power produces correct output", {
  skip("WIP")
  data("Galapagos_datalist", package = "DAISIE")

  model <- "cr_dd"
  seed <- 1
  cond <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  ))

  # Place files need to run bootstrap
  reference_files <- list.files(file.path(
    getwd(), "tests", "testdata"
  ), full.names = TRUE)
  expect_true(all(file.copy(reference_files, results_folder)))

  output <- calc_power(data = Galapagos_datalist)
  expected_output <- 0.904095904096
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)

})

test_that("calc_power produces error", {
  expect_error(calc_power(data = "nonsense"))
})
