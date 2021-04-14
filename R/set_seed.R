#' Sets seed using current system time.
#'
#' @return Nothing, system time and `.GlobalEnv$.Random.seed` to `.rds` file.
#' @export
#'
#' @examples \dontrun{set_seed()}
#' @family seed
set_seed <- function() {
  seed <- as.numeric(Sys.time())

  set.seed(
    seed,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  rng_state <- list(
    random_seed = .GlobalEnv$.Random.seed,
    seed = seed
  )

  file_path <- create_output_folder(
    data_name = "rng_state",
    model = NA,
    rng_stream_index = NA
  )

  saveRDS(
    rng_state,
    file = file_path
  )

}
