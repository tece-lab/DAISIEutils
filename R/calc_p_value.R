#' Calculates p-value for rejecting a model from a distribution of likelihood
#' ratios
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric p-value
#' @export
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

  files <- list.files(
    path = output_folder,
    full.names = TRUE,
    pattern = "boot_lr"
  )
  if (length(files) == 0) {
    stop("No files found.")
  }
  if (length(files) != 1000 | length(files) != 5) {
    stop("1000 bootstrap results expected but only ", length(files), " found.")
  }
  list_res <- lapply(files, readRDS)

  lik_ratio_0 <- unlist(lapply(list_res, "[[", 3))
  testit::assert(is.numeric(lik_ratio_0))
  testit::assert(stats::var(lik_ratio_0, na.rm = TRUE) == 0)

  lik_ratio_1 <- unlist(lapply(list_res, "[[", 7))
  testit::assert(is.numeric(lik_ratio_1))

  r_model_1 <- length(which(lik_ratio_1 > lik_ratio_0))
  p_value <- (r_model_1 + 1) / (length(lik_ratio_1) + 1)
  return(p_value)
}
