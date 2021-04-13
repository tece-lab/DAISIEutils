test_that("bootstrap_lr works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_name <- "Azores"
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  rng_stream_index <- 1
  cond <- 1

  # Place files need to run bootstrap
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = "boot_lr",
    rng_stream_index = 1
  )
  results_folder <- dirname(results_name)

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  invisible(suppressMessages(capture.output(
    bootstrap_lr(
      data = Azores,
      data_name = data_name,
      model_1 = "cr_dd",
      model_2 = "cr_di",
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  actual_output <- readRDS(results_name)

  expected_output <- readRDS(
    file.path(getwd(), "testdata/Azores_boot_lr_1.rds")
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
})
