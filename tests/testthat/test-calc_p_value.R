test_that("calc_p_value produces correct output", {
  data("Azores", package = "relaxedDAISIE")

  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  ))

  # Place files need to run bootstrap
  reference_files <- list.files(
    "testdata/",
    full.names = TRUE,
    pattern = "*.rds"
  )
  expect_true(all(file.copy(reference_files, results_folder)))

  output <- calc_p_value(data = Azores)
  expected_output <- 0.33333333
  expect_equal(output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})

test_that("calc_p_value produces error", {
  expect_error(calc_p_value(data = "nonsense"))
})
