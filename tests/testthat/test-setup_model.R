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
      laa = 8.86559531046e-01 ),
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

test_that("setup_model is correct for cr_dd_0laa", {
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
