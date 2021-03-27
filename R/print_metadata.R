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
#'   model = cr_di,
#'   seed = 1
#' )
#' }
#' @author Pedro Neves, Luis Valente
#' @export
print_metadata <- function(
  data_name,
  model,
  seed) {
  testit::assert("data_name is character", is.character(data_name))

  print(sessioninfo::session_info())
  message(Sys.time())
  message("Data name: ", data)
  message("Model name: ", model)
  message("Running analysis with seed: ", seed)
}
