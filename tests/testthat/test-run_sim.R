test_that("run_sim cr model works", {
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  data <- Galapagos_datalist
  cond <- 1
  set.seed(1)
  lik_res <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    loglik = -76.00026,
    df = 5,
    conv = 0)
  out <- run_sim(
    data = data,
    model = model,
    lik_res = lik_res,
    cond = cond
  )
  # expect_true(is_daisie_data(out)) TODO: Finish is_daisie_data() to use this.

  expect_length(out[[1]], 8)
  expected_last_line <- c(Time = 0, nI = 5, nA = 1, nC = 9, present = 7)
  expect_equal(out[[1]][[1]]$stt_all[26, ], expected_last_line)
})

test_that("run_sim rr model works", {
  data(Galapagos_datalist, package = "DAISIE")
  model <- "rr_lac_di"
  data <- Galapagos_datalist
  cond <- 1
  set.seed(1)
  lik_res <- data.frame(
    lambda_c = 2.575631,
    mu = 2.703317,
    K = 4388.938,
    gamma = 0.009360516,
    lambda_a = 1.00351,
    sd = 1,
    loglik = -76.00026,
    df = 5,
    conv = 0)
  out <- run_sim(
    data = data,
    model = model,
    lik_res = lik_res,
    cond = cond
  )
  # expect_true(is_daisie_data(out)) TODO: Finish is_daisie_data() to use this.

  expect_length(out[[1]], 11)
  expected_last_line <- c(Time = 0, nI = 0, nA = 6, nC = 148, present = 10)
  expect_equal(out[[1]][[1]]$stt_all[26, ], expected_last_line)
})
