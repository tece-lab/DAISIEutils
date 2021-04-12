#' Create model output folder
#'
#' @inheritParams default_params_doc
#'
#' @return Creates appropriate directory. Returns string with path for
#' output object. If on Peregrine, folder will be `$HOME/results/$output_name`.
#' If called from another environment, folder will be
#' `getwd()/results/$output_name`.
#' @export
#' @author Pedro Neves
#'
#' @examples
#' \dontrun{
#' create_output_folder(
#'   data_name = "results_folder",
#'   model = "cr_dd",
#'   rng_stream_index = 1
#' )
#' }
create_output_folder <- function(data_name, model, rng_stream_index) {

  if (is_on_cluster()) {
    output_folder <- file.path(
      Sys.getenv("HOME"), "results", data_name
    )
  } else {
    output_folder <- file.path("results", data_name)
  }

  if (!dir.exists(output_folder)) {
    message(output_folder, " not found, creating it.")
    dir.create(path = output_folder, recursive = TRUE)
  }
  testit::assert(
    "output folder exists",
    dir.exists(output_folder)
  )

  if (is.na(model) || is.na(seed)) {
    file_path <- file.path(
      output_folder,
      paste0(data_name, ".rds")
    )
  } else {
    file_path <- file.path(
      output_folder,
      paste0(data_name, "_", model, "_", seed, ".rds")
    )
  }

  return(file_path)
}
