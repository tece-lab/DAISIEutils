#' Calculates summary metrics from a simulation
#'
#' @inheritParams default_params_doc
#'
#' @return List of simulation metrics
#' @export
#' @author Joshua W. Lambert
calc_sim_metrics <- function(daisie_data) {


  number_colonists <- c()
  number_spec <- c()
  number_stac0 <- c()
  number_stac1 <- c()
  number_stac2 <- c()
  number_stac3 <- c()
  number_stac4 <- c()
  number_stac2_singletons <- c()
  size_largest_clade <- c()
  size_smallest_clade <- c()
  rank_largest_clade <- c()

  for (i in seq_along(daisie_data)) {
    sim_rep <- daisie_data[[i]]
    number_colonists <- c(number_colonists, length(sim_rep) - 1)
    number_stac0 <- c(number_stac0, sim_rep[[1]]$not_present)

    num_spec <- c()
    col_time <- c()

    stacs <- lapply(sim_rep, "[[", "stac")

    for (j in 2:length(sim_rep)) {
      if (stacs[j] != 3) {
        num_spec <- c(num_spec, length(sim_rep[[j]]$branching_times) - 1)
        col_time <- c(col_time, sim_rep[[j]]$branching_times[2])
      } else {
        for (k in seq_along(sim_rep[[j]]$all_colonisations)) {
          num_spec <- c(
            num_spec,
            length(sim_rep[[j]]$all_colonisations[[k]]$event_times) - 1)
          col_time <- c(
            col_time,
            sim_rep[[j]]$all_colonisations[[k]]$event_times[2])
        }
      }
    }
    sorted_col_time <- sort(col_time, decreasing = TRUE)
    rank_largest_clade <- c(
      rank_largest_clade,
      which(sorted_col_time == col_time[which.max(num_spec)])
    )
    number_spec <- c(number_spec, sum(num_spec))
    stacs_vec <- unlist(stacs)
    number_stac1 <- c(number_stac1, length(which(stacs_vec == 1)))
    number_stac2 <- c(number_stac2, length(which(stacs_vec == 2)))
    number_stac3 <- c(number_stac3, length(which(stacs_vec == 3)))
    number_stac4 <- c(number_stac4, length(which(stacs_vec == 4)))

    branching_times <- lapply(sim_rep, "[[", "branching_times")
    num_branching_times <- unlist(lapply(branching_times, length))
    num_singleton_endemic <- length(intersect(which(stacs_vec == 2),
                                              which(num_branching_times == 2)))
    number_stac2_singletons <- c(number_stac2_singletons, num_singleton_endemic)

    size_largest_clade <- c(size_largest_clade, max(num_spec))
    size_smallest_clade <- c(size_smallest_clade, min(num_spec))
  }

  tt <- matrix(ncol = 2, nrow = 5)
  tt[1:5, 1] <- 1:5
  tt[1:5, 2] <- graphics::hist(x = rank_largest_clade,
                    breaks = seq(0.5, max(rank_largest_clade) + 0.5, by = 1),
                    plot = FALSE)$density[1:5]


  sim_metrics <- list(number_colonists = number_colonists,
                      number_spec = number_spec,
                      number_stac0 = number_stac0,
                      number_stac1 = number_stac1,
                      number_stac2 = number_stac2,
                      number_stac3 = number_stac3,
                      number_stac4 = number_stac4,
                      number_stac2_singletons = number_stac2_singletons,
                      size_largest_clade = size_largest_clade,
                      size_smallest_clade = size_smallest_clade,
                      tt = tt)

  return(sim_metrics)
}
