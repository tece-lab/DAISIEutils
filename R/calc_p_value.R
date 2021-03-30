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

  data_name <- deparse(substitute(data))
  if (is_on_cluster()) {
    output_folder <- file.path(
      Sys.getenv("HOME"), "results", data_name
    )
  } else {
    output_folder <- file.path(getwd(), "results", data_name)
  }
  # load all from a data set
  # make a list one RDS per element
  apply(readRDS, ) #TODO finish

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
