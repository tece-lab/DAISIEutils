#' Calculates power to detect the true model
#'
#' @inheritParams default_params_doc
#'
#' @return
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


  files <- list.files(path = output_folder, full.names = TRUE)
  boot_files <- files[which(grepl("boot", files))]
  list_res <- lapply(files, readRDS)


  # extract lik_ratio_1
  lik_ratio_1 <- unlist(lapply(list_res, '[[', 7))
  testit::assert(is.numeric(lik_ratio_1))


  # calculate lik_ratio_alpha
  testit::assert(is.numeric(lik_ratio_alpha))

  # extract lik_ratio_2

  lik_ratio_2 <- unlist(lapply(list_res, '[[', 10))
  testit::assert(is.numeric(lik_ratio_2))

  r_model_2 <- length(which(lik_ratio_model_2 > lik_ratio_alpha))
  power <- r_model_2 / (length(lik_ratio_model_2) + 1)
  return(power)
}
