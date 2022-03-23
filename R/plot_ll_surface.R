#' Plot contour of loglikelihood surface around a given value
#'
#' Plots the likelihood surface around a set of parameters `initparsopt` around
#' two axes (`param_1` and `param_2`).
#'
#' @inheritParams default_params_doc
#'
#' @return A contour ggplot with the likelihood surface.
#' @export
#'
#' @author Pedro Santos Neves
plot_ll_surface <- function(data_to_plot, param_1, param_2) {


  p <- ggplot2::ggplot(
    data = data_to_plot,
    ggplot2::aes(param_1, param_2, z = loglik)) +
    ggplot2::geom_contour_filled()
  p
}
