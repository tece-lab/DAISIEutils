#' Reads `run_daisie_ml()` results
#'
#' @inheritParams default_params_doc
#'
#' @return Nested list. First layer corresponds to the data sets, as per the
#'   folders found in `results_root_folder`. The second layer corresponds to the
#'   models run for each dataset, each containing a 1 row long data frame with
#'   the of the alternate seed runs for each model.
#' @export
#'
#' @author Pedro Santos Neves
read_model_results <- function(results_root_folder) {
  testit::assert(
    "Root folder exists",
    dir.exists(results_root_folder)
  )

  data_sets <- list.dirs(
    path = results_root_folder,
    full.names = FALSE,
    recursive = FALSE
  )

  data_set_dirs <- list.dirs(
    path = results_root_folder,
    full.names = TRUE,
    recursive = FALSE
  )

  testit::assert(
    "Root folder is not empty",
    length(data_set_dirs) > 0
  )

  out_data_frame <- data.frame(
    "lambda_c" = numeric(),
    "mu" = numeric(),
    "K" = numeric(),
    "gamma" = numeric(),
    "lambda_a" = numeric(),
    "loglik" = numeric(),
    "df" = numeric(),
    "conv" = numeric(),
    "bic" = numeric()
  )
  out_list <- list()
  for (data_set in data_sets) {
    result_files <- list.files(
      path = data_set_dirs,
      pattern = data_set,
      full.names = TRUE
    )

    pattern <- paste(data_set, "\\s*(.*?)\\s*", "[1-9]", sep = "_")
    models <- unique(unlist(lapply(
      X = result_files,
      FUN = function(x) regmatches(x, regexec(pattern, x))[[1]][2]
    )))
    model_files_bools <- lapply(
      X = models,
      FUN = function(model) {
        grepl(
          pattern = paste(data_set, model, "[1-9]", sep = "_"),
          x = result_files
        )
      }
    )
    bool_indices <- unlist(lapply(model_files_bools, which))
    testit::assert(
      fact = "Models read without duplicates",
      all(!duplicated(bool_indices))
    )

    model_list <- list()
    for (i in seq_along(model_files_bools)) {
      model_runs <- lapply(
        X = result_files[model_files_bools[[i]]],
        FUN = readRDS
      )
      if (all(is.na(unlist(model_runs)))) {
        best_run <- rbind(out_data_frame, rep(NA, 9))
        colnames(best_run) <- c(
          "lambda_c",
          "mu",
          "K",
          "gamma",
          "lambda_a",
          "loglik",
          "df",
          "conv",
          "bic"
        )
      } else {
        best_run <- choose_best_model(model_runs)
      }
      model_list[[i]] <- best_run
      names(model_list)[i] <- models[i]
    }
    out_list[[data_set]] <- model_list
  }
  return(out_list)
}
