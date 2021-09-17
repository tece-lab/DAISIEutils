#' Computes summary results of bootstrap simulations useful for plotting
#'
#' The output is a list of results
#'
#' @param simulation_dataset output of DAISIE_sim
#' @param empirical_summary_statistics vector with the number of species, number
#' of colonization, size of the largest clade and the rank of the largest clade
#' in the empirical data
#' @param m_pool size of the mainland pool
#' @param time age of the island or archipelago
#' @return overall_results a list of results
#' @author Rampal S. Etienne & Luis Valente
#' @export summarize_bootstrap_results
summarize_bootstrap_results <- function(simulation_dataset, empirical_summary_statistics, m_pool = 1000)
{
  load(simulation_dataset)
  replicates <- length(frogs_sims)

  ###### Calculate overall species richness and colonization statistics across all islands
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

  for(i in 1:replicates) {
    the_island <- frogs_sims[[i]]
    number_colonists <- append(number_colonists, m_pool - the_island[[1]]$not_present)
    number_stac0 <- append(number_stac0, the_island[[1]]$not_present)
    unlist(the_island) -> u_island

    if(the_island[[1]]$not_present == m_pool) {
      number_spec <- append(number_spec, 0)
      number_stac1 <- append(number_stac1, 0)
      number_stac2 <- append(number_stac2, 0)
      number_stac3 <- append(number_stac3, 0)
      number_stac4 <- append(number_stac4, 0)
      number_stac2_singletons <- append(number_stac2_singletons, 0)
      size_largest_clade <- append(size_largest_clade, NA)
      size_smallest_clade <- append(size_smallest_clade, NA)
    } else {
      #number_spec <- append(number_spec, sum(the_island[[1]]$stt_all[nrow(the_island[[1]]$stt_all), c(2, 3, 4)]))
      s <- NULL
      cc <- NULL
      for(j in 2:length(the_island))
      {
        if(is.null(the_island[[j]]$all_colonisations))
        {
          s <- c(s, length(the_island[[j]]$branching_times) - 1)
          cc <- c(cc, the_island[[j]]$branching_times[2])
        } else
        {
          for(k in 1:length(the_island[[j]]$all_colonisations))
          {
            s <- c(s, length(the_island[[j]]$all_colonisations[[k]]$event_times) - 1)
            cc <- c(cc, the_island[[j]]$all_colonisations[[k]]$event_times[2])
          }
        }
      }
      scc <- sort(cc, decreasing = TRUE)
      rank_largest_clade <- c(rank_largest_clade,which(scc == cc[which.max(s)]))
      number_spec <- append(number_spec,sum(s))
      number_stac1 <- append(number_stac1, length(which(u_island[which(names(u_island) == "stac")] == 1)))
      number_stac2 <- append(number_stac2, length(which(u_island[which(names(u_island) == "stac")] == 2)))
      number_stac3 <- append(number_stac3, length(which(u_island[which(names(u_island) == "stac")] == 3)))
      number_stac4 <- append(number_stac4, length(which(u_island[which(names(u_island) == "stac")] == 4)))
      if(length(which(u_island[which(names(u_island) == "stac")] == 2)) > 0)
      {
        store_stac2s_brts <- list()
        store_all_brts <- list()
        for (isl in 2:length(the_island))
        {
          if(the_island[[isl]]$stac == 2) {store_stac2s_brts[[length(store_stac2s_brts) + 1]] <- the_island[[isl]]$branching_times}
          store_all_brts[[length(store_all_brts) + 1]] <- the_island[[isl]]$branching_times
        }
        number_stac2_singletons <- append(number_stac2_singletons, length(which(unlist(lapply(store_stac2s_brts, length)) == 2)))
        #size_largest_clade <- append(size_largest_clade, max(unlist(lapply(store_stac2s_brts, length))) - 1)
        #size_smallest_clade <- append(size_smallest_clade, min(unlist(lapply(store_all_brts, length))) - 1)
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
  max_clade <- c()
  the_prop_youngest <- c()

  frogs5 <- list()
  for(i in 1:length(frogs_sims)) {
    if(length(frogs_sims[[i]]) == 6){
      pl <- length(frogs5) + 1
      frogs5[[pl]] <- frogs_sims[[i]] }
  }

  for(i in 1:length(frogs5)) {
    island <- frogs5[[i]]
    if(length(island) == 1) {
      the_prop <- append(the_prop, 0)
      the_prop_youngest <- append(the_prop_youngest, 0)
    } else {
      island[[1]] <- NULL
      stac_vec <- unlist(island)[which(names(unlist(island)) == "stac")]
      stac_age_known <- which(stac_vec == 2 | stac_vec == 3 |  stac_vec == 4)
      btimes <- list()
      colonisation_time <- c()
      diversity <- c()
      for (o in 1:length(stac_age_known)) {
        btimes[[o]] <- island[[stac_age_known[o]]]$branching_times[-1]
        colonisation_time[o] <- max(btimes[[o]])
        diversity[o] <- length(btimes[[o]]) + island[[stac_age_known[o]]]$missing_species
      }

      seque <- cbind(colonisation_time, diversity)
      seque <- seque[rev(order(seque[, 1])), ]

      if(is.matrix(seque)){
        the_prop <- append(the_prop, as.numeric(seque[1, 2]/sum(seque[, 2])))
        the_prop_youngest <- append(the_prop_youngest, as.numeric(seque[nrow(seque), 2]/sum(seque[, 2])))
      }

      if(is.numeric(seque)){
        the_prop <- append(the_prop, 1)
        the_prop_youngest <- append(the_prop_youngest, 1)
      }
    }
  }

  tt <- matrix(ncol = 2, nrow = 5)
  tt[1:5,1] <- 1:5
  tt[1:5,2] <- hist(x = rank_largest_clade,
                    breaks = seq(0.5,max(rank_largest_clade) + 0.5, by = 1),
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
#' @param overall_results summary results obtained with summarize_boorstrap_results
#' @param sumstats vector with the number of species, number
#' of colonization, size of the largest clade and the rank of the largest clade
#' in the empirical data
#' @param ylim4 maximum of the plot of the rank of the largest clade
#' @param title title of the plot
#' @return none Four plots are shown: histogram of the number of species,
#' histogram of the number of colonizations, histogram of the largest clade size
#' and histogram of the rank of the largest clade
#' @author Rampal S. Etienne & Luis Valente
#' @export plot_bootstrap_results
plot_bootstrap_results <- function(overall_results, sumstats = c(65,5,28,1), ylim4 = 0.7, title = NULL)
{
  hist(x = overall_results$number_spec,
       xlab = "Number of species",
       breaks = 30,
       freq = FALSE,
       bty = "n",
       col = "cornsilk3",
       border = "cornsilk3",
       main = title)
  abline(v = median(overall_results$number_spec), col = "black", lwd = 2)
  arrows(sumstats[1], 1, sumstats[1], 0, col = 'blue', length = 0.07, lwd = 1.5)

  ### Colonizations
  hist(x = overall_results$number_colonists,
       col = "cornsilk3",
       border = "cornsilk3",
       main = NULL,
       breaks = 10,
       freq = FALSE,
       xlab = "Number of colonization events")
  abline(v = median(overall_results$number_colonists, na.rm = T), col = "black", lwd = 2)
  arrows(sumstats[2], 1, sumstats[2], 0, col = 'blue', length = 0.07, lwd = 1.5)

  ##### size largest clade
  hist(x = overall_results$size_largest_clade,
       col = "cornsilk3",
       border = "cornsilk3",
       main = NULL,
       breaks = 30,
       freq = FALSE,
       xlab = "Size largest clade")
  abline(v = median(overall_results$size_largest_clade, na.rm = T), col = "black", lwd = 2)
  arrows(sumstats[3], 1, sumstats[3], 0, col = 'blue', length = 0.07, lwd = 1.5)

  bar_colors <- rep('cornsilk3',5)
  bar_colors[sumstats[4]] <- 'blue'
  barplot(height = overall_results$tt[, 2],
          names.arg = c('1st', '2nd', '3rd', '4th', '5th'),
          col = bar_colors,
          border = bar_colors,
          xlab = 'Rank largest clade',
          ylab = 'Density',
          ylim = c(0, ylim4))
}

#dataset_CS <- 'd:/data/tex/Etienne et al 2019/frogs_sim_CS_T30_M1000_R5000.RData'
#dataset_IW <- 'd:/data/tex/Etienne et al 2019/frogs_sim_IW_T30_M1000_R5000.RData'
#overall_results_CS <- summarize_bootstrap_results(simulation_dataset = dataset_CS)
#overall_results_IW <- summarize_bootstrap_results(simulation_dataset = dataset_IW)
#par(mfrow = c(2, 4), cex.lab = 1.5, cex.main = 1.5)
#plot_bootstrap_results(overall_results = overall_results_CS, title = 'Simulated under CS')
#plot_bootstrap_results(overall_results = overall_results_IW, title = 'Simulated under IW')
