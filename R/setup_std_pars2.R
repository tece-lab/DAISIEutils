#' Fills pars2 vector for most common DAISIE ML CS runs
#'
#' Returns the pars2 vector needed for the most simple `DAISIE_ML_CS()` runs,
#' to facilitate computing the loglikelihood in these cases. This function
#' should only be assumed correct for the LL setup of the CS model, 1 type,
#' constant rate no equilibrium models. Tolerances and other technical
#' parameters need not be specified, as the returned values match the default
#' values of [DAISIE::DAISIE_ML()]. The only arguments without default values
#' are `ddmodel` and `cond`, as these are most often varied when checking model
#' output. Regardless, all other default parameter values can be forced to
#' meet specific needs of more complex models.
#'
#' @inheritParams default_params_doc
#'
#' @return A numeric vector of length 12 containing pars2 for
#' [DAISIE::DAISIE_ML()]
#' @export
#'
#' @author Pedro Santos Neves
#' @examples
#' std_pars2 <- setup_std_pars2()
setup_std_pars2 <- function(res = 100,
                            ddmodel,
                            cond,
                            verbose = 0,
                            island_ontogeny = NA,
                            eqmodel = 0,
                            tol = c(1e-04, 1e-05, 1e-07),
                            maxiter = 1000 * round((1.25) ^ 5),
                            x_E = 0.95,
                            x_I = 0.98) {


  pars2 <- c(
    res = res,
    ddmodel = ddmodel,
    cond = cond,
    verbose = verbose,
    island_ontogeny = island_ontogeny,
    eqmodel = eqmodel,
    tol = tol,
    maxiter = maxiter,
    x_E = x_E,
    x_I = x_I
  )
  testit::assert(is.numeric(pars2))
  testit::assert(identical(length(pars2), 12L))
  pars2
}
