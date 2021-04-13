test_that("bootstrap works", {
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
    model = "boot",
    rng_stream_index = 1
  )
  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))

  rng_state_path <- file.path(getwd(), "testdata/rng_state/rng_state.rds")
  rng_state_temp_dir <- file.path("results", "rng_state")
  dir.create(path = rng_state_temp_dir, recursive = TRUE)
  expect_true(all(file.copy(rng_state_path, rng_state_temp_dir)))

  .GlobalEnv$.Random.seed <- read_seed()

  # Omit console output in tests
  invisible(suppressMessages(capture.output(
    bootstrap(
      data = Azores,
      data_name = data_name,
      model = "cr_dd",
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  actual_output <- readRDS(results_name)

  expected_output <- readRDS(
    file.path(getwd(), "testdata/Azores_boot_1.rds")
  )

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink("results", recursive = TRUE), 0)
})
