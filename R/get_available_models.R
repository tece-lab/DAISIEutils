#' List all available models
#'
#' @return A character vector with the named codes for all available models.
#' @keywords internal
#'
#' @author Pedro Santos Neves
#'
#' @examples
#' available_models <- DAISIEutils:::get_available_models()
get_available_models <- function() {
  available_models <- c(
    "cr_dd", "cr_di", "cr_dd_0laa", "cr_di_0laa",
    "cr_di_0lac", "cr_dd_0lac", "rr_lac_di",
    "rr_lac_dd", "rr_mu_di", "rr_mu_dd", "rr_k",
    "rr_gam_di", "rr_gam_dd",
    "rr_laa_di", "rr_laa_dd", "rr_mu_di_0lac",
    "rr_mu_dd_0lac", "rr_k_0lac",
    "rr_gam_di_0lac", "rr_gam_dd_0lac",
    "rr_laa_di_0lac", "rr_laa_dd_0lac", "rr_lac_di_0laa",
    "rr_lac_dd_0laa", "rr_mu_di_0laa", "rr_mu_dd_0laa",
    "rr_k_0laa", "rr_gam_di_0laa", "rr_gam_dd_0laa",
    "nonoceanic_cr_dd", "nonoceanic_cr_di",
    "nonoceanic_cr_dd_0laa", "nonoceanic_cr_di_0laa",
    "nonoceanic_cr_di_0lac", "nonoceanic_cr_dd_0lac",
    "cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k",
    "cr_dd_2type_lac_mu", "cr_dd_2type_lac_k", "cr_dd_2type_mu_k",
    "cr_dd_2type_lac_mu_k"
  )
  available_models
}
