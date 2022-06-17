test_that("bootstrap_lr works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  data_name <- "Azores"
  model_1 <- "cr_dd"
  model_2 <- "cr_di"
  array_index <- 1
  cond <- 1
  test <- TRUE

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path("testdata", "Results", "Azores"),
    full.names = TRUE,
    pattern = "Azores_cr_*",
    recursive = TRUE
  )
  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  expect_true(all(file.copy(reference_files, results_folder)))

  # Omit console output in tests
  # invisible(suppressMessages(capture.output(
    bootstrap_lr(
      daisie_data = Azores,
      data_name = data_name,
      model_1 = model_1,
      model_2 = model_2,
      cond = cond,
      array_index = array_index,
      test = test,
      results_dir = results_folder
    )
  # )))
  actual_output <- readRDS(file.path(
    results_folder,
    "Azores_boot_lr_cr_dd_cr_di_1.rds"
  ))


  expected_output <- readRDS(
    file.path(
      "testdata",
      "results",
      "Azores",
      "Azores_boot_lr_cr_dd_cr_di_1.rds"
    )
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
})
