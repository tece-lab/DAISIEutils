goodness_fit <- function(
  data,
  sim,
  type,
  plot = FALSE) {

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

  if (type == "two_type") {
    num_type1_species_data <- 30
    num_type2_species_data <- 167
    type <- "type1and2"
  } else {
    type <- "type1only"
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
      as.numeric(island[[1]]$stt_all[last_row,"present"]))

    u_island <- unlist(island)

    if (num_col[[i]] == 0) {

      num_stac2_singletons <- append(num_stac2_singletons, 0)
      size_largest_clade<- append(size_largest_clade, NA)
      size_smallest_clade<- append(size_smallest_clade, NA)
      num_col_incl_stac3s <- append(num_col_incl_stac3s, 0)

      if (type == "type1and2") {
        num_spec_type1 <- append(num_spec_type1, 0)
        num_spec_type2 <- append(num_spec_type2, 0)
      }
    }

    if (num_col[[i]] > 0) {

      num_spec <- append(
        num_spec,
        sum(island[[1]]$stt_all[last_row,c(2,3,4)]))
      num_stac2 <- append(
        num_stac2,
        length(which(u_island[which(names(u_island)=="stac")]==2)))
      num_stac3 <- append(
        num_stac3,
        length(which(u_island[which(names(u_island)=="stac")]==3)))
      num_stac4 <- append(
        num_stac4,
        as.numeric(island[[1]]$stt_all[last_row,2]))

      if (type == "type1and2") {
        num_spec_type1 <- append(
          num_spec_type1,
          sum(island[[1]]$stt_type1[nrow(island[[1]]$stt_type1),c(2,3,4)]))
        num_spec_type2 <- append(
          num_spec_type2,
          sum(island[[1]]$stt_type2[nrow(island[[1]]$stt_type2),c(2,3,4)]))
      }

      if (length(which(u_island[which(names(u_island)=="stac")]==2)) > 0) {
        store_stac2s_brts <- list()
        store_all_brts <- list()

        for (isl in 1:(length(island)-1)) {
          if (island[[isl+1]]$stac == 2) {
            store_stac2s_brts[[length(store_stac2s_brts)+1]] <-
              island[[isl+1]]$branching_times
          }
          store_all_brts[[length(store_all_brts)+1]] <-
            island[[isl+1]]$branching_times
        }
        num_stac2_singletons <- append(
          num_stac2_singletons,
          length(which(unlist(lapply(store_stac2s_brts,length))==2)))
        size_largest_clade <- append(
          size_largest_clade,
          max(unlist(lapply(store_stac2s_brts,length)))-1)
        size_smallest_clade <- append(
          size_smallest_clade,
          min(unlist(lapply(store_all_brts,length)))-1)
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
        for (isl in 1:(length(island)-1)) {
          if (island[[isl+1]]$stac==3) {
            count_stac3_cols <-
              count_stac3_cols + length(island[[isl+1]]$all_colonisations)-1
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

  if (type=="type1and2") {
    results$num_spec_type1 <- num_spec_type1
    results$num_spec_type2 <- num_spec_type2
  }

  #### COLONISATION RANKS. WHICH CLADE IS THE LARGEST? 1st, 2nd, 3rd,4th or 5th?
  the_prop <- c()
  max_clade <- c()
  the_prop_youngest <- c()

  ### Comparing only islands with 5
  islands_with_5cols <- list()
  for (i in 1:length(sim)) {
    if (length(sim[[i]]) == 6){
      pl <- length(islands_with_5cols) + 1
      islands_with_5cols[[pl]]<-sim[[i]]
    }
  }

  for (i in 1:length(islands_with_5cols)) {
    island <- islands_with_5cols[[i]]
    if (length(island) == 1) {
      the_prop <- append(the_prop, 0)
      the_prop_youngest <- append(the_prop_youngest, 0)
      max_clade <- append(max_clade, 0)
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

      seque<-cbind(colonisation_time,diversity)
      seque<-seque[rev(order(seque[,1])),]

      if (class(seque)=='matrix') {
        the_prop<-append(the_prop,as.numeric(seque[1,2]/sum(seque[,2])))
        the_prop_youngest<-append(the_prop_youngest,as.numeric(seque[nrow(seque),2]/sum(seque[,2])))
        max_clade<-append(max_clade,which(seque[,2]==max(seque[,2]))[1])
      }

      if (class(seque)=='numeric') {
        the_prop <- append(the_prop,1)
        the_prop_youngest <- append(the_prop_youngest,1)
        max_clade <- append(max_clade,1)
      }
    }
  }

  tt<-matrix(ncol=2,nrow=5)
  tt[1,]<-c(1,length(which(max_clade==1)))
  tt[2,]<-c(2,length(which(max_clade==2)))
  tt[3,]<-c(3,length(which(max_clade==3)))
  tt[4,]<-c(4,length(which(max_clade==4)))
  tt[5,]<-c(5,length(which(max_clade==5)))

  par(mfrow=c(3,4))

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
    #plot_col_ranks(tt = tt)
  }
  return(results)
}
