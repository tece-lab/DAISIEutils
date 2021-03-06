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
sensitivity <- function(
  data_names,
  full_output = FALSE) {

  best_models_list <- list()
  output <- list()
  for (i in seq_along(data_names)) {
    if (is_on_cluster()) {
      output_folder <- file.path(
        Sys.getenv("HOME"), "results", data_names[i]
      )
    } else {
      output_folder <- file.path(getwd(), "results", data_names[i])
    }
    expected_models <- c("cr_dd", "cr_di", "cr_dd_0laa", "cr_di_0laa",
                         "cr_di_0lac", "cr_dd_0lac", "rr_lac_di",
                         "rr_lac_dd", "rr_mu_di", "rr_mu_dd", "rr_k",
                         "rr_laa_di", "rr_laa_dd", "rr_mu_di_0lac",
                         "rr_mu_dd_0lac", "rr_k_0lac", "rr_laa_di_0lac",
                         "rr_laa_dd_0lac", "rr_lac_di_0laa",
                         "rr_lac_dd_0laa", "rr_mu_di_0laa", "rr_mu_dd_0laa",
                         "rr_k_0laa")

    best_models_list[[i]] <- list()
    list_names <- c()

    for (j in seq_along(expected_models)) {
      data_files <- list.files(
        path = output_folder,
        full.names = TRUE,
        pattern = paste0(expected_models[j], "_[0-9].rds$"))

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
      best_models_list[[data_name]], is.null)] <- NULL
  }

  ranked_models <- list()

  ranked_models <- lapply(best_models_list, function(x) {
    sort(sapply(x, `[[`, "bic"), decreasing = FALSE)
  })

  names_ranked_models <- lapply(ranked_models, names)

  name_best_fit_model <- unname(sapply(names_ranked_models, "[[", 1))

  sens_best_fit <- sapply(
    name_best_fit_model,
    identical,
    name_best_fit_model[1])

  if (all(sens_best_fit)) {
    output$best_fit_sensitivity <- "Best fit model is not sensitive to input"
  } else {
    output$best_fit_sensitivity <- "Best fit model is sensitive to input"
  }

  sens_model_select <- sapply(
    names_ranked_models,
    identical,
    names_ranked_models[[1]])

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
