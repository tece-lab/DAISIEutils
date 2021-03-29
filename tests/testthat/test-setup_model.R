test_that("setup_model is correct for cr_dd", {
  set.seed(1)
  model <- "cr_dd"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(clado = 1, ex = 2, k = 3, immig = 4, ana = 5),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(
      clado = 5.31017326284e-01,
      ex = 7.44247799274e-01,
      k = 1.17133552490e+02,
      immig = 9.08207789995e-05,
      ana = 8.86559531046e-01 ),
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
    idparsopt = c(clado = 1, ex = 2, immig = 4, ana = 5),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(clado = 5.31017326284e-01,
                    ex = 7.44247799274e-01,
                    immig = 9.08207789995e-05,
                    ana = 8.86559531046e-01),
    cs_version = 1
  )

  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_0lama", {
  set.seed(1)
  model <- "cr_dd_0lama"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(clado = 1, ex = 2, k = 3, immig = 4),
    parsfix = 0,
    idparsfix = 5,
    idparsnoshift = 6:10,
    initparsopt = c(clado = 5.31017326284e-01,
                    ex = 7.44247799274e-01,
                    k = 1.17133552490e+02,
                    immig = 9.08207789995e-05),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_0lama", {
  set.seed(1)
  model <- "cr_di_0lama"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(clado = 1, ex = 2, immig = 4),
    parsfix = c(Inf, 0),
    idparsfix = c(3, 5),
    idparsnoshift = 6:10,
    initparsopt = c(clado = 5.31017326284e-01,
                    ex = 7.44247799274e-01,
                    immig = 9.08207789995e-05),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})
