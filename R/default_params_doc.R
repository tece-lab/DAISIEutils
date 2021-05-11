#' Default parameters documentation
#'
#' @param model A string with model that should run. Models are as follows:
#'   * `"cr_dd"` Clade specific model - diversity dependent. All parameters
#'     free.
#'   * `"cr_di"` Clade specific model - diversity independent (K = Inf). All
#'     other parameters free.
#'   * `"cr_dd_0laa"` Clade specific model - diversity dependent and no
#'     anagenesis (laa fixed to zero). All other parameters free.
#'   * `"cr_di_0laa"` Clade specific model - diversity independent (K = Inf)
#'     and no anagenesis (laa fixed to zero). All other parameters free.
#'   * `"cr_di_0lac"` Clade specific model - diversity indendent (K = Inf)
#'     and no cladogenesis (lac fixed to zero). All other parameters free.
#'   * `"cr_dd_0lac"` Clade specific model - diversity dependent and no
#'     cladogenesis (lac fixed to zero). All other parameters free.
#'   * `"rr_lac_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed cladogenesis. All other parameters free.
#'   * `"rr_lac_dd"` Clade specific model - diversity dependent and relaxed
#'     cladogenesis. All other parameters free.
#'   * `"rr_mu_di"` Clade specific model - diversity independent (K = Inf) and
#'     relaxed extinction. All other parameters free.
#'   * `"rr_mu_dd"` Clade specific model - diversity dependent and relaxed
#'     extinction. All other parameters free.
#'   * `"rr_k"` Clade specific model - diversity dependent and relaxed carrying
#'     capacity. All other parameters free.
#'   * `"rr_laa_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed anagenesis. All other parameters free.
#'   * `"rr_laa_dd"` Clade specific model - diversity dependent and relaxed
#'     anagenesis. All other parameters free.
#'   * `"rr_mu_di_0lac"` Clade specific model - diversity independent,
#'     relaxed extinction, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_mu_dd_0lac"` Clade specific model - diversity dependent, relaxed
#'     extinction, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_k_0lac"` Clade specific model - diversity dependent, relaxed
#'     carrying capacity, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_laa_di_0lac"` Clade specific model - diversity independent,
#'     relaxed anagenesis, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"r_laa_dd_0lac"` Clade specific model - diversity dependent, relaxed
#'     anagenesis, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_lac_di_0laa"` Clade specific model - diversity independent,
#'     relaxed cladogenesis, and no anagenesis (laa fixed to zero)
#'   * `"rr_lac_dd_0laa"` Clade specific model - diversity dependent
#'   * `"rr_mu_di_0laa"` Clade specific model - diversity independent
#'   * `"rr_mu_dd_0laa"` Clade specific model - diversity dependent
#'   * `"rr_k_0laa"` Clade specific model - diversity dependent
#' @param data_name String. Will be used for the name of the created output
#'   folder.
#' @param results_root_folder Character. A path to the root folder containing
#'   subfolders. Each subfolder contains result files for analysis runs.
#' @param data A list, conforming to the [`DAISIE`] object format. Usually
#'   preprocessed by [DAISIE::DAISIE_dataprep()], see it's documentation for
#'   details. Otherwise it may be generated via simulations, using
#'   [DAISIE::DAISIE_sim_constant_rate()] and friends.
#' @param array_index A single numeric with the array index. It is used for
#'   naming the output file.
#' @param file_path The system directory where the output files will be stored.
#' @param results A data frame containing model results as created by
#'   [run_daisie_ml()]. These results are the [DAISIE::DAISIE_ML_CS()] and the
#'   bic, and they're saved as an RDS file by [run_daisie_ml()].
#' @param cond An integer specifying conditioning, as described in
#'   [DAISIE::DAISIE_ML_CS()].
#' @param model_1 A string with model that should run. For a list of options
#'   see documentation for \code{model} parameter in [run_daisie_ml()].
#' @param model_2 A string with model that should run. For a list of options
#'   see documentation for \code{model} parameter in [run_daisie_ml()].
#' @param model_1_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param model_2_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param model_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param lik_res A data frame with results from a DAISIE maximum likelihood
#'   model.
#' @param data_names A vector of strings with the names of the data sets you
#'   want to compare sensitivity.
#' @param full_output A boolean determining whether the full model output is
#'   returned.
#' @param seed Integer with value to be used as the seed for Mersenne-Twister.
#'   This value is determined by [Sys.time()] and `array_index` to ensure
#'   parallel jobs have different seeds. Only the last 6 digits of the
#'   [Sys.time()] (as an integer) are used.
#' @param test A boolean, defaults to `FALSE`. Set to `TRUE` for testing
#'   purposes, to fix the seed.
#' @param logs_path Character with path to the folder containing logs. Only log
#'   files should be present, in plain text format.
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(
  model,
  data_name,
  results_root_folder,
  data,
  array_index,
  file_path,
  results,
  cond,
  model_1,
  model_2,
  model_1_lik_res,
  model_2_lik_res,
  model_lik_res,
  lik_res,
  data_names,
  full_output,
  seed,
  test,
  logs_path) {
  # Nothing
}
