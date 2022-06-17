test_that("run_sim cr model works", {
  data("Azores")
  model <- "cr_dd"
  daisie_data <- Azores
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
    conv = 0
  )
  out <- run_sim(
    daisie_data = daisie_data,
    model = model,
    lik_res = lik_res,
    cond = cond
  )

  expect_length(out[[1]], 11)
  expected_last_line <- c(Time = 0, nI = 4, nA = 2, nC = 23, present = 10)
  expect_equal(out[[1]][[1]]$stt_all[26, ], expected_last_line)
})

test_that("run_sim rr model works", {
  data("Azores")
  model <- "rr_lac_di"
  daisie_data <- Azores
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
    conv = 0
  )
  out <- run_sim(
    daisie_data = daisie_data,
    model = model,
    lik_res = lik_res,
    cond = cond
  )

  expect_length(out[[1]], 9)
  expected_last_line <- c(Time = 0, nI = 1, nA = 3, nC = 325, present = 8)
  expect_equal(out[[1]][[1]]$stt_all[26, ], expected_last_line)
})
