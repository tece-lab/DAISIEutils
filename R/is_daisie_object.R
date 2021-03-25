#' Checks if object is a [DAISIE] simulation object
#'
#' @inheritParams default_params_doc
#'
#' @return `TRUE` if `data` is a valid [DAISIE] object, `FALSE` if not.
#' @author Pedro Neves, Richèl J. C. Bilderbeek
is_daisie_object <- function(data) {
  if (!is.list(data)) {
    return(FALSE)
  }

  first_element_lengths <- vapply(X = lapply(data, `[[`, 1), length, numeric(1))
  if (!all(first_element_lengths == 3)) {
    return(FALSE)
  }

  first_element_names <- unlist(lapply(X = lapply(data, `[[`, 1), FUN = names))
  first_expected_names <- c("island_age", "not_present", "stt_all")
  if (!all(first_element_names %in% expected_names)) {
    return(FALSE)
  }

  # stt_tables <- lapply(lapply(data, `[[`, 1), FUN = function(x) x$stt_all)
  # n_extant_species <- lapply(stt_tables, function(x) sum(x[nrow(x), ]))
  # have_extant_species <- which(n_extant_species != 0)
  # second_expected_names <- c("branching_times", "stac", "missing_species")




}

