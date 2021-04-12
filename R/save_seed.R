#' Saves the state of the RNG
#'
#' @return Nothing, only saves the state of the RNG in the global environment
#' @export
#'
#' @examples
#' \dontrun{
#' save_seed()
#' }
#' @family seed
save_seed <- function() {
  if (is_on_cluster()) {
    file_path <- file.path(
      Sys.getenv("HOME"), "results", "rng_state"
    )
  } else {
    file_path <- file.path("results", "rng_state")
  }

  rng_state <- .GlobalEnv$.Random.seed
  saveRDS(rng_state, file = file_path)
}
