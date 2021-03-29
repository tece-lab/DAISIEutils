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
#'   * `"cr_di_0lamc"` Clade specific model - diversity indendent (K = Inf)
#'     and no cladogenesis (lamc fixed to zero). All other parameters free.
#'   * `"cr_dd_0lamc"` Clade specific model - diversity dependent and no
#'     cladogenesis (lamc fixed to zero). All other parameters free.
#'   * `"rr_lamc_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed cladogenesis. All other parameters free.
#'   * `"rr_lamc_dd"` Clade specific model - diversity dependent and relaxed
#'     cladogenesis. All other parameters free.
#'   * `"rr_mu_di"` Clade specific model - diversity independent (K = Inf) and
#'     relaxed extinction. All other parameters free.
#'   * `"rr_mu_dd"` Clade specific model - diversity dependent and relaxed
#'     extinction. All other parameters free.
#'   * `"rr_k"` Clade specific model - diversity dependent and relaxed carrying
#'     capacity. All other parameters free.
#'   * `"rr_lama_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed anagenesis. All other parameters free.
#'   * `"rr_lama_dd"` Clade specific model - diversity dependent and relaxed
#'     anagenesis. All other parameters free.
#'   * `"rr_mu_di_0lamc"` Clade specific model - diversity independent,
#'     relaxed extinction, and no cladogenesis (lamc fixed to zero). All other
#'     parameters free.
#'   * `"rr_mu_dd_0lamc"` Clade specific model - diversity dependent,
#'   * `"rr_k_0lamc"` Clade specific model - diversity dependent,
#'   * `"rr_lama_di_0lamc"` Clade specific model - diversity independent
#'   * `"r_lama_dd_0lamc"` Clade specific model - diversity dependent
#'   * `"rr_lamc_di_0lama"` Clade specific model - diversity independent
#'   * `"rr_lamc_dd_0lama"` Clade specific model - diversity dependent
#'   * `"rr_mu_di_0lama"` Clade specific model - diversity independent
#'   * `"rr_mu_dd_0lama"` Clade specific model - diversity dependent
#'   * `"rr_k_0lama"` Clade specific model - diversity dependent
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
