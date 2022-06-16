test_that("Directory is created", {
  data_name <- "test"
  model <- "cr_dd"
  array_index <- 1
  expect_message(file_name <- create_output_folder(
      data_name = data_name
    ), regexp = "results/test not found, creating it."
  )
  expect_equal(
    file_name,
    file.path("results", "test")
  )
  expect_true(dir.exists(file.path(getwd(), "results", "test")))
  # Clean-up
  expect_equal(unlink(file.path("results"), recursive = TRUE), 0)
})
