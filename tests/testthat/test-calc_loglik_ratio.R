test_that("calc_loglik_ratio works", {
  lik_res_1 <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    loglik = -76.00026,
    df = 5,
    conv = 0)

  delta <- 200
  lik_res_2 <- data.frame(
    lambda_c = 2.575631 + 20,
    mu = 2.703317 + 20,
    K = 4388.938 + 20,
    gamma = 0.009360516 + 20,
    lambda_a = 1.00351 + 20,
    loglik = -76.00026 - delta,
    df = 5,
    conv = 0)

  actual_loglik_ratio <- calc_loglik_ratio(
    model_1_lik_res = lik_res_1,
    model_2_lik_res = lik_res_2
  )
  expect_length(actual_loglik_ratio, 1)
  expect_true(is.numeric(actual_loglik_ratio))
  expect_equal(actual_loglik_ratio, delta)
})

test_that("calc_loglik_ratio abuse", {
  lik_res_1 <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    loglik = -76.00026,
    df = 5,
    conv = 0)

  lik_res_2 <- c(1, 2, 3, 4, 5, 6, 7, 8)
  actual_loglik_ratio <- expect_error(
    calc_loglik_ratio(model_1_lik_res = lik_res_1, model_2_lik_res = lik_res_2)
  )
})
