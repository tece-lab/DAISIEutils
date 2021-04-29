#' Checks if jobs were run with the same seed on older logs
#'
#' Checks every log file inside a folder for the record of the used seed and
#' returns duplicated seeds and corresponding job arrays.
#'
#' @inheritParams default_params_doc
#'
#' @return A named list with two elements.
#'   * `duplicated_seeds`: A character vector with the seed values that were
#'   found to be duplicated within the folder. Will be empty if no duplicates
#'   were found
#'   * `duplicated_array_indices`: A numeric vector with corresponding array
#'   indices. Will be empty if no duplicates were found.
#' @export
#' @author Pedro Neves
#'
#' @note
#' In this function, the lines containing the scraped values can be anywhere in
#' each file, as this occurred in older versions of the package. Checking is
#' thus less efficient and preference should be given to
#' [check_repeated_seeds()] in most cases, unless older log files are being
#' checked. [check_repeated_seeds()] will fail for most older log files.
#'
#' @seealso [check_repeated_seeds()] for optimized checks on current logs.
#'
#' @examples
#' \dontrun{
#' repeated_seeds <- check_repeated_seeds_long(logs_path = "/logs/")
#' }
check_repeated_seeds_long <- function(logs_path) {
  message("Use check_repeated_seeds_long() instead if checking logs generated
          by current versions of DAISIEutils")
  testit::assert(fact = "Folder exists", dir.exists(logs_path))

  logfiles <- list.files(logs_path, full.names = TRUE)
  testit::assert(fact = "Folder has logfiles", length(logfiles) >= 1)

  logs <- lapply(logfiles, readLines)

  array_indices <- c()
  seeds <- c()
  for (i in seq_along(logs)) {
    array_line <- logs[[i]][grepl("Running analysis with array", logs[[i]])]
    seed_line <- logs[[i]][grepl("Running analysis with seed", logs[[i]])]

    array_indices[i] <- sub(".*: ", "", array_line)
    seeds[i] <- sub(".*: ", "", seed_line)
  }

  duplicated_seeds <- seeds[duplicated(seeds)]
  duplicated_seed_indices <- which(duplicated(seeds))
  duplicated_array_indices <- array_indices[duplicated_seed_indices]

  return(list(
    duplicated_seeds = duplicated_seeds,
    duplicated_array_indices = duplicated_array_indices
  ))
}
