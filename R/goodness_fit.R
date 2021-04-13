#' Calculates the metrics from simulated data and compares it to
#' empirical data
#'
#' @param data stub
#' @param sim stub
#' @param plot stub
#'
#' @return List of numeric vectors
#' @export
#'
#' @examples
#' \dontrun{
#' goodness_fit(
#' data = Galapagos_datalist,
#' sim = islands_1type_1000reps)
#' }
goodness_fit <- function(
  data,
  sim,
  plot = FALSE) {

  trunc_data <- data[-1]
  types <- unlist(lapply(trunc_data, "[[", 5))
  if (all(types == 1)) {
    type <- "type1only"
  } else {
    type <- "type1and2"
  }

  # calculate number of species in data
  island_age <- data[[1]]$island_age
  trunc_data <- data[-1]
  brts <- unlist(lapply(trunc_data, "[[", 2))
  brts <- brts[-which(brts == island_age)]
  num_spec_data <- length(brts)

  # calculate number of colonists in data
  num_col_data <- length(trunc_data)

  # calculate number of endemic species in data
  stacs <- lapply(trunc_data, "[[", 3)
  brts <- lapply(trunc_data, "[[", 2)
  endemic_stacs <- which(stacs == 2 | stacs == 3 | stacs == 5 | stacs == 6 |
                           stacs == 7 | stacs == 9)
  endemic_brts <- unlist(brts[endemic_stacs])
  endemic_brts <- endemic_brts[-which(endemic_brts == island_age)]
  endemic_spec_data <- length(endemic_brts)

  # calculate number of non-endemic species in data
  stacs <- lapply(trunc_data, "[[", 3)
  brts <- lapply(trunc_data, "[[", 2)
  nonendemic_stacs <- which(stacs == 1 | stacs == 4 | stacs == 8)
  nonendemic_brts <- unlist(brts[nonendemic_stacs])
  nonendemic_brts <- nonendemic_brts[-which(nonendemic_brts == island_age)]
  nonendemic_spec_data <- length(nonendemic_brts)

  # calculate number of endemics clades in data
  stacs <- lapply(trunc_data, "[[", 3)
  endemic_clades_data <- length(which(stacs == 2 | stacs == 3 | stacs == 5 |
                                        stacs == 6 | stacs == 7 | stacs == 9))

  # calculate number of endemic singletons (also known as anagenetic species)
  stacs <- lapply(trunc_data, "[[", 3)
  brts <- lapply(trunc_data, "[[", 2)
  endemic_stacs <- which(stacs == 2 | stacs == 3 | stacs == 5 | stacs == 6 |
                           stacs == 7 | stacs == 9)
  endemic_brts <- brts[endemic_stacs]
  endemic_clade_size <- lapply(endemic_brts, length)
  endemic_singletons_data <- length(which(endemic_clade_size == 2))

  # calculate size of largest clade
  brts <- lapply(trunc_data, "[[", 2)
  clade_size <- unlist(lapply(brts, length))
  size_largest_clade_data <- max(clade_size) - 1

  if (type == "type1and2") {
    # calculate number of type 1 species in data
    island_age <- data[[1]]$island_age
    trunc_data <- data[-1]
    types <- unlist(lapply(trunc_data, "[[", 5))
    type_1_data <- trunc_data[which(types == 1)]
    brts <- unlist(lapply(type_1_data, "[[", 2))
    brts <- brts[-which(brts == island_age)]
    num_type1_spec_data <- length(brts)

    # calculate number of type 2 species in data
    island_age <- data[[1]]$island_age
    trunc_data <- data[-1]
    types <- unlist(lapply(trunc_data, "[[", 5))
    type_2_data <- trunc_data[which(types == 2)]
    brts <- unlist(lapply(type_2_data, "[[", 2))
    brts <- brts[-which(brts == island_age)]
    num_type2_spec_data <- length(brts)
  }

  # Calculate  species richness and colonization statistics across all islands
  num_col <- c()
  num_spec <- c()
  num_stac2 <- c()
  num_stac3 <- c()
  num_stac4 <- c()
  num_col_incl_stac3s <- c()
  num_stac2_singletons <- c()
  size_largest_clade <- c()
  size_smallest_clade <- c()

  if (type == "type1and2") {
    num_spec_type1 <- c()
    num_spec_type2 <- c()
  }

  for (i in seq_along(sim)) {

    island <- sim[[i]]
    last_row <- nrow(island[[1]]$stt_all)

    num_col <- append(
      num_col,
      as.numeric(island[[1]]$stt_all[last_row, "present"]))

    u_island <- unlist(island)

    if (num_col[[i]] == 0) {

      num_stac2_singletons <- append(num_stac2_singletons, 0)
      size_largest_clade <- append(size_largest_clade, NA)
      size_smallest_clade <- append(size_smallest_clade, NA)
      num_col_incl_stac3s <- append(num_col_incl_stac3s, 0)

      if (type == "type1and2") {
        num_spec_type1 <- append(num_spec_type1, 0)
        num_spec_type2 <- append(num_spec_type2, 0)
      }
    }

    if (num_col[[i]] > 0) {

      num_spec <- append(
        num_spec,
        sum(island[[1]]$stt_all[last_row, c(2, 3, 4)]))
      num_stac2 <- append(
        num_stac2,
        length(which(u_island[which(names(u_island) == "stac")] == 2)))
      num_stac3 <- append(
        num_stac3,
        length(which(u_island[which(names(u_island) == "stac")] == 3)))
      num_stac4 <- append(
        num_stac4,
        as.numeric(island[[1]]$stt_all[last_row, 2]))

      if (type == "type1and2") {
        num_spec_type1 <- append(
          num_spec_type1,
          sum(island[[1]]$stt_type1[nrow(island[[1]]$stt_type1), c(2, 3, 4)]))
        num_spec_type2 <- append(
          num_spec_type2,
          sum(island[[1]]$stt_type2[nrow(island[[1]]$stt_type2), c(2, 3, 4)]))
      }

      if (length(which(u_island[which(names(u_island) == "stac")] == 2)) > 0) {
        store_stac2s_brts <- list()
        store_all_brts <- list()

        for (isl in 1:(length(island) - 1)) {
          if (island[[isl + 1]]$stac == 2) {
            store_stac2s_brts[[length(store_stac2s_brts) + 1]] <-
              island[[isl + 1]]$branching_times
          }
          store_all_brts[[length(store_all_brts) + 1]] <-
            island[[isl + 1]]$branching_times
        }
        num_stac2_singletons <- append(
          num_stac2_singletons,
          length(which(unlist(lapply(store_stac2s_brts, length)) == 2)))
        size_largest_clade <- append(
          size_largest_clade,
          max(unlist(lapply(store_stac2s_brts, length))) - 1)
        size_smallest_clade <- append(
          size_smallest_clade,
          min(unlist(lapply(store_all_brts, length))) - 1)
      } else {
        num_stac2_singletons <- append(num_stac2_singletons, 0)
        size_largest_clade <- append(size_largest_clade, NA)
        size_smallest_clade <- append(size_smallest_clade, NA)
      }

      num_col_incl_stac3s <- append(
        num_col_incl_stac3s,
        num_col[[i]])

      if (num_stac3[i] > 0) {
        count_stac3_cols <- 0
        for (isl in 1:(length(island) - 1)) {
          if (island[[isl + 1]]$stac == 3) {
            count_stac3_cols <-
              count_stac3_cols + length(island[[isl + 1]]$all_colonisations) - 1
          }
        }
        num_col_incl_stac3s[i] < -num_col_incl_stac3s[i] + count_stac3_cols
      }
    }
  }

  results <- list(
    num_spec_data = num_spec_data,
    num_col_data = num_col_data,
    endemic_spec_data = endemic_spec_data,
    nonendemic_spec_data = nonendemic_spec_data,
    endemic_singletons_data = endemic_singletons_data,
    endemic_clades_data = endemic_clades_data,
    size_largest_clade_data = size_largest_clade_data,
    num_spec = num_spec,
    num_col = num_col,
    num_stac2 = num_stac2,
    num_stac3 = num_stac3,
    num_stac4 = num_stac4,
    num_stac2_singletons = num_stac2_singletons,
    num_col_incl_stac3s = num_col_incl_stac3s,
    num_endemic_species = num_spec - num_stac4,
    size_largest_clade = size_largest_clade,
    size_smallest_clade = size_smallest_clade)

  if (type == "type1and2") {
    results$num_type1_spec_data <- num_type1_spec_data
    results$num_type2_spec_data <- num_type2_spec_data
    results$num_spec_type1 <- num_spec_type1
    results$num_spec_type2 <- num_spec_type2
  }

  if (plot) {
    plot_metric_hist(
      results = results,
      metric = "num_spec",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_col",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_endemic_singletons",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_nonendemics",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_type_1_spec",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_type_2_spec",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_endemic_clades",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "largest_clade_size",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_col_incl_recol",
      type = type)
    plot_metric_hist(
      results = results,
      metric = "num_recol",
      type = type)
  }
  return(results)
}
