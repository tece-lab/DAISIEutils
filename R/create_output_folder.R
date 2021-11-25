#' Create model output folder
#'
#' @inheritParams default_params_doc
#'
#' @return Void function, it creates appropriate directory.
#' @export
#' @author Pedro Neves
#'
#' @examples
#' \dontrun{
#' # creating folder on home
#' create_output_folder(
#'   output_folder = "results",
#'   cluster_dir = Sys.getenv("HOME")
#' )
#' # creating folder on data
#' create_output_folder(
#'   output_folder = "results",
#'   cluster_dir = Sys.getenv("USER", "data")
#' )
#' }
create_output_folder <- function(
  output_folder,
  cluster_dir) {

  if (is_on_cluster()) {
    output_file_path <- file.path(
     cluster_dir, output_folder
    )
  } else {
    output_file_path <- file.path(output_folder)
  }

  if (!dir.exists(output_folder)) {
    message(output_folder, " not found, creating it.")
    dir.create(path = output_folder, recursive = TRUE)
  }
  testit::assert(
    "output folder exists",
    dir.exists(output_folder)
  )
}
