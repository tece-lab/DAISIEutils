#' From multiple seeds, choose the best model fit
#'
#' @inheritParams default_params_doc
#'
#' @return A list of length one, with a data frame of 1 row containing the best
#'   estimated models from the given seeds, as determined by the loglik.
#' @export
#'
#' @author Pedro Neves
choose_best_model <- function(model_lik_res) {
  logliks <- unlist(lapply(X = model_lik_res, FUN = "[[", "loglik"))
  best_loglik_index <- which(logliks == max(logliks, na.rm = TRUE))
  best_model <- model_lik_res[best_loglik_index]
  testit::assert(length(best_model) == 1)

  return(best_model[[1]])
}
