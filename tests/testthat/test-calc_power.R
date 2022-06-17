test_that("calc_power produces correct output", {
  data("Azores")

  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- 1

  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path("testdata"),
    full.names = TRUE,
    pattern = "*.rds",
    recursive = TRUE
  )
  expect_true(all(file.copy(reference_files, results_folder)))

  output <- calc_power(daisie_data = Azores, results_dir = temp_dir)

  expected_output <- 0.166666666667
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path("results"), recursive = TRUE), 0)
  expect_equal(unlink(file.path(temp_dir, "results"), recursive = TRUE), 0)
})

test_that("calc_power produces error", {
  expect_error(calc_power(daisie_data = "nonsense"))
})
