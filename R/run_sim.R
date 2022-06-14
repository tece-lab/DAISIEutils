#' Runs a DAISIE simulation
#'
#' @inheritParams default_params_doc
#'
#' @return List with output from [`DAISIE`] simulation
#' @export
run_sim <- function(
    daisie_data,
  model,
  lik_res,
  cond) {

  time <- daisie_data[[1]]$island_age
  m <- daisie_data[[1]]$not_present + (length(daisie_data) - 1)
  pars <- c(lik_res$lambda_c,
            lik_res$mu,
            lik_res$K,
            lik_res$gamma,
            lik_res$lambda_a)


  if (grepl("cr", model)) {
    sim <- DAISIE::DAISIE_sim_cr(
      time = time,
      M = m,
      pars = pars,
      replicates = 1,
      cond = cond,
      plot_sims = FALSE)
  } else if (grepl("rr", model)) {
    pars[6] <- lik_res$sd
    relaxed_par <- setup_model(model)$cs_version$relaxed_par

    sim <- DAISIE::DAISIE_sim_relaxed_rate(
      time = time,
      M = m,
      pars = pars,
      replicates = 1,
      relaxed_par = relaxed_par,
      cond = cond,
      plot_sims = FALSE)
  }
  return(sim)
}
