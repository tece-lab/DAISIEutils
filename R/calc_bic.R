#' Compute Bayesian Information Criterion of a model
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric value with BIC
#' @export
#'
#' @author Joshua W. Lambert, Pedro Santos Neves
calc_bic <- function(results, daisie_data) {
  k <- results$df
  m <- daisie_data[[1]]$not_present + length(daisie_data) - 1
  bic <- k * (log(m) + log(2 * pi)) - 2 * results$loglik
  bic
}
