test_that("calc_power produces correct output", {
  skip("WIP")
  data("Galapagos_datalist", package = "DAISIE")

  model <- "cr_dd"
  seed <- 1
  cond <- 1
  # Place files need to run test
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )
  results_name <- create_output_folder(
    data_name = "Galapagos_datalist",
    model = "boot",
    seed = 1
  )
  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))
  output <- calc_power(data = Galapagos_datalist)
  print(output)
  expected_output <- 0.904095904096
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)

})

test_that("calc_power produces error", {
  expect_error(calc_power(data = "nonsense"))
})
