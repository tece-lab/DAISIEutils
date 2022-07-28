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
setup_model <- function(model,
                        low_rates = FALSE) {
  expected_models <- get_available_models()
  testit::assert(model %in% expected_models)

  if (isFALSE(low_rates)) {
    lac <- stats::runif(1, min = 0, max = 2)
    mu <- stats::runif(1, min = 0, max = 2)
    k <- stats::runif(1, min = 100, max = 200)
    gam <- stats::runif(1, min = 1e-5, max = 0.1)
    laa <- stats::runif(1, min = 0.1, max = 4)
    sd <- stats::runif(1, min = 0.1, max = 1)
    prob_init_presence <- stats::runif(1, min = 0, max = 0.9)
  } else {
    lac <- stats::runif(1, min = 0, max = 0.1)
    mu <- stats::runif(1, min = 0, max = 0.1)
    k <- stats::runif(1, min = 250, max = 500)
    gam <- stats::runif(1, min = 1e-5, max = 0.1)
    laa <- stats::runif(1, min = 0, max = 0.1)
    sd <- stats::runif(1, min = 0.1, max = 1)
    prob_init_presence <- stats::runif(1, min = 0, max = 0.1)
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

  # change to relaxed-rate model
  if (grepl("rr", model)) {
    idparsopt <- c(idparsopt, sd = 6)
    initparsopt <- c(initparsopt, sd = sd)
    if (grepl("rr_lac", model)) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "cladogenesis"
      )
    }
    if (grepl("rr_mu", model)) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "extinction"
      )
    }
    if (grepl("rr_k", model)) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "carrying_capacity"
      )
    }
    if (grepl("rr_gam", model)) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "immigration"
      )
    }
    if (grepl("rr_laa", model)) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "anagenesis"
      )
    }
  }

  # change to non-oceanic model
  if (grepl("nonoceanic", model)) {
    idparsopt <- c(idparsopt, prob_init_presence = 6)
    initparsopt <- c(initparsopt, prob_init_presence = prob_init_presence)
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
