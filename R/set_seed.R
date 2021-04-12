#' Sets seed using current system time.
#'
#' @return Nothing, system time and `.GlobalEnv$.Random.seed` to `.rds` file.
#' @export
#'
#' @examples
set_seed <- function() {
  seed <- as.numeric(Sys.time())

  set.seed(
    seed,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  rng_state <- list(
    random_seed = .Random.seed,
    seed = seed
  )

  file.path <- create_output_folder(
    data_name = "rng_state",
    model = NA,
    seed = NA
  )

  saveRDS(
    rng_state,
    file = file_path
  )

}
