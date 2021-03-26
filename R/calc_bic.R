#' Compute Bayesian Information Criterion of a model
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric value with BIC
#' @export
#'
#' @author Joshua W. Lambert, Pedro Neves
calc_bic <- function(results, data) {
  k <- results$df
  m <- data$not_present + length(data) - 1
  bic <- k * (log(m) + log(2 * pi)) - 2 * results$loglik
  bic
}
