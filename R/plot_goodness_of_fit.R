#' Computes summary results of bootstrap simulations useful for plotting
#'
#' The output is a list of results
#'
#' @inheritParams default_params_doc
#' @return overall_results a list of results
#' @author Rampal S. Etienne & Luis Valente
#' @export summarize_bootstrap_results
#' @examples
#' \dontrun{
#' clado_rate <- 0.5
#' ext_rate <- 0.2
#' carr_cap <- Inf
#' immig_rate <- 0.005
#' ana_rate <- 1
#' sim_pars <- c(clado_rate, ext_rate, carr_cap, immig_rate, ana_rate)
#' set.seed(1)
#'
#' dataset_cs <- DAISIE::DAISIE_sim_cr(
#'   time = 10,
#'   M = 1000,
#'   pars = sim_pars,
#'   replicates = 10,
#'   plot_sims = FALSE,
#'   verbose = FALSE,
#'   divdepmodel = "CS"
#' )
#'
#' dataset_iw <- DAISIE::DAISIE_sim_cr(
#'   time = 10,
#'   M = 1000,
#'   pars = sim_pars,
#'   replicates = 10,
#'   plot_sims = FALSE,
#'   verbose = FALSE,
#'   divdepmodel = "IW"
#' )
#' overall_results_cs <- DAISIEutils::summarize_bootstrap_results(
#'   daisie_data = dataset_cs
#' )
#' overall_results_iw <- DAISIEutils::summarize_bootstrap_results(
#'   daisie_data = dataset_iw
#' )
#' }
summarize_bootstrap_results <- function(daisie_data,
                                        mainland_n = 1000) {

  # Calculate overall species richness and colonization statistics across
  # all islands
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
    the_island <- daisie_data[[i]]
    number_colonists <- append(
      number_colonists,
      mainland_n - the_island[[1]]$not_present
    )
    number_stac0 <- append(number_stac0, the_island[[1]]$not_present)
    u_island <- unlist(the_island)

    if (the_island[[1]]$not_present == mainland_n) {
      number_spec <- append(number_spec, 0)
      number_stac1 <- append(number_stac1, 0)
      number_stac2 <- append(number_stac2, 0)
      number_stac3 <- append(number_stac3, 0)
      number_stac4 <- append(number_stac4, 0)
      number_stac2_singletons <- append(number_stac2_singletons, 0)
      size_largest_clade <- append(size_largest_clade, NA)
      size_smallest_clade <- append(size_smallest_clade, NA)
    } else {
      s <- NULL
      cc <- NULL
      for (j in 2:length(the_island)) {
        if (is.null(the_island[[j]]$all_colonisations)) {
          s <- c(s, length(the_island[[j]]$branching_times) - 1)
          cc <- c(cc, the_island[[j]]$branching_times[2])
        } else {
          for (k in seq_along(the_island[[j]]$all_colonisations)) {
            s <- c(
              s,
              length(the_island[[j]]$all_colonisations[[k]]$event_times) - 1
            )
            cc <- c(cc, the_island[[j]]$all_colonisations[[k]]$event_times[2])
          }
        }
      }
      scc <- sort(cc, decreasing = TRUE)
      rank_largest_clade <- c(
        rank_largest_clade,
        which(scc == cc[which.max(s)])
      )
      number_spec <- append(number_spec, sum(s))
      number_stac1 <- append(
        number_stac1,
        length(which(u_island[which(names(u_island) == "stac")] == 1))
      )
      number_stac2 <- append(
        number_stac2,
        length(which(u_island[which(names(u_island) == "stac")] == 2))
      )
      number_stac3 <- append(
        number_stac3,
        length(which(u_island[which(names(u_island) == "stac")] == 3))
      )
      number_stac4 <- append(
        number_stac4,
        length(which(u_island[which(names(u_island) == "stac")] == 4))
      )
      if (length(which(u_island[which(names(u_island) == "stac")] == 2)) > 0) {
        store_stac2s_brts <- list()
        store_all_brts <- list()
        for (isl in 2:length(the_island)) {
          if (the_island[[isl]]$stac == 2) {
            store_stac2s_brts[[length(store_stac2s_brts) + 1]] <-
              the_island[[isl]]$branching_times
          }
          store_all_brts[[length(store_all_brts) + 1]] <-
            the_island[[isl]]$branching_times
        }
        number_stac2_singletons <- append(
          number_stac2_singletons,
          length(which(unlist(lapply(store_stac2s_brts, length)) == 2))
        )
        size_largest_clade <- append(size_largest_clade, max(s))
        size_smallest_clade <- append(size_smallest_clade, min(s))
      } else {
        number_stac2_singletons <- append(number_stac2_singletons, 0)
        size_largest_clade <- append(size_largest_clade, NA)
        size_smallest_clade <- append(size_smallest_clade, NA)
      }
    }
  }

  the_prop <- c()
  the_prop_youngest <- c()

  datasets5 <- list()
  for (i in seq_along(daisie_data)) {
    if (length(daisie_data[[i]]) == 6) { #typo?
      pl <- length(datasets5) + 1
      datasets5[[pl]] <- daisie_data[[i]]
    }
  }

  for (i in seq_along(datasets5)) {
    island <- datasets5[[i]]
    if (length(island) == 1) {
      the_prop <- append(the_prop, 0)
      the_prop_youngest <- append(the_prop_youngest, 0)
    } else {
      island[[1]] <- NULL
      stac_vec <- unlist(island)[which(names(unlist(island)) == "stac")]
      stac_age_known <- which(stac_vec == 2 | stac_vec == 3 |  stac_vec == 4)
      btimes <- list()
      colonisation_time <- c()
      diversity <- c()
      for (o in seq_along(stac_age_known)) {
        btimes[[o]] <- island[[stac_age_known[o]]]$branching_times[-1]
        colonisation_time[o] <- max(btimes[[o]])
        diversity[o] <- length(btimes[[o]]) +
          island[[stac_age_known[o]]]$missing_species
      }

      seque <- cbind(colonisation_time, diversity)
      seque <- seque[rev(order(seque[, 1])), ]

      if (is.matrix(seque)) {
        the_prop <- append(the_prop, as.numeric(seque[1, 2] / sum(seque[, 2])))
        the_prop_youngest <- append(
          the_prop_youngest,
          as.numeric(seque[nrow(seque), 2] / sum(seque[, 2]))
        )
      }

      if (is.numeric(seque)) {
        the_prop <- append(the_prop, 1)
        the_prop_youngest <- append(the_prop_youngest, 1)
      }
    }
  }

  tt <- matrix(ncol = 2, nrow = 5)
  tt[1:5, 1] <- 1:5
  tt[1:5, 2] <- graphics::hist(x = rank_largest_clade,
                    breaks = seq(0.5, max(rank_largest_clade) + 0.5, by = 1),
                    plot = FALSE)$density[1:5]

  overall_results <- list(number_colonists = number_colonists,
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

  return(overall_results = overall_results)
}

