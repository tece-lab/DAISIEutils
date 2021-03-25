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
#' create_output_folder(output_name = "results_folder", model = 1)
#' }
create_output_folder <- function(output_name, model) {

  if (is_on_cluster()) {
    output_folder <- file.path(Sys.getenv("HOME"), "results", output_name)
  } else {
    output_folder <- file.path(getwd(), "results", output_name)
  }

  if (!dir.exists(output_folder)) {
    message(output_folder, " not found, creating it.")
    dir.create(path = output_folder, recursive = TRUE)
  }
  testit::assert(
    "output folder exists",
    dir.exists(output_folder)
  )
  file_path <- file.path(
    output_folder,
    paste0(output_name, "_", "m_", model, ".txt")
  )

  file_path
}
