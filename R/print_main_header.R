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
print_main_header <- function(run_name, M, metadata) {
  testit::assert("M is numeric & finite", is.numeric(M) && is.finite(M))
  testit::assert("M is positive", M > 0)
  testit::assert("run_name is character", is.character(run_name))

  print(sessioninfo::session_info())
  message(Sys.time())

  message("Run name: ", run_name)
  message("M: ", M)
  message("metadata: ", metadata)
}
