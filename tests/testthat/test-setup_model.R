test_that("setup_model is correct for cr_dd", {
  set.seed(1)
  model <- "cr_dd"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(
      lac = 5.31017326284e-01,
      mu = 7.44247799274e-01,
      k = 1.17133552490e+02,
      gam = 9.08207789995e-05,
      laa = 8.86559531046e-01),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_di", {
  set.seed(1)
  model <- "cr_di"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(lac = 1, mu = 2, gam = 4, laa = 5),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 5.31017326284e-01,
                    mu = 7.44247799274e-01,
                    gam = 9.08207789995e-05,
                    laa = 8.86559531046e-01),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_0laa", {
  set.seed(1)
  model <- "cr_dd_0laa"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4),
    parsfix = 0,
    idparsfix = 5,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 5.31017326284e-01,
                    mu = 7.44247799274e-01,
                    k = 1.17133552490e+02,
                    gam = 9.08207789995e-05),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_di_0laa", {
  set.seed(1)
  model <- "cr_di_0laa"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(lac = 1, mu = 2, gam = 4),
    parsfix = c(Inf, 0),
    idparsfix = c(3, 5),
    idparsnoshift = 6:10,
    initparsopt = c(lac = 5.31017326284e-01,
                    mu = 7.44247799274e-01,
                    gam = 9.08207789995e-05),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_0lac", {
  set.seed(1)
  model <- "cr_dd_0lac"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(mu = 2, k = 3, gam = 4, laa = 5),
    parsfix = 0,
    idparsfix = 1,
    idparsnoshift = 6:10,
    initparsopt = c(mu = 7.44247799274e-01,
                    k = 1.17133552490e+02,
                    gam = 9.08207789995e-05,
                    laa = 8.865595e-01),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_di_0lac", {
  set.seed(1)
  model <- "cr_di_0lac"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(mu = 2, gam = 4, laa = 5),
    parsfix = c(0, Inf),
    idparsfix = c(1, 3),
    idparsnoshift = 6:10,
    initparsopt = c(mu = 0.744247799274,
                    gam = 0.000090820779,
                    laa = 0.886559531046),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_lac_di", {
  set.seed(1)
  model <- "rr_lac_di"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(lac = 1, mu = 2, gam = 4, laa = 5, 6),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.53101732628419995,
                    mu = 0.74424779927358031,
                    gam = 0.00009082077899948,
                    laa = 0.88655953104607754,
                    9.085507164709270e-01),
    cs_version = list(model = 2,
                      relaxed_par = "cladogenesis")
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_lac_dd", {
  set.seed(1)
  model <- "rr_lac_dd"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, 6),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    k = 117.1335524902679026,
                    gam = 0.0000908207789995,
                    laa = 0.8865595310460775,
                    0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "cladogenesis")
  )
  expect_equal(model_arguments, expected_arguments)
})
