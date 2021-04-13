#' Read the seed from a saved file
#'
#' @return Numeric vector with the state of the RNG
#' @export
#'
#' @examples
#' \dontrun{
#' read_seed()
#' }
#' @family seed
read_seed <- function() {
  if (is_on_cluster()) {
    file_path <- file.path(
      Sys.getenv("HOME"), "results", "rng_state", "rng_state.rds"
    )
  } else {
    file_path <- file.path("results", "rng_state", "rng_state.rds")
  }

  if (file.exists(file_path)) {
    rng_state <- readRDS(file = file_path)
  } else {
    stop("First run DAISIEutils::set_seed to make a seed")
  }

  message("The system time that set the seed was: ", rng_state$seed)
  seed_stream <- rng_state$random_seed

  return(seed_stream)
}
