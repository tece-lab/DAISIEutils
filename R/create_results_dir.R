#' Create results directory path
#'
#' @inheritParams default_params_doc
#'
#' @return String with platform appropriate file path to be used for the results
#' directory for a given data set.
#' @export
#' @author Pedro Santos Neves
#'
#' @examples results_dir_path <- create_results_dir_path(data_name = "Azores")
create_results_dir_path <- function(data_name, results_dir = NULL) {
  if (!is.null(results_dir)) {
    output_folder <- file.path(
      results_dir,
      data_name
    )
  } else {
    if (is_on_cluster()) {
      output_folder <- file.path(
        Sys.getenv("HOME"), "results", data_name
      )
    } else {
      output_folder <- file.path("results", data_name)
    }
  }
  output_folder
}
