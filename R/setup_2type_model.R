#' Set up DAISIE_ML arguments
#'
#' @inheritParams default_params_doc
#'
#' @return A named list with [DAISIE::DAISIE_ML()] arguments.
#'
#' @author Luis M Valente, Pedro Santos Neves, Joshua W. Lambert
#' @export
#' @examples
#' model <- "cr_dd"
#' setup_model(
#'   model = model
#' )
setup_2type_model <- function(model,
                              prop_type2_pool,
                              low_rates = FALSE) {
  expected_models <- get_available_models()
  testit::assert(model %in% expected_models)

  if (isFALSE(low_rates)) {
    lac <- stats::runif(1, min = 0, max = 2)
    mu <- stats::runif(1, min = 0, max = 2)
    k <- stats::runif(1, min = 100, max = 200)
    gam <- stats::runif(1, min = 1e-5, max = 0.1)
    laa <- stats::runif(1, min = 0.1, max = 4)
    lac2 <- stats::runif(1, min = 0, max = 2)
    mu2 <- stats::runif(1, min = 0, max = 2)
    k2 <- stats::runif(1, min = 100, max = 200)
  } else {
    lac <- stats::runif(1, min = 0, max = 0.1)
    mu <- stats::runif(1, min = 0, max = 0.1)
    k <- stats::runif(1, min = 250, max = 500)
    gam <- stats::runif(1, min = 1e-5, max = 0.1)
    laa <- stats::runif(1, min = 0, max = 0.1)
    lac2 <- stats::runif(1, min = 0, max = 0.1)
    mu2 <- stats::runif(1, min = 0, max = 0.1)
    k2 <- stats::runif(1, min = 250, max = 500)
  }

  # define default DAISIE model (CR DD)
  ddmodel <- 11
  idparsopt <- c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5)
  parsfix <- NULL
  idparsfix <- NULL
  idparsnoshift <- 6:10
  initparsopt <- c(lac = lac, mu = mu, k = k, gam = gam, laa = laa)
  cs_version <- 1

  # change to diversity-independence (DI)
  if (grepl("di", model)) {
    ddmodel <- 0
    idparsopt <- idparsopt[-which(names(idparsopt) == "k")] # TODO change
    parsfix <- Inf
    idparsfix <- 3
    initparsopt <- initparsopt[-which(names(initparsopt) == "k")]
  }

  # fix cladogenesis to zero
  if (grepl("0lac", model)) {
    idparsopt <- idparsopt[-which(names(idparsopt) == "lac")]
    parsfix <- c(0, parsfix)
    idparsfix <- c(1, idparsfix)
    initparsopt <- initparsopt[-which(names(initparsopt) == "lac")]
  }

  # fix anagenesis to zero
  if (grepl("0laa", model)) {
    idparsopt <- idparsopt[-which(names(idparsopt) == "laa")]
    parsfix <- c(parsfix, 0)
    idparsfix <- c(idparsfix, 5)
    initparsopt <- initparsopt[-which(names(initparsopt) == "laa")]
  }

  # change to 2type model
  if (grepl("2type", model)) {

    if (grepl("2type_lac", model)) {
      idparsopt <- c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6)
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- 7:10
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, lac2 = lac2
      )
    }

    if (grepl("2type_mu", model)) {
      idparsopt <- c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, mu2 = 7)
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(6, 8:10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, mu2 = mu2
      )
    }

    if (grepl("2type_k", model)) {
      idparsopt <- c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, k2 = 8)
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(6, 7, 9, 10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, k2 = k2
      )
    }

    if (grepl("2type_lac_mu", model)) {
      idparsopt <- c(
        lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, mu2 = 7
      )
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(8, 9, 10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, lac2 = lac2, mu2 = mu2
      )
    }

    if (grepl("2type_lac_k", model)) {
      idparsopt <- c(
        lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, k2 = 8
      )
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(7, 9, 10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, lac2 = lac2, k2 = k2
      )
    }

    if (grepl("2type_mu_k", model)) {
      idparsopt <- c(
        lac = 1, mu = 2, k = 3, gam = 4, laa = 5, mu2 = 7, k2 = 8
      )
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(6, 9, 10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, mu2 = mu2, k2 = k2
      )
    }

    if (grepl("2type_lac_mu_k", model)) {
      idparsopt <- c(
        lac = 1, mu = 2, k = 3, gam = 4, laa = 5, lac2 = 6, mu2 = 7, k2 = 8
      )
      parsfix <- prop_type2_pool
      idparsfix <- 11
      idparsnoshift <- c(9, 10)
      initparsopt <- c(
        lac = lac, mu = mu, k = k, gam = gam, laa = laa, lac2 = lac2,
        mu2 = mu2, k2 = k2
      )
    }
  }

  out <- list(
    ddmodel = ddmodel,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    idparsnoshift = idparsnoshift,
    initparsopt = initparsopt,
    cs_version = cs_version
  )
  return(out)
}