#' Computes summary results of bootstrap simulations useful for plotting
#'
#' The output is a list of results
#'
#' @inheritParams default_params_doc
#'
#' @author Rampal S. Etienne & Luis Valente
#' @export
#' @examples
#' \dontrun{
#' clado_rate <- 0.5
#' ext_rate <- 0.2
#' carr_cap <- Inf
#' immig_rate <- 0.005
#' ana_rate <- 1
#' sim_pars <- c(clado_rate, ext_rate, carr_cap, immig_rate, ana_rate)
#' set.seed(1)
#'
#' dataset_cs <- DAISIE::DAISIE_sim_cr(
#'   time = 10,
#'   M = 1000,
#'   pars = sim_pars,
#'   replicates = 10,
#'   plot_sims = FALSE,
#'   verbose = FALSE,
#'   divdepmodel = "CS"
#' )
#'
#' dataset_iw <- DAISIE::DAISIE_sim_cr(
#'   time = 10,
#'   M = 1000,
#'   pars = sim_pars,
#'   replicates = 10,
#'   plot_sims = FALSE,
#'   verbose = FALSE,
#'   divdepmodel = "IW"
#' )
#' overall_results_cs <- DAISIEutils::summarize_bootstrap_results(
#'   daisie_data = dataset_cs
#' )
#' overall_results_iw <- DAISIEutils::summarize_bootstrap_results(
#'   daisie_data = dataset_iw
#' )
#' par(mfrow = c(2, 4), cex.lab = 1.5, cex.main = 1.5)
#' DAISIEutils::plot_bootstrap_results(
#'   overall_results = overall_results_cs,
#'   title = "Simulated under CS"
#' )
#' DAISIEutils::plot_bootstrap_results(
#'   overall_results = overall_results_iw,
#'   title = "Simulated under IW"
#' )
#' }
plot_bootstrap_results <- function(overall_results,
                                   sumstats = c(65, 5, 28, 1),
                                   ylim4 = 0.7,
                                   title = NULL) {
  graphics::hist(
    x = overall_results$number_spec,
    xlab = "Number of species",
    breaks = 30,
    freq = FALSE,
    bty = "n",
    col = "cornsilk3",
    border = "cornsilk3",
    main = title
  )
  graphics::abline(
    v = stats::median(overall_results$number_spec),
    col = "black",
    lwd = 2
  )
  graphics::arrows(
    sumstats[1],
    1,
    sumstats[1],
    0,
    col = "blue",
    length = 0.07,
    lwd = 1.5
  )

  ### Colonizations
  graphics::hist(
    x = overall_results$number_colonists,
    col = "cornsilk3",
    border = "cornsilk3",
    main = NULL,
    breaks = 10,
    freq = FALSE,
    xlab = "Number of colonization events"
  )
  graphics::abline(
    v = stats::median(overall_results$number_colonists, na.rm = T),
    col = "black",
    lwd = 2
  )
  graphics::arrows(
    sumstats[2],
    1,
    sumstats[2],
    0,
    col = "blue",
    length = 0.07,
    lwd = 1.5
  )

  ##### size largest clade
  graphics::hist(
    x = overall_results$size_largest_clade,
    col = "cornsilk3",
    border = "cornsilk3",
    main = NULL,
    breaks = 30,
    freq = FALSE,
    xlab = "Size largest clade"
  )
  graphics::abline(
    v = stats::median(overall_results$size_largest_clade, na.rm = T),
    col = "black",
    lwd = 2
  )
  graphics::arrows(
    sumstats[3],
    1,
    sumstats[3],
    0,
    col = "blue",
    length = 0.07,
    lwd = 1.5
  )

  bar_colors <- rep("cornsilk3", 5)
  bar_colors[sumstats[4]] <- "blue"
  graphics::barplot(height = overall_results$tt[, 2],
          names.arg = c("1st", "2nd", "3rd", "4th", "5th"),
          col = bar_colors,
          border = bar_colors,
          xlab = "Rank largest clade",
          ylab = "Density",
          ylim = c(0, ylim4))
}
