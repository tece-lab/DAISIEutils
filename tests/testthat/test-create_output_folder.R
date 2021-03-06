test_that("Directory is created", {
  data_name <- "test"
  model <- "cr_dd"
  array_index <- 1
  file_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  )
  expect_equal(
    file_name,
    file.path("results", "test", "test_cr_dd_1.rds")
  )
  expect_true(dir.exists(file.path(getwd(), "results", "test")))
  # Clean-up
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
