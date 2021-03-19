test_that("use setup_standard_model_args", {
  model <- 1
  r_lamc <- 1
  r_mu <- 2
  r_k <- 3
  r_gam <- 4
  r_ana <- 5

  model_arguments <- setup_standard_model_args(
    model = model,
    r_lamc = r_lamc,
    r_mu = r_mu,
    r_k = r_k,
    r_gam = r_gam,
    r_ana = r_ana
  )

  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = 1:5,
    complete_initparsopt = 1:5
  )

  expect_equal(model_arguments, expected_arguments)

  model <- 2

  model_arguments <- setup_standard_model_args(
    model = model,
    r_lamc = r_lamc,
    r_mu = r_mu,
    r_k = r_k,
    r_gam = r_gam,
    r_ana = r_ana
  )

  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(1, 2, 4, 5),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(1, 2, 4, 5),
    complete_initparsopt = c(1, 2, Inf, 4, 5)
  )

  expect_equal(model_arguments, expected_arguments)

  model <- 3

  model_arguments <- setup_standard_model_args(
    model = model,
    r_lamc = r_lamc,
    r_mu = r_mu,
    r_k = r_k,
    r_gam = r_gam,
    r_ana = r_ana
  )

  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = 1:4,
    parsfix = 0,
    idparsfix = 5,
    idparsnoshift = 6:10,
    initparsopt = 1:4,
    complete_initparsopt = c(1:4, 0)
  )

  expect_equal(model_arguments, expected_arguments)

  model <- 4

  model_arguments <- setup_standard_model_args(
    model = model,
    r_lamc = r_lamc,
    r_mu = r_mu,
    r_k = r_k,
    r_gam = r_gam,
    r_ana = r_ana
  )

  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(1, 2, 4),
    parsfix = c(Inf, 0),
    idparsfix = c(3, 5),
    idparsnoshift = 6:10,
    initparsopt = c(1, 2, 4),
    complete_initparsopt = c(1, 2, Inf, 4, 0)
  )

  expect_equal(model_arguments, expected_arguments)
})
