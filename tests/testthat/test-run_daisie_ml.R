test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  rng_stream_index <- 1
  cond <- 1

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "tests/testthat/testdata/"), full.names = TRUE
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    rng_stream_index = 1
  )

  results_folder <- dirname(results_name)
  # results_folder <- file.path(getwd(), "results", data_name)
  expect_true(all(file.copy(reference_files, results_folder)))

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  invisible(capture.output(suppressMessages(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))

  obtained_result <- readRDS(file.path(
    getwd(), "results", "Azores", "Azores_cr_dd_1.rds")
  )
  expected_data_frame <- data.frame(
    lambda_c = 0.1147265796927377,
    mu = 2.3778308803941361,
    K = 0.74456307048433057,
    gamma = 0.041026917223855416,
    lambda_a = 1.5506801701109478,
    loglik = -100.33532706867457,
    df = 5,
    conv = 0,
    bic = 244.39881586430656)
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  model <- "cr_dd"
  data_name <- "Azores"
  rng_stream_index <- 1
  cond <- 1

  results_folder <- file.path(getwd(), "results", data_name)

  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )

  expect_true(all(file.copy(reference_files, results_folder)))

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = list(), # nolint
      data_name = data_name,
      model = model,
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- 1
  rng_stream_index <- 1
  cond <- 1
  results_folder <- file.path(getwd(), "results", data_name)

  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )
  expect_true(all(file.copy(reference_files, results_folder)))

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  rng_stream_index <- "nonsense"
  cond <- 1
  results_folder <- file.path(getwd(), "results", data_name)

  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )

  expect_true(all(file.copy(reference_files, results_folder)))

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  rng_stream_index <- 1
  cond <- "nonsense"
  results_folder <- file.path(getwd(), "results", data_name)


  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE
  )

  expect_true(all(file.copy(reference_files, results_folder)))

  dir.create(file.path("results", "rng_state"), recursive = TRUE)
  expect_true(all(
    file.copy(
      file.path(results_folder, "rng_state.rds"),
      file.path("results", "rng_state")))
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      rng_stream_index = rng_stream_index,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
