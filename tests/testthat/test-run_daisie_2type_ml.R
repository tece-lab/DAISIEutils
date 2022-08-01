test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  Azores[[1]]$not_present <- NULL # nolint
  Azores[[1]]$not_present_type1 <- 900 # nolint
  Azores[[1]]$not_present_type2 <- 83 # nolint
  Azores[[2]]$type1or2 <- 2 # nolint
  data_name <- "Azores"
  model <- "cr_dd_2type_lac"
  array_index <- 1
  cond <- 2
  test <- TRUE


  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  # Omit console output in tests
  invisible(capture.output(suppressMessages(
    run_daisie_2type_ml(
      daisie_data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test,
      results_dir = results_folder,
      prop_type2_pool = 0.163
    )
  )))

  obtained_result <- readRDS(file.path(
    results_folder, "Azores", "Azores_cr_dd_2type_lac_1.rds"
  ))
  expected_data_frame <- data.frame(
    lambda_c = 0.0001522401495244741,
    mu = 2.466608181929915,
    K = 1.000041410128819,
    gamma = 0.04184459392408853,
    lambda_a = 1.518366951094948,
    lambda_c2 = 7303.538959742727,
    mu2 = 2.466608181929915,
    K2 = 1.000041410128819,
    gamma2 = 0.04184459392408853,
    lambda_a2 = 1.518366951094948,
    prop_type2 = 0.163,
    loglik = -100.196436286698,
    df = 6,
    conv = 0,
    bic = 252.8666666457449
  )
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
  expect_equal(unlink(results_folder, recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 10
  cond <- 1



  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )


  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      daisie_data = list(), # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))
  # Clean-up
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
  expect_equal(unlink(results_folder, recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  data_name <- "Azores"
  model <- 1
  array_index <- 10
  cond <- 1


  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      daisie_data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
    )
  )))
  # Clean-up
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
  expect_equal(unlink(results_folder, recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- "nonsense"
  cond <- 1

  # Place files need for run_daisie_ml
  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      daisie_data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))
  # Clean-up
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
  expect_equal(unlink(results_folder, recursive = TRUE), 0)
})

test_that("run_daisie_ml fails when expected", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data("Azores")
  data_name <- "Azores"
  model <- "cr_dd"
  array_index <- 1
  cond <- "nonsense"

  temp_dir <- tempdir()
  results_folder <- create_output_folder(
    data_name = data_name,
    results_dir = temp_dir
  )

  # Omit console output in tests
  expect_error(invisible(capture.output(
    run_daisie_ml(
      daisie_data = Azores, # nolint
      data_name = data_name,
      model = model,
      array_index = array_index,
      cond = cond,
      test = test
    )
  )))
  # Clean-up
  expect_equal(unlink(temp_dir, recursive = TRUE), 0)
  expect_equal(unlink(results_folder, recursive = TRUE), 0)
})
