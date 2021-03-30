#' Calculates power to detect the true model
#'
#' @inheritParams default_params_doc
#'
#' @return
#' @export
#'
#' @examples
calc_power <- function(
  data
) {

  # extract lik_ratio_1

  # calculate lik_ratio_alpha

  # extract lik_ratio_2

  testit::assert(is.numeric(lik_ratio_alpha))
  testit::assert(is.numeric(lik_ratio_model_2))
  r_model_2 <- length(which(lik_ratio_model_2 > lik_ratio_alpha))
  power <- r_model_2 / (length(lik_ratio_model_2) + 1)
  return(power)
}
