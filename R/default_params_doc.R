#' Default parameters documentation
#'
#' @param model A string with model that should run. Models are as follows:
#'   * `"cr_dd"` Clade specific model - diversity dependent. All parameters
#'     free.
#'   * `"cr_di"` Clade specific model - diversity independent (K = Inf). All
#'     other parameters free.
#'   * `"cr_dd_0lama"` Clade specific model - diversity dependent and no
#'     anagenesis (lama fixed to zero). All other parameters free.
#'   * `"cr_di_0lama"` Clade specific model - diversity independent (K = Inf)
#'     and no anagenesis (lama fixed to zero). All other parameters free.
#' @param data_name String. Will be used for the name of the created output
#'   folder.
#' @param results_root_folder Character. A path to the root folder containing
#'   subfolders. Each subfolder contains result files for analysis runs.
#' @param data A list, conforming to the [`DAISIE`] object format. Usually
#'   preprocessed by [DAISIE::DAISIE_dataprep()], see it's documentation for
#'   details. Otherwise it may be generated via simulations, using
#'   [DAISIE::DAISIE_sim_constant_rate()] and friends.
#' @param seed A single numeric to be used as seed.
#' @param file_path The system directory where the output files will be stored.
#' @param results A data frame contaning model results as created by
#'   [run_analysis()]. These results are the [DAISIE::DAISIE_ML_CS()] and the
#'   bic, and they're saved as an RDS file by [run_analysis()].
#' @param cond An integer specfying conditioning, as described in
#'   [DAISIE::DAISIE_ML_CS()].
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(
  model,
  data_name,
  results_root_folder,
  data,
  seed,
  file_path,
  results,
  cond) {
  # Nothing
}
