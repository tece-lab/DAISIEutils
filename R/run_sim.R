#' Runs a DAISIE simulation
#'
#' @inheritParams default_params_doc
#'
#' @return
#' @export
#'
#' @examples
run_sim <- function(
  data,
  model,
  lik_res,
  cond) {

  time <- data[[1]]$island_age
  m <- data[[1]]$not_present + (length(data) - 1)
  pars <- c(lik_res$lambda_c,
            lik_res$mu,
            lik_res$K,
            lik_res$gamma,
            lik_res$lambda_a)


  if (grepl("cr", model)) {
    sim <- DAISIE::DAISIE_sim_constant_rate(
      time = time,
      M = m,
      pars = pars,
      replicates = 1,
      cond = cond,
      plot_sims = FALSE)
  }

  if (grepl("rr", model)) {
    if (grepl("rr_lac", model)) {
      relaxed_par <- "cladogenesis"
    }
    if (grepl("rr_mu", model)) {
      relaxed_par <- "extinction"
    }
    if (grepl("rr_k", model)) {
      relaxed_par <- "carrying_capacity"
    }
    if (grepl("rr_laa", model)) {
      relaxed_par <- "anagenesis"
    }

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
