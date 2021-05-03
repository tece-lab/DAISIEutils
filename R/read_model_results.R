#' Reads `run_daisie_ml()` results
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame with all the results obtained
#' @export
#'
#' @author Pedro Neves
read_model_results <- function(results_root_folder) {
  tesit::assert(
    "Root folder exists",
    dir.exists(results_root_folder)
  )

  data_sets <- list.dirs(
    path = results_root_folder,
    full.names = FALSE,
    recursive = FALSE
  )

  data_set_dirs <- list.dirs(
    path = results_root_folder,
    full.names = TRUE,
    recursive = FALSE
  )

  testit::assert(
    "Root folder is not empty",
    length(data_set_dirs) > 0
  )

  data_frame_template <- data.frame(
    "lambda_c" = numeric(),
    "mu" = numeric(),
    "K" = numeric(),
    "gamma" = numeric(),
    "lambda_a" = numeric(),
    "loglik" = numeric(),
    "df" = numeric(),
    "conv" = numeric(),
    "bic" = numeric()
  )

  for (data_set in data_sets) {
    result_files <- list.files(
      path = data_set_dirs,
      pattern = data_set,
      full.names = TRUE
    )
    lapply(X = result_files, FUN = readRDS, "]]")
    data_set_template <-
    assign(x = data_set, data_frame_template)
  }

}
