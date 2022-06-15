test_that("read_model_results works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  reference_path <- file.path("testdata", "results")
  obtained_results <- read_model_results(reference_path)


  expected_results <- list(
    "alt_m/Azores_alt_m_cr_dd" =
      data.frame(
        "lambda_c" = 0.00257412457018444,
        "mu" = 2.35602234733843,
        "K" = 0.873719229252812,
        "gamma" = 0.140372944642941,
        "lambda_a" = 1.55702668804627,
        "loglik" = -79.6168498481904,
        "df" = 5,
        "conv" = 0,
        "bic" = 196.941997401708
      ), "alt_m/Azores_alt_m_cr_di" =
      data.frame(
        "lambda_c" = 3.99557658227302e-08,
        "mu" = 2.32644864773932,
        "K" = Inf,
        "gamma" = 0.134810550341568,
        "lambda_a" = 1.53244170879051,
        "loglik" = -79.88722407779,
        "df" = 4,
        "conv" = 0,
        "bic" = 189.941086319842
      )
  )

  expect_equal(
    object = obtained_results$Azores[5:6],
    expected = expected_results
  )
})
