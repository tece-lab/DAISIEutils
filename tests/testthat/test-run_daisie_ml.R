test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores", package = "relaxedDAISIE")
  data_name <- "Azores"
  model <- "cr_dd"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  invisible(capture.output(suppressMessages(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      seed = seed,
      cond = cond
    )
  )))

  obtained_result <- readRDS(file.path(
    getwd(), "results", "Azores", "Azores_cr_dd_1.rds")
  )
  expected_data_frame <- data.frame(
    lambda_c = 0.25515252521,
    mu = 2.37865891765,
    K = 0.688038204241,
    gamma = 0.041041097267,
    lambda_a = 1.55073608641,
    loglik = -100.335327769,
    df = 5,
    conv = 0,
    bic = 244.398817264)
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  model <- "cr_dd"
  data_name <- "Azores"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = list(), # nolint
      data_name = data_name,
      model = model,
      seed = seed,
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
  seed <- 1
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      seed = seed,
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
  seed <- "nonsense"
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      seed = seed,
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
  seed <- 1
  cond <- "nonsense"

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      data = Azores, # nolint
      data_name = data_name,
      model = model,
      seed = seed,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
