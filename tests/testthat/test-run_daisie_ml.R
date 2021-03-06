test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- 1
  test <- TRUE

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = 1
  )

  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))

  # Omit console output in tests
  invisible(capture.output(suppressMessages(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))

  obtained_result <- readRDS(file.path(
    getwd(), "results", "Azores", "Azores_cr_dd_1.rds")
  )
  expected_data_frame <- data.frame(
    lambda_c = 0.255152525210057,
    mu = 2.37865891764784,
    K = 0.688038204241112,
    gamma = 0.0410410972670184,
    lambda_a = 1.55073608640901,
    loglik = -100.335327768561,
    df = 5,
    conv = 0,
    bic = 244.39881726408)
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 10
  cond <- 1

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  )

  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))


  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = list(), # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
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
  array_index <- 10
  cond <- 1

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, , pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  )

  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
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
  array_index <- "nonsense"
  cond <- 1

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  )

  results_folder <- dirname(results_name)
  expect_true(all(file.copy(reference_files, results_folder)))


  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
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
  array_index <- 1
  cond <- "nonsense"

  # Place files need for run_daisie_ml
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, pattern = "*.rds"
  )
  results_name <- create_output_folder(
    data_name = data_name,
    model = model,
    array_index = array_index
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
