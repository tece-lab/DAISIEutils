test_that("calc_bic works", {
  data("Azores")
  results <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    loglik = -76.00026,
    df = 5,
    conv = 0)
  bic <- calc_bic(
    results = results,
    data = Azores)
  expect_equal(bic, 195.7286817)
})

test_that("calc_bic fails when expected", {
  data <- list("nonsense")
  results <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    loglik = -76.00026,
    df = 5,
    conv = 0)
  expect_error(calc_bic(
    results = results,
    data = data))
})

test_that("calc_bic fails when expected", {
  data("Azores")
  results <- data.frame(
    lambda_c = "nonsense",
    mu = "nonsense",
    K = "nonsense",
    gamma = "nonsense",
    lambda_a = "nonsense",
    loglik = "nonsense",
    df = "nonsense",
    conv = "nonsense")
  expect_error(calc_bic(
    results = results,
    data = Azores))
})
