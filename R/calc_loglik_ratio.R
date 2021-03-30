#' Calculates the loglikelihood ratio between two models
#'
#' @inheritParams default_params_doc
#'
#' @return
#' @export
#'
#' @examples
calc_loglik_ratio <- function(
  model_1_lik_res,
  model_2_lik_res) {
  lik_ratio <- model_1_lik_res$loglik - model_2_lik_res$loglik
  return(lik_ratio)
}