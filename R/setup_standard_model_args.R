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
#' r_lamc <- 1
#' r_mu <- 2
#' r_k <- 3
#' r_gam <- 4
#' r_ana <- 5
#' setup_standard_model_args(
#'   model = model,
#'   r_lamc = r_lamc,
#'   r_mu = r_mu,
#'   r_k = r_k,
#'   r_gam = r_gam,
#'   r_ana = r_ana
#' )
setup_standard_model_args <- function(model, r_lamc, r_mu, r_k, r_gam, r_ana) {
  expected_models <- c("cr_dd", "cr_di", "cr_dd_0laa", "cr_di_0laa")
  testit::assert(model %in% expected_models)

  ## M1  CS - DD
  if (model == "cr_dd") {
    ddmodel <- 11
    idparsopt <- 1:5
    parsfix <- NULL
    idparsfix <- NULL
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_k, r_gam, r_ana)
    cs_version <- 1
  }


  ## M2 CS - DI
  if (model == "cr_di") {
    ddmodel <- 0
    idparsopt <- c(1, 2, 4, 5)
    parsfix <- Inf
    idparsfix <- 3
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_gam, r_ana)
    cs_version <- 1
  }


  ## M3 CS - DD no anagenesis
  if (model == "cr_dd_0laa") {
    ddmodel <- 11
    idparsopt <- c(1, 2, 3, 4)
    parsfix <- 0
    idparsfix <- 5
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_k, r_gam)
    cs_version <- 1
  }

  ## M4 CS - DI no anagenesis
  if (model == "cr_di_0laa") {
    ddmodel <- 0
    idparsopt <- c(1, 2, 4)
    parsfix <- c(Inf, 0)
    idparsfix <- c(3, 5)
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_gam)
    cs_version <- 1
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
