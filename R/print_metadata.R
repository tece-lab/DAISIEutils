#' Print session and run info to console/log file
#'
#' Useful to call as at the start of normal job scripts to  run on the cluster
#' so that metadata is recorded in the log files.
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing. Prints session and run info used by DAISIE to console.
#'
#' @note Message is used to print function arguments. To retain formatting,
#'   a simple `sessioninfo::session_info()` is used for session info, which uses
#'   print. Hence, `session_info()` will go on `stdout`, while the remaining
#'   output of this function will go to `stderr`.
#'
#' @examples
#' \dontrun{
#' print_metadata(
#'   data_name = "Galapagos_datalist",
#'   model = "cr_di",
#'   array_index = 1,
#'   seed = 1
#' )
#' }
#' @author Pedro Santos Neves, Luis Valente, Joshua W. Lambert
#' @export
print_metadata <- function(data_name,
                           model,
                           array_index,
                           seed,
                           methode,
                           optimmethod) {
  options(width = 150)
  testit::assert("data_name is character", is.character(data_name))
  message(
    "CAUTION: Do not submit jobs simultaneously to ensure different seeds."
  )
  message("Data name: ", data_name)
  message("Model name: ", model)
  message("Using ", methode, " for numerical integration.")
  message("Using the ", optimmethod, " optimisation algorithm.")
  message("Running analysis with array index: ", array_index)
  message("Running analysis with seed: ", seed)
  message("Start time: ", Sys.time())

  print(sessioninfo::session_info(pkgs = "DAISIEutils"))
  message("\n")
}
