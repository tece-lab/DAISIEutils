#' Saves the state of the RNG
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing, only saves the state of the RNG in the global environment
#' @export
#'
#' @examples
#' \dontrun{
#' save_seed()
#' }
#' @family seed
save_seed <- function(seed) {
  if (is_on_cluster()) {
    file_path <- file.path(
      Sys.getenv("HOME"), "results", "rng_state", "rng_state.rds"
    )
  } else {
    file_path <- file.path("results", "rng_state", "rng_state.rds")
  }

  rng_state <- list(
    random_seed = .Random.seed,
    seed = seed
  )

  saveRDS(rng_state, file = file_path)
}
