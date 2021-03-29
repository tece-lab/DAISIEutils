#' Set up DAISIE_ML arguments
#'
#' @inheritParams default_params_doc
#'
#' @return A named list with [DAISIE::DAISIE_ML()] arguments.
#'
#' @author Luis M Valente, Pedro Neves, Joshua W. Lambert
#' @export
#' @examples
#' model <- "cr_dd"
#' setup_model(
#'   model = model
#' )
setup_model <- function(
  model) {
  expected_models <- c("cr_dd", "cr_di", "cr_dd_0lama", "cr_di_0lama",
                       "cr_di_0lamc", "cr_dd_0lamc", "rr_lamc_di",
                       "rr_lamc_dd", "rr_mu_di", "rr_mu_dd", "rr_k",
                       "rr_lama_di", "rr_lama_dd", "rr_mu_di_0lamc",
                       "rr_mu_dd_0lamc", "rr_k_0lamc", "rr_lama_di_0lamc",
                       "r_lama_dd_0lamc", "rr_lamc_di_0lama",
                       "rr_lamc_dd_0lama", "rr_mu_di_0lama", "rr_mu_dd_0lama",
                       "rr_k_0lama")
  testit::assert(model %in% expected_models)

  lamc <- stats::runif(1, min = 0, max = 2)
  mu <- stats::runif(1, min = 0, max = 2)
  k <- stats::runif(1, min = 6, max = 200)
  gam <- stats::runif(1, min = 0, max = 0.0001)
  lama <- stats::runif(1, min = 0.1, max = 4)
  sd <- stats::runif(1, min = 0.1, max = 1)

  # define default DAISIE model (CR DD)
  ddmodel <- 11
  idparsopt <- c(clado = 1, ex = 2, k = 3, immig = 4, ana = 5)
  parsfix <- NULL
  idparsfix <- NULL
  idparsnoshift <- 6:10
  initparsopt <- c(clado = lamc, ex = mu, k = k, immig = gam, ana = lama)
  cs_version <- 1

  # change to diversity-independence (DI)
  if (grepl("di", model)) {
    ddmodel <- 0
    idparsopt <- idparsopt[-which(names(idparsopt) == "k")] #TODO change
    parsfix <- Inf
    idparsfix <- 3
    initparsopt <- initparsopt[-which(names(initparsopt) == "k")]
  }

  # fix cladogenesis to zero
  if (grepl("0lamc", model)) {
    idparsopt <- idparsopt[-which(names(idparsopt) == "clado")]
    parsfix <- c(0, parsfix)
    idparsfix <- c(1, idparsfix)
    initparsopt <- initparsopt[-which(names(initparsopt) == "clado")]
  }

  # fix anagenesis to zero
  if (grepl("0lama", model)) {
    idparsopt <- idparsopt[-which(names(idparsopt) == "ana")]
    parsfix <- c(parsfix, 0)
    idparsfix <- c(idparsfix, 5)
    initparsopt <- initparsopt[-which(names(initparsopt) == "ana")]
  }

  # change to relaxed-rate model
  if (grepl("rr", model)) {
    idparsopt <- c(idparsopt, 6)
    initparsopt <- c(initparsopt, sd)
    if (grepl("rr_lamc")) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "cladogenesis")
    }
    if (grepl("rr_mu")) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "extinction")
    }
    if (grepl("rr_k")) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "carrying_capacity")
    }
    if (grepl("rr_lama")) {
      cs_version <- DAISIE::create_CS_version(
        model = 2,
        relaxed_par = "anagenesis")
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
