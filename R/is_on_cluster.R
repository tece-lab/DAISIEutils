#' Check if code is running on Peregrine HPCC
#'
#' @return Boolean. `TRUE` if called from Peregrine HPCC, FALSE if not.
#' @export
#'
#' @examples
#' on_cluster <- is_on_cluster()
#'
#' @author Pedro Neves
is_on_cluster <- function() {
  if (identical(Sys.getenv("HOSTNAME"), "peregrine.hpc.rug.nl")) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
