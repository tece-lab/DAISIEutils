#' Create model output folder
#'
#' @inheritParams default_params_doc
#'
#' @return
#' Creates appropriate directory. Returns string with path for output object. By
#' default, if on Peregrine, folder will be `$HOME/results/$data_name`. If
#' called from another environment, folder will be
#' `getwd()/results/$data_name`. Alternatively, another valid root can be
#' specified, resulting in `results_dir/$data_name`.
#' @export
#' @author Pedro Santos Neves
#'
#' @examples
#' \dontrun{
#' create_output_folder(
#'   data_name = "results_folder"
#' )
#' }
create_output_folder <- function(data_name,
                                 results_dir = NULL) {

  output_folder <- create_results_dir_path(results_dir)

  if (!dir.exists(output_folder)) {
    message(output_folder, " not found, creating it.")
    dir.create(path = output_folder, recursive = TRUE)
  }
  testit::assert(
    "output folder exists",
    dir.exists(output_folder)
  )

  return(output_folder)
}
