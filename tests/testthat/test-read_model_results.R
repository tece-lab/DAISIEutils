test_that("read_model_results works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  reference_path <- file.path("testdata", "results")
  obtained_results <- read_model_results(reference_path)

  expected_results <- list(
    "Azores" = list(
      "alt_m_cr_dd" =
        data.frame(
          "lambda_c" = 0.048520710927281,
          "mu" = 2.35595149303422,
          "K" = 0.703664856086461,
          "gamma" = 0.140370611735041,
          "lambda_a" = 1.55697333312365,
          "loglik" = -79.616849852223,
          "df" = 5,
          "conv" = 0,
          "bic" = 196.941997409774
        ), "alt_m_cr_di" =
        data.frame(
          "lambda_c" = 3.22797967279519e-08,
          "mu" = 2.31704163523973,
          "K" = Inf,
          "gamma" = 0.132897281407031,
          "lambda_a" = 1.55330115299497,
          "loglik" = -80.058029429177,
          "df" = 4,
          "conv" = 0,
          "bic" = 190.282697022616
        )
    )
  )
  expect_equal(object = obtained_results, expected = expected_results)
})
