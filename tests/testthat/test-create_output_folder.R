test_that("Directory is created", {

  file_name <- create_output_folder(output_name = "test", model = 1)
  expect_equal(file_name, file.path(getwd(), "results", "test", "test_m_1.txt"))
  expect_true(dir.exists(file.path(getwd(), "results", "test")))
  # Clean-up
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})

test_that("Verbose sends message", {

  output_name <- "test"
  expect_message(
    file_name <- create_output_folder(
      output_name = output_name,
      model = 1,
      verbose = TRUE
    ),
    paste0(file.path(getwd(), "results", output_name),
           " not found, creating it.")
  )
  # Clean-up
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
