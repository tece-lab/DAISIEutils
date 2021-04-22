test_that("bootstrap works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_name <- "Azores"
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- 1

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path(getwd(), "testdata"), full.names = TRUE
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = "boot_cr_dd",
    array_index = 1
  )


  # Omit console output in tests
  invisible(suppressMessages(capture.output(
    bootstrap(
      data = Azores,
      data_name = data_name,
      model = "cr_dd",
      array_index = array_index,
      cond = cond
    )
  )))
  actual_output <- readRDS(results_name)

  expected_output <- readRDS(
    file.path(getwd(), "testdata/Azores_boot_cr_dd_1.rds")
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
})
