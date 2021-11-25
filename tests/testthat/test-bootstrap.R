test_that("bootstrap works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_name <- "Azores"
  data("Azores")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- 1
  test <- TRUE

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path("testdata/results/Azores"), full.names = TRUE, pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = "boot_cr_dd",
    array_index = 1
  )
  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))


  # Omit console output in tests
  invisible(suppressMessages(capture.output(
    bootstrap(
      data = Azores,
      data_name = data_name,
      model = "cr_dd",
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))
  actual_output <- readRDS(results_name)

  expected_output <- readRDS(
    file.path("testdata/results/Azores/Azores_boot_cr_dd_1.rds")
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
})
