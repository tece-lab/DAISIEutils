#' Read the results of [run_daisie_ml()] and compares model selection
#'
#' Reads the results of [run_daisie_ml()] and compares model selection to
#' determine sensitivity to different data input into the same model or set of
#' models. The [run_daisie_ml()] results are expected to be located
#' in sub folders within the `results/` folder in the current working directory.
#' These sub folders must have the same names as the elements of `data_names`.
#'
#'
#' @inheritParams default_params_doc
#'
#' @return
#' A list of 3 elements if `full_output` is `FALSE`, or of 4 elements if
#' `TRUE`. The elements are as follows:
#' \describe{
#'   \item{`best_fit_sensitivity`}{A character vector of length one, which
#'   reports whether the best fit model is sensitive to the input.}
#'   \item{`model_selection_sensitivity`}{A character vector of length one,
#'   which reports whether the rank (or order) of the model selection is
#'   sensitive to the input.}
#'   \item{`model_selection_rank`}{A named list of as many elements as the there
#'   are models in `data_names`. Each named list contains a sorted named vector
#'   with the corresponding BIC value of each fit model. The sort is always
#'   ascending.}
#'   \item{`full_output`}{Only returned if `full_output` is `TRUE`. A named list
#'   with a similar structure as `model_selection_rank`. Instead of named
#'   vectors with the BIC values, however, the full [run_daisie_ml()] data frame
#'   output is returned. This is a one row data frame, with the parameter
#'   estimates, degrees of freedom, convergence information and BIC value.}
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' sensitivity(
#'   data_names = c("Azores", "Azores_alt_m"),
#'   full_output = FALSE
#' )
#' }
#' @author Joshua W. Lambert
sensitivity <- function(data_names,
                        full_output = FALSE,
                        results_dir = NULL) {
  best_models_list <- list()
  output <- list()
  for (i in seq_along(data_names)) {
    results_folder <- create_results_dir_path(
      data_name = data_names[i],
      results_dir = results_dir
    )
    expected_models <- get_available_models()

    best_models_list[[i]] <- list()
    list_names <- c()

    for (j in seq_along(expected_models)) {
      data_files <- list.files(
        path = results_folder,
        full.names = TRUE,
        pattern = paste0(expected_models[j], "_[0-9].rds$"),
        recursive = TRUE
      )

      if (length(data_files) > 0) {
        data_lik_res <- lapply(data_files, readRDS)
        best_model <- choose_best_model(data_lik_res)
        best_models_list[[i]][[j]] <- best_model
        list_names[j] <- expected_models[j]
      }
    }
    names(best_models_list[[i]]) <- list_names
  }
  names(best_models_list) <- data_names

  for (data_name in data_names) {
    best_models_list[[data_name]][sapply(
      best_models_list[[data_name]], is.null
    )] <- NULL
  }

  ranked_models <- list()
  ranked_models <- lapply(best_models_list, function(x) {
    sort(sapply(x, `[[`, "bic"), decreasing = FALSE)
  })
  if (all(is.na(unlist(best_models_list)))) {
    return("No model converged")
  }

  names_ranked_models <- lapply(ranked_models, names)
  names_ranked_models <- lapply(names_ranked_models, function(x) {
    if (length(x) == 0) x <- "no_conv" else x <- x
  })
  name_best_fit_model <- unname(sapply(names_ranked_models, "[[", 1))

  sens_best_fit <- sapply(
    name_best_fit_model,
    identical,
    name_best_fit_model[1]
  )

  if (all(sens_best_fit)) {
    output$best_fit_sensitivity <- "Best fit model is not sensitive to input"
  } else {
    output$best_fit_sensitivity <- "Best fit model is sensitive to input"
  }

  sens_model_select <- sapply(
    names_ranked_models,
    identical,
    names_ranked_models[[1]]
  )

  if (all(sens_model_select)) {
    output$model_selection_sensitivity <-
      "Model selection rank is not sensitive to input"
  } else {
    output$model_selection_sensitivity <-
      "Model selection rank is sensitive to input"
  }

  output$model_selection_rank <- ranked_models

  if (full_output) {
    output$full_output <- best_models_list
  }
  return(output)
}
