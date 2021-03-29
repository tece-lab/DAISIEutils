#' Checks if object is a [DAISIE] simulation data
#'
#' @inheritParams default_params_doc
#'
#' @return `TRUE` if `data` is a valid [DAISIE] object, `FALSE` if not.
#' @export
#' @author Pedro Neves, Richèl J. C. Bilderbeek
is_daisie_data <- function(data) {
  if (!is.list(data)) {
    return(FALSE)
  }

  # determine which type of DAISIE data it is either: single archipelago,
  # multi-archipelago, global, or simulation data

  if (is.null(names(data))) {
    if (length(data[[1]]) == 2) {

    }
    if (length(data[[1]]) == 3) {

    }
  } else {

  }


  first_element <- names(data[[1]])
  if (first_element == c("island_age", "not_present")) {
    # type 1
  }
  if (first_element == c("island_age",
                         "not_present_type1",
                         "not_present_type2")) {
    # type 2
  }
  if (first_element) {

  }


  first_element_lengths <- vapply(X = lapply(data, `[[`, 1),
                                  length,
                                  numeric(1))
  if (!all(first_element_lengths == 3)) {
    return(FALSE)
  }

  first_element_names <- unlist(lapply(X = lapply(data, `[[`, 1),
                                       FUN = names))
  first_expected_names <- c("island_age", "not_present", "stt_all")
  if (!all(first_element_names %in% first_expected_names)) {
    return(FALSE)
  }

  # TODO: Finish this function, test subsequent elements of list after metada.
  # stt_tables <- lapply(
  #   lapply(data, `[[`, 1),
  #   FUN = function(x) x$stt_all) nolint
  # n_extant_species <- lapply(stt_tables, function(x) sum(x[nrow(x), ])) nolint
  # have_extant_species <- which(n_extant_species != 0) nolint
  #   second_expected_names <- c(
  #   "branching_times",
  #   "stac",
  #   "missing_species"
  # ) nolint
  }
