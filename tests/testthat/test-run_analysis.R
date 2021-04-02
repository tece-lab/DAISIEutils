test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  invisible(capture.output(suppressMessages(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  )))

  obtained_result <- readRDS(file.path(
    getwd(), "results", "Galapagos_datalist", "Galapagos_datalist_cr_dd_1.rds")
  )
  expected_data_frame <- data.frame(
    lambda_c = 2.556237280343648,
    mu = 2.686757075111843,
    K = 9245.783416787153,
    gamma = 0.009325448643906421,
    lambda_a = 1.007726332102268,
    loglik = -75.99980195099431,
    df = 5,
    conv = 0,
    bic = 195.727765628946)
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_analysis fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  model <- "cr_dd"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_analysis(
      data = list(), # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_analysis fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- 1
  seed <- 1
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_analysis fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- "nonsense"
  cond <- 1

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})

test_that("run_analysis fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- "nonsense"

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  )))
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
