#' Creates model output file path
#'
#' @inheritParams default_params_doc
#'
#' @return Returns string with path for output object. File path returned
#' depends on whether it is called from a cluster or from another environment,
#' the file path depends on `output_folder` argument.
#' @export
#'
#' @examples
#' \dontrun{
#' # saving on home
#' create_file_path(
#'   output_folder = "results",
#'   data_name = "results_folder",
#'   model = "cr_dd",
#'   array_index = 1,
#'   cluster_dir = Sys.getenv("HOME")
#' )
#' # saving on data
#' create_file_path(
#'   output_folder = "results",
#'   data_name = "results_folder",
#'   model = "cr_dd",
#'   array_index = 1,
#'   cluster_dir = Sys.getenv("USER"), "data")
#' )
#' }
create_file_path <- function(output_folder,
                             data_name,
                             model,
                             array_index,
                             cluster_dir = Sys.getenv("HOME")) {

  if (is_on_cluster()) {
    output_file_path <- file.path(
      cluster_dir, output_folder,
      paste0(data_name, "_", model, "_", array_index, ".rds")
    )
  } else {
    if (is.na(model) || is.na(array_index)) {
      output_file_path <- file.path(output_folder, paste0(data_name, ".rds"))
    } else {
      output_file_path <- file.path(
        output_folder,
        paste0(data_name, "_", model, "_", array_index, ".rds")
      )
    }
  }
  return(output_file_path)
}

