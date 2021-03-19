#' Load analysis result in txt format
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame with analysis results
#' @export
#'
#' @author Pedro Neves
load_txt_results <- function(results_root_folder) {
  subfolders <- dir(results_root_folder)

  output_df <- data.frame()
  for (subfolder in subfolders) {
    results_path <- file.path(results_root_folder, subfolder)
    files_to_load <- list.files(results_path)

    for (file_to_load in files_to_load) {
      loaded_df <- readr::read_tsv(
        file.path(results_path, file_to_load),
        col_names = TRUE,
        trim_ws = TRUE
      )
      output_df <- rbind(output_df, loaded_df)
    }
  }
  return(output_df)
}
