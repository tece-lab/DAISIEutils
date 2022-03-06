#' Compute loglikelihood for surface plot
#'
#' Computes likelihood values around a set of parameters `initparsopt` around
#' two axes (`param_1` and `param_2`). The loglikelihood is computed according
#' to specified model parameters. The results are then passed to
#' [plot_ll_surface] to produce the plot.
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame with 3 columns, the values of `param_1`, `param_2` and
#'   corresponding loglikelihood value.
#' @export
#'
#' @author Pedro Santos Neves
calc_ll_surface <- function(datalist,
                            initparsopt,
                            param_1,
                            param_2,
                            model,
                            range,
                            resolution) {
  testit::assert(model %in% get_available_models())
  model_setup <- setup_model(model)
  model_setup$initparsopt <- initparsopt

  testit::assert(param_1 %in% c("lac", "mu", "k", "gam", "laa"))
  testit::assert(param_2 %in% c("lac", "mu", "k", "gam", "laa"))

  # Setup pars2
  pars2 <- setup_std_pars2(
    ddmodel = 11,
    cond = 1,
    verbose = 0
  )
  param_1_index <- switch (param_1,
                           "lac" = 1,
                           "mu" = 2,
                           "k" = 3,
                           "gam" = 4,
                           "laa" = 5
  )

  param_2_index <- switch (param_2,
                           "lac" = 1,
                           "mu" = 2,
                           "k" = 3,
                           "gam" = 4,
                           "laa" = 5
  )

  # Setup along param_1
  param_1_range <- c(
    max(0, initparsopt[param_1_index] - range * initparsopt[param_1_index]),
    initparsopt[param_1_index],
    initparsopt[param_1_index] + range * initparsopt[param_1_index]
  )
  step_size_1 <- (param_1_range[2] - param_1_range[1]) / resolution
  param_1_vec <- seq(param_1_range[1], param_1_range[2], by = step_size_1)
  loglik_param_1 <- c()

  # Setup along param_2
  param_2_range <- c(
    max(0, initparsopt[param_2_index] - range * initparsopt[param_2_index]),
    initparsopt[param_2_index],
    initparsopt[param_2_index] + range * initparsopt[param_2_index]
  )
  step_size_2 <- (param_2_range[2] - param_2_range[1]) / resolution
  param_2_vec <- seq(param_2_range[1], param_2_range[2], by = step_size_2)
  loglik_param_2 <- c()

  testit::assert(identical(length(param_2_vec), length(param_1_vec)))
  data_to_plot <- data.frame(
    param_1 = numeric(),
    param_2 = numeric(),
    loglik = numeric()
  )
  for (i in param_1_vec) {
    for (j in param_2_vec) {
      parsopt <- model_setup$initparsopt
      parsopt[param_1_index] <- i
      parsopt[param_2_index] <- j
      loglik <- DAISIE:::DAISIE_loglik_all(
        datalist = datalist,
        pars1 = parsopt,
        pars2 = pars2,
        CS_version = model_setup$cs_version
      )

      data_to_plot <- rbind(data_to_plot, data.frame(
        param_1 = i,
        param_2 = j,
        loglik = loglik
      ))
    }
  }
  data_to_plot
}
