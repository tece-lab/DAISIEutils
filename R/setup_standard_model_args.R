#' Set up DAISIE_ML arguments
#'
#' @inheritParams default_params_doc
#'
#' @return A list with [DAISIE::DAISIE_ML()] arguments.
#'
#' @author Luis M Valente, Pedro Neves
#' @examples
#' model <- 1
#' r_lamc <- 1
#' r_mu <- 2
#' r_k <- 3
#' r_gam <- 4
#' r_ana <- 5
#' hawaiispiders:::setup_model_arguments(
#'   model = model,
#'   r_lamc = r_lamc,
#'   r_mu = r_mu,
#'   r_k = r_k,
#'   r_gam = r_gam,
#'   r_ana = r_ana
#' )
setup_model_arguments <- function(model, r_lamc, r_mu, r_k, r_gam, r_ana) {
  testit::assert(model %in% 1:4)

  ## M1  CS - DD
  if (model == "1") {
    ddmodel <- 11
    idparsopt <- 1:5
    parsfix <- NULL
    idparsfix <- NULL
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_k, r_gam, r_ana)
  }


  ## M2 CS - DI
  if (model == "2") {
    ddmodel <- 0
    idparsopt <- c(1, 2, 4, 5)
    parsfix <- Inf
    idparsfix <- 3
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_gam, r_ana)
  }


  ## M3 CS - DD no anagenesis
  if (model == "3") {
    ddmodel <- 11
    idparsopt <- c(1, 2, 3, 4)
    parsfix <- 0
    idparsfix <- 5
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_k, r_gam)

  }

  ## M4 CS - DI no anagenesis
  if (model == "4") {
    ddmodel <- 0
    idparsopt <- c(1, 2, 4)
    parsfix <- c(Inf, 0)
    idparsfix <- c(3, 5)
    idparsnoshift <- 6:10
    initparsopt <- c(r_lamc, r_mu, r_gam)
  }

  out <- list(
    ddmodel = ddmodel,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    idparsnoshift = idparsnoshift,
    initparsopt = initparsopt
  )
  return(out)
}
