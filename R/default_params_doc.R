#' Default parameters documentation
#'
#' @param run_name Character with name of run to be printed. Can be anything,
#'   altough it is useful to name it after the dataset that is being analysed or
#'   generated.
#' @param m Positive numeric integer with mainland species number.
#' @param metadata A numeric or a string. To be improved to take more info.
#' @param model Numeric integer from 1 to 4 with model that should run. Models
#'   are as follows:
#'  1. Clade specific model - diversity dependent. All parameters free.
#'  2. Clade specific model - diversity independent (K = Inf). All other
#'     parameters free.
#'  3. Clade specific model - diversity dependent and no anagenesis (laa fixed
#'     to zero). All other parameters free.
#'  4. Clade specific model - diversity independent (K = Inf) and no
#'     anagenesis (laa fixed to zero). All other parameters free.
#' @param r_lamc Numeric. Uniformly sampled value of cladogenesis rate.
#' @param r_mu Numeric. Uniformly sampled value of extinction rate.
#' @param r_k Numeric. Uniformly sampled value of carrying capacity.
#' @param r_gam Numeric. Uniformly sampled value of immigration rate.
#' @param r_ana Numeric. Uniformly sampled value of anagenesis rate.
#' @param output_name A string. Will be the name of the created output folder.
#' @param verbose Boolean. Defaults to FALSE. If TRUE, session info and run.
#' @param results_root_folder Character. A path to the root folder containing
#'   subfolders. Each subfolder contains result files for analysis runs.
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(run_name,
                               m,
                               metadata,
                               model,
                               r_lamc,
                               r_mu,
                               r_k,
                               r_gam,
                               r_ana,
                               output_name,
                               verbose,
                               results_root_folder) {
  # Nothing
}
