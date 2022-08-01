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
      lac = 0.5310173262842,
      mu = 0.74424779927358,
      k = 157.28533633518964,
      gam = 0.09082169692158,
      laa = 0.88655953104608
    ),
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
    initparsopt = c(
      lac = 0.5310173262842,
      mu = 0.7442477992736,
      gam = 0.0908216969216,
      laa = 0.8865595310461
    ),
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
    initparsopt = c(
      lac = 0.5310173262842,
      mu = 0.74424779927358,
      k = 157.28533633518964,
      gam = 0.0908216969216
    ),
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
    initparsopt = c(
      lac = 0.5310173262842,
      mu = 0.7442477992736,
      gam = 0.0908216969216
    ),
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
    initparsopt = c(
      mu = 0.74424779927358,
      k = 157.28533633518964,
      gam = 0.09082169692158,
      laa = 0.88655953104608
    ),
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
    initparsopt = c(
      mu = 0.7442477992736,
      gam = 0.0908216969216,
      laa = 0.8865595310461
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_lac", {
  set.seed(1)
  model <- "cr_dd_2type_lac"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = 7:10,
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      lac2 = 1.7967793699353933
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_mu", {
  set.seed(1)
  model <- "cr_dd_2type_mu"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, mu2 = 7),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(6, 8:10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      mu2 = 1.8893505372107029
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_k", {
  set.seed(1)
  model <- "cr_dd_2type_k"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, k2 = 8),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(6, 7, 9, 10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      k2 = 166.0797792486846447
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_lac_mu", {
  set.seed(1)
  model <- "cr_dd_2type_lac_mu"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, mu2 = 7),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(8, 9, 10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      lac2 = 1.7967793699353933,
      mu2 = 1.8893505372107029
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_lac_k", {
  set.seed(1)
  model <- "cr_dd_2type_lac_k"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, k2 = 8),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(7, 9, 10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      lac2 = 1.7967793699353933,
      k2 = 166.0797792486846447
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_mu_k", {
  set.seed(1)
  model <- "cr_dd_2type_mu_k"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, mu2 = 7, k2 = 8),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(6, 9, 10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      mu2 = 1.8893505372107029,
      k2 = 166.0797792486846447
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for cr_dd_2type_lac_mu_k", {
  set.seed(1)
  model <- "cr_dd_2type_lac_mu_k"
  model_arguments <- setup_2type_model(
    model = model,
    prop_type2_pool = 0.163
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(
      lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, mu2 = 7, k2 = 8
    ),
    parsfix = 0.163,
    idparsfix = 11,
    idparsnoshift = c(9, 10),
    initparsopt = c(
      lac = 0.5310173262842000,
      mu = 0.7442477992735803,
      k = 157.2853363351896405,
      gam = 0.0908216969215777,
      laa = 0.8865595310460775,
      lac2 = 1.7967793699353933,
      mu2 = 1.8893505372107029,
      k2 = 166.0797792486846447
    ),
    cs_version = 1
  )
  expect_equal(model_arguments, expected_arguments)
})
