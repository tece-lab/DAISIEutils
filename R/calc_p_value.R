#' Calculates p-value for rejecting a model from a distribution of likelihood
#' ratios
#'
#' @inheritParams default_params_doc
#'
#' @return
#' @export
#'
#' @examples
calc_p_value <- function(
  data
) {

  # load all from a data set

  # extract all the lik_ratio_0
  testit::assert(all(lik_ratio_0) == lik_ratio_0[1])
  testit::assert(is.numeric(lik_ratio_0))

  lik_ratio_0 <- "stub"
  # extract all the lik_ratio_1
  testit::assert(is.numeric(lik_ratio_model_1))

  lik_ratio_1 <- "stub"

  r_model_1 <- length(which(lik_ratio_1 > lik_ratio_0))
  p_value <- (r_model_1 + 1) / (length(lik_ratio_1) + 1)
  return(p_value)
}
