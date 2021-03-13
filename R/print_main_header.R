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
#' print_main_header(
#'   run_name = "example_name",
#'   M = 165,
#'   metadata = 1
#' )
#' }
#' @author Pedro Neves, Luis Valente
#' @export
print_main_header <- function(run_name, m, metadata) {
  testit::assert("m is numeric & finite", is.numeric(m) && is.finite(m))
  testit::assert("m is positive", m > 0)
  testit::assert("run_name is character", is.character(run_name))

  print(sessioninfo::session_info())
  message(Sys.time())

  message("Run name: ", run_name)
  message("m: ", m)
  message("metadata: ", metadata)
}
