#' Calculates power to detect the true model
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric power
#' @export
calc_power <- function(
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

  files <- list.files(path = output_folder, full.names = TRUE, pattern = "boot")
  if (length(files) == 0) {
    stop("There are no files found for this data set")
  }
  list_res <- lapply(files, readRDS)

  lik_ratio_1 <- unlist(lapply(list_res, '[[', 7))
  testit::assert(is.numeric(lik_ratio_1))

  # calculate lik_ratio_alpha
  lik_ratio_alpha = stats::quantile(lik_ratio_1, 0.95, type = 4)
  testit::assert(is.numeric(lik_ratio_alpha))

  lik_ratio_2 <- unlist(lapply(list_res, '[[', 11))
  testit::assert(is.numeric(lik_ratio_2))

  r_model_2 <- length(which(lik_ratio_2 > lik_ratio_alpha))
  power <- r_model_2 / (length(lik_ratio_2) + 1)
  return(power)
}
