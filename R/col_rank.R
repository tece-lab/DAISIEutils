#' Stub
#'
#' @param data stub
#' @param sim stub
#' @param plot stub
#'
#' @return
#' @export
#'
#' @examples
col_rank <- function(
  data,
  sim,
  plot = FALSE) {

  # COLONISATION RANKS. WHICH CLADE IS THE LARGEST?
  prop <- c()
  max_clade <- c()
  prop_youngest <- c()

  # Comparing only islands with 5
  islands_with_5cols <- list()
  for (i in seq_along(sim)) {
    if (length(sim[[i]]) == 6) {
      pl <- length(islands_with_5cols) + 1
      islands_with_5cols[[pl]] <- sim[[i]]
    }
  }

  for (i in seq_along(islands_with_5cols)) {
    island <- islands_with_5cols[[i]]
    if (length(island) == 1) {
      prop <- append(prop, 0)
      prop_youngest <- append(prop_youngest, 0)
      max_clade <- append(max_clade, 0)
    } else {
      island[[1]] <- NULL
      stac_vec <- unlist(island)[which(names(unlist(island)) == "stac")]
      stac_age_known <- which(stac_vec == 2 | stac_vec == 3 |  stac_vec == 4)
      btimes <- list()
      colonisation_time <- c()
      diversity <- c()
      for (i in seq_along(stac_age_known)) {
        btimes[[i]] <- island[[stac_age_known[i]]]$branching_times[-1]
        colonisation_time[i] <- max(btimes[[i]])
        diversity[i] <-
          length(btimes[[i]]) + island[[stac_age_known[i]]]$missing_species
      }

      seque <- cbind(colonisation_time, diversity)
      seque <- seque[rev(order(seque[, 1])), ]

      if (class(seque) == "matrix") {
        prop <- append(prop, as.numeric(seque[1, 2] / sum(seque[, 2])))
        prop_youngest <- append(
          prop_youngest,
          as.numeric(seque[nrow(seque), 2] / sum(seque[, 2])))
        max_clade <- append(max_clade, which(seque[, 2] == max(seque[, 2]))[1])
      }

      if (class(seque) == "numeric") {
        prop <- append(prop, 1)
        prop_youngest <- append(prop_youngest, 1)
        max_clade <- append(max_clade, 1)
      }
    }
  }
  tt <- matrix(ncol = 2, nrow = 5)
  tt[1, ] <- c(1, length(which(max_clade == 1)))
  tt[2, ] <- c(2, length(which(max_clade == 2)))
  tt[3, ] <- c(3, length(which(max_clade == 3)))
  tt[4, ] <- c(4, length(which(max_clade == 4)))
  tt[5, ] <- c(5, length(which(max_clade == 5)))

  par(mfrow = c(3, 4))

  if (plot) {
    plot_col_ranks(tt = tt)
  }
}
