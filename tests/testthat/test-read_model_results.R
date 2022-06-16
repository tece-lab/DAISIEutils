test_that("read_model_results works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  reference_path <- file.path("testdata", "results")
  obtained_results <- read_model_results(reference_path)


  expected_results <- list(
    "alt_m/Azores_alt_m_cr_dd" =
      data.frame(
        "lambda_c" = 0.0532036379224515,
        "mu" = 2.3954562190509,
        "K" = 0.539011326930247,
        "gamma" = 0.144178336375056,
        "lambda_a" = 1.55745249107718,
        "loglik" = -79.45085798656,
        "df" = 5,
        "conv" = 0,
        "bic" = 196.610013678448
      ), "alt_m/Azores_alt_m_cr_di" =
      data.frame(
        "lambda_c" = 1.89089591489513e-09,
        "mu" = 2.35061895971731,
        "K" = Inf,
        "gamma" = 0.138872540572425,
        "lambda_a" = 1.51018236709836,
        "loglik" = -79.565285011202,
        "df" = 4,
        "conv" = 0,
        "bic" = 189.297208186666
      )
  )

  expect_equal(
    object = obtained_results$Azores[5:6],
    expected = expected_results
  )
})
