#' Default parameters documentation
#'
#' @param model A string with model that should run. Models are as follows:
#'   * `"cr_dd"` Clade specific model - diversity dependent. All parameters
#'     free.
#'   * `"cr_di"` Clade specific model - diversity independent (K = Inf). All
#'     other parameters free.
#'   * `"cr_dd_0laa"` Clade specific model - diversity dependent and no
#'     anagenesis (laa fixed to zero). All other parameters free.
#'   * `"cr_di_0laa"` Clade specific model - diversity independent (K = Inf) and
#'     no anagenesis (laa fixed to zero). All other parameters free.
#' @param r_lamc Numeric. Uniformly sampled value of cladogenesis rate.
#' @param r_mu Numeric. Uniformly sampled value of extinction rate.
#' @param r_k Numeric. Uniformly sampled value of carrying capacity.
#' @param r_gam Numeric. Uniformly sampled value of immigration rate.
#' @param r_ana Numeric. Uniformly sampled value of anagenesis rate.
#' @param data_name String. Will be used for the name of the created output
#'   folder.
#' @param results_root_folder Character. A path to the root folder containing
#'   subfolders. Each subfolder contains result files for analysis runs.
#' @param data A list, conforming to the [`DAISIE`] object format. Usually
#'   preprocessed by [DAISIE::DAISIE_dataprep()], see it's documentation for
#'   details. Otherwise it may be generated via simulations, using
#'   [DAISIE::DAISIE_sim_constant_rate()] and friends.
#' @param datalist_name A character vector with the name of the datalist that
#'   is the analyses run on. It is required internally so that it can be stored
#'   in the first column of the output file.
#' @param seed A single numeric to be used as seed.
#' @param file_path The system directory where the output files will be stored.
#' @param results A tibble contaning model results as read by
#'   [load_txt_results()]. These results are themselves created and saved as
#'   text files by [run_analysis()] and friends.
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(model,
                               r_lamc,
                               r_mu,
                               r_k,
                               r_gam,
                               r_ana,
                               data_name,
                               results_root_folder,
                               data,
                               seed,
                               file_path,
                               results) {
  # Nothing
}
