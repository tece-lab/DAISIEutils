test_that("calc_p_value produces correct output", {
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

  # Place files needed to run bootstrap
  reference_files <- list.files(
    "tests/testthat/testdata",
    full.names = TRUE,
    pattern = "*.rds", recursive = TRUE
  )
  expect_true(all(file.copy(reference_files, results_folder)))

  output <- calc_p_value(data = Azores, results_dir = results_folder)
  expected_output <- 0.33333333
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})

test_that("calc_p_value produces error", {
  expect_error(calc_p_value(data = "nonsense"))
})
