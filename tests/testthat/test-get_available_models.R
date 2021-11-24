test_that("Correct models are returned", {
  obtained_output <- get_available_models()

  expected_output <- c("cr_dd", "cr_di", "cr_dd_0laa", "cr_di_0laa",
                       "cr_di_0lac", "cr_dd_0lac", "rr_lac_di",
                       "rr_lac_dd", "rr_mu_di", "rr_mu_dd", "rr_k",
                       "rr_laa_di", "rr_laa_dd", "rr_mu_di_0lac",
                       "rr_mu_dd_0lac", "rr_k_0lac", "rr_laa_di_0lac",
                       "rr_laa_dd_0lac", "rr_lac_di_0laa",
                       "rr_lac_dd_0laa", "rr_mu_di_0laa", "rr_mu_dd_0laa",
                       "rr_k_0laa")

  expect_equal(obtained_output, expected_output)
})