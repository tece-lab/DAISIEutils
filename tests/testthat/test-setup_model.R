test_that("use setup_model", {
  model <- "cr_dd"

  model_arguments <- setup_model(
    model = model
  )

  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = 1:5,
    cs_version = 1
  )

  expect_equal(model_arguments, expected_arguments)

  model <- "cr_di"

  model_arguments <- setup_model(
    model = model
  )

  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(1, 2, 4, 5),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(1, 2, 4, 5),
    cs_version = 1
  )

  expect_equal(model_arguments, expected_arguments)

  model <- "cr_dd_0lama"

  model_arguments <- setup_model(
    model = model
  )

  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = 1:4,
    parsfix = 0,
    idparsfix = 5,
    idparsnoshift = 6:10,
    initparsopt = 1:4,
    cs_version = 1
  )

  expect_equal(model_arguments, expected_arguments)

  model <- "cr_di_0lama"

  model_arguments <- setup_model(
    model = model
  )

  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(1, 2, 4),
    parsfix = c(Inf, 0),
    idparsfix = c(3, 5),
    idparsnoshift = 6:10,
    initparsopt = c(1, 2, 4),
    cs_version = 1
  )

  expect_equal(model_arguments, expected_arguments)
})
