sensitivity <- function(
  data_1,
  data_2) {
browser()
  data_name <- deparse(substitute(data))
  if (is_on_cluster()) {
    output_folder <- file.path(
      Sys.getenv("HOME"), "results", data_name
    )
  } else {
    output_folder <- file.path(getwd(), "results", data_name)
  }

  data_1_files <- list.files(
    path = output_folder,
    full.names = TRUE,
    pattern = paste0(model_1, "_[0-9].rds$"))
  model_1_lik_res <- lapply(model_1_files, readRDS) # nolint TODO: REMOVE

  data_2_files <- list.files(
    path = output_folder,
    full.names = TRUE,
    pattern = paste0(model_2, "_[0-9].rds$"))
  model_2_lik_res <- lapply(model_2_files, readRDS) # nolint TODO: REMOVE

  best_model_1 <- choose_best_model(model_1_lik_res) # nolint TODO: REMOVE
  best_model_2 <- choose_best_model(model_2_lik_res) # nolint TODO: REMOVE
  # rank models from each data set

  # compare ranks

  #

  # Take multiple data sets
  # Take a set of models
  # Fit the data sets to the models
  # Determine whether the best fit model is consistent
  # Determine whether the rank of the models fit is consistent
}
