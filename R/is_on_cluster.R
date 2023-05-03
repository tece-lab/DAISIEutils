#' Check if code is running on Peregrine HPCC
#'
#' @return Boolean. `TRUE` if called from Hábrók HPCC, FALSE if not.
#' @export
#'
#' @examples
#' on_cluster <- is_on_cluster()
#'
#' @author Pedro Santos Neves
is_on_cluster <- function() {
  if (identical(Sys.getenv("SLURM_CLUSTER_NAME"), "habrok")) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
