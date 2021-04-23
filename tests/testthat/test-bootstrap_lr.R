test_that("bootstrap_lr works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model_1 <- "cr_dd"
  model_2 <- "cr_di"
  array_index <- 1
  cond <- 1
  test <- TRUE

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = paste("boot_lr", model_1, model_2, sep = "_"),
    array_index = 1
  )

  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))

  # Omit console output in tests
  invisible(suppressMessages(capture.output(
    bootstrap_lr(
      data = Azores,
      data_name = data_name,
      model_1 = model_1,
      model_2 = model_2,
      cond = cond,
      array_index,
      test = test
    )
  )))
  actual_output <- readRDS(results_name)

  expected_output <- readRDS(
    file.path(getwd(), "testdata/Azores_boot_lr_cr_dd_cr_di_1.rds")
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
})
