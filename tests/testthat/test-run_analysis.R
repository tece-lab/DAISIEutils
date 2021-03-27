test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- 1

  # Omit console output in tests
  invisible(capture.output(
    run_analysis(
      data = Galapagos_datalist, # nolint
      model = model,
      seed = seed,
      cond = cond
    )
  ))

  obtained_result <- readRDS(file.path(
    getwd(), "results", "Galapagos_datalist", "Galapagos_datalist_cr_dd_1.rds")
  )
  expected_data_frame <- data.frame(
    lambda_c = 2.57838865507069,
    mu = 2.70482929613855,
    K = 3074.82843572708,
    gamma = 0.00935776284898708,
    lambda_a = 1.00321372406581,
    loglik = -75.9999607726643,
    df = 5,
    conv = 0,
    bic = 195.728083272286)
  expect_equal(obtained_result, expected_data_frame)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
