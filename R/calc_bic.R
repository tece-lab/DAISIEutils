#' Compute Bayesian Information Criterion of a model
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric value with BIC
#' @export
#'
#' @author Joshua W. Lambert, Pedro Neves
calc_bic <- function(results, m) {
  k <- results$df
  bic <- k * (log(m) + log(2 * pi)) - 2 * results$loglik
}
