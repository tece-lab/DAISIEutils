#' Plot contour of loglikelihood surface around a given value
#'
#' Plots the likelihood surface around a set of parameters `initparopt` around
#' two axes (`param_1` and `param_2`). The loglikelihood is computed according
#' to specified model parameters.
#'
#' @inheritParams default_params_doc
#'
#' @return A ggplot with the likelihood surface.
#' @export
#'
#' @author Pedro Santos Neves
plot_ll_surface <- function(datalist, initparsopt, param_1, param_2, model) {
  testit::assert(model %in% get_available_models())
  model_setup <- setup_model(model)
  model_setup$initparsopt <- initparsopt

  testit::assert(param_1 %in% c("lac", "mu", "k", "gam", "laa"))
  testit::assert(param_2 %in% c("lac", "mu", "k", "gam", "laa"))

  # Obtain logliks
  pars2 <- setup_std_pars2(
    ddmodel = 11,
    cond = 1,
  )
  DAISIE:::DAISIE_loglik_all(
    datalist = r_c_no,
    pars1 = model_setup$initparsopt,
    pars2 = pars2,
    CS_version = model_setup$cs_version
  )
}
