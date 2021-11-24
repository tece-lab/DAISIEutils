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
      laa = 0.88655953104608),
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
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992736,
                    gam = 0.0908216969216,
                    laa = 0.8865595310461),
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
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.74424779927358,
                    k = 157.28533633518964,
                    gam = 0.0908216969216),
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
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992736,
                    gam = 0.0908216969216),
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
    initparsopt = c(mu = 0.74424779927358,
                    k = 157.28533633518964,
                    gam = 0.09082169692158,
                    laa = 0.88655953104608),
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
    initparsopt = c(mu = 0.7442477992736,
                    gam = 0.0908216969216,
                    laa = 0.8865595310461),
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
    idparsopt = c(lac = 1, mu = 2, gam = 4, laa = 5, sd = 6),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.53101732628419995,
                    mu = 0.74424779927358031,
                    gam = 0.0908216969216,
                    laa = 0.88655953104607754,
                    sd = 9.085507164709270e-01),
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
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, sd = 6),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    k = 157.28533633518964,
                    gam = 0.09082169692158,
                    laa = 0.8865595310460775,
                    sd = 0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "cladogenesis")
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_mu_dd", {
  set.seed(1)
  model <- "rr_mu_dd"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, sd = 6),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    k = 157.28533633518964,
                    gam = 0.09082169692158,
                    laa = 0.8865595310460775,
                    sd = 0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "extinction")
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_mu_di", {
  set.seed(1)
  model <- "rr_mu_di"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 0,
    idparsopt = c(lac = 1, mu = 2, gam = 4, laa = 5, sd = 6),
    parsfix = Inf,
    idparsfix = 3,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    gam = 0.09082169692157768,
                    laa = 0.88655953104607754,
                    sd = 0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "extinction")
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_k", {
  set.seed(1)
  model <- "rr_k"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, sd = 6),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    k = 157.28533633518964,
                    gam = 0.09082169692158,
                    laa = 0.8865595310460775,
                    sd = 0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "carrying_capacity")
  )
  expect_equal(model_arguments, expected_arguments)
})

test_that("setup_model is correct for rr_laa_dd", {
  set.seed(1)
  model <- "rr_laa_dd"
  model_arguments <- setup_model(
    model = model
  )
  expected_arguments <- list(
    ddmodel = 11,
    idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, sd = 6),
    parsfix = NULL,
    idparsfix = NULL,
    idparsnoshift = 6:10,
    initparsopt = c(lac = 0.5310173262842,
                    mu = 0.7442477992735803,
                    k = 157.28533633518964,
                    gam = 0.09082169692158,
                    laa = 0.8865595310460775,
                    sd = 0.9085507164709270),
    cs_version = list(model = 2,
                      relaxed_par = "anagenesis")
  )
  expect_equal(model_arguments, expected_arguments)
})
