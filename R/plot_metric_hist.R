#' Plots histograms for a given metric
#'
#' @param results List output from [goodness_fit()]
#' @param metric A string determining which metric to plot, options are:
#'  * num_spec
#'  * num_col
#'  * num_endemic_singletons
#'  * num_nonendemic
#'  * num_type_1_spec
#'  * num_type_2_spec
#'  * num_endemic_clades
#'  * largest_clade_size
#'  * num_col_incl_recol
#'  * num_recol
#' @param type String, eiter: "type1_only" or "type1and2"
#'
#' @return Nothing
#' @export
#'
#' @examples
#' \dontrun{
#' goodness_fit(
#' metric = "num_spec",
#' type = "type1_only")
#' }
plot_metric_hist <- function(
  results,
  metric,
  type) {

  if (metric == "num_spec") {
    ####### Histogram of species richness
    graphics::hist(results$num_spec,
         xlab = "Number of species",
         breaks = 30,
         bty = "n",
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL)
    graphics::abline(v = stats::median(results$num_spec),
           col = "black",
           lwd = 2)
    graphics::arrows(results$num_spec_data,
           2000,
           results$num_spec_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "num_col") {
    ### Colonizations
    graphics::hist(
      results$num_col,
      col = "cornsilk3",
      border = "cornsilk3",
      main = NULL,
      breaks = 10,
      xlab = "Number of colonization events")
    graphics::abline(
      v = stats::median(results$number_col, na.rm = T),
      col = "black",
      lwd = 2)
    graphics::arrows(
      results$num_col_data,
      2000,
      results$num_col_data,
      0,
      col = "blue",
      length = 0.07,
      lwd = 1.5)
  }

  if (metric == "num_endemic_singletons") {
    ##### Number of endemic singletons species ("anagenetic" species)
    graphics::hist(results$num_stac2_singletons,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 12,
         xlab = "Number of endemic singletons (anagenetic spp)")
    graphics::abline(v = stats::median(results$num_stac2_singletons, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(results$endemic_singletons_data,
           2000,
           results$endemic_singletons_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "num_nonendemic") {
    ##### Number of non_endemic species
    graphics::hist(results$number_stac4,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 12,
         xlab = "Number of non-endemic species")
    graphics::abline(v = stats::median(results$number_stac4, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(results$non_endemic_spec_data,
           2000,
           results$non_endemic_spec_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "num_endemic_clades") {
    ##### Number of endemic clades
    graphics::hist(results$num_stac2,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 20,
         xlab = "Number of endemic clades",
         xlim = c(2, 22))
    graphics::abline(v = stats::median(results$num_stac2, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(results$endemic_clades_data,
           2000,
           results$endemic_clades_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "largest_clade_size") {
    ##### Size largest clade
    graphics::hist(results$size_largest_clade,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 30,
         xlab = "Size largest clade")
    graphics::abline(v = stats::median(results$size_largest_clade, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(results$size_largest_clade_data,
           2000,
           results$size_largest_clade_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "num_col_incl_recol") {
    ##### Number of colonisations including re-colonisations
    graphics::hist(results$num_col_incl_stac3s,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 12,
         xlab = "Number colonisation including re-colonisations")
    graphics::abline(v = stats::median(results$num_col_incl_stac3s, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(results$num_col_data,
           2000,
           results$num_col_data,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (metric == "num_recol") {
    ##### Number of mainland species that have re-colonised
    graphics::hist(results$num_stac3,
         col = "cornsilk3",
         border = "cornsilk3",
         main = NULL,
         breaks = 12,
         xlab = "Number re-colonisations same mainland species")
    graphics::abline(v = stats::median(results$num_stac3, na.rm = T),
           col = "black",
           lwd = 2)
    graphics::arrows(0,
           2000,
           0,
           0,
           col = "blue",
           length = 0.07,
           lwd = 1.5)
  }

  if (type == "type1and2") {
    if (metric == "num_type_1_spec") {
      ####### Number of type1 species
      graphics::hist(results$number_spec_type1,
           xlab = "Number of type 1 species",
           breaks = 30,
           bty = "n",
           col = "cornsilk3",
           border = "cornsilk3",
           main = NULL)
      graphics::abline(v = stats::median(results$number_spec_type1),
             col = "black",
             lwd = 2)
      graphics::arrows(results$num_type1_species_data,
             2000,
             results$num_type1_species_data,
             0,
             col = "blue",
             length = 0.07,
             lwd = 1.5)
    }

    if (metric == "num_type_2_spec") {
      ####### Number of type2 species
      graphics::hist(results$number_spec_type2,
           xlab = "Number of type 2 species",
           breaks = 30,
           bty = "n",
           col = "cornsilk3",
           border = "cornsilk3",
           main = NULL)
      graphics::abline(v = stats::median(results$number_spec_type2),
             col = "black",
             lwd = 2)
      graphics::arrows(results$num_type2_species_data,
             2000,
             results$num_type2_species_data,
             0,
             col = "blue",
             length = 0.07,
             lwd = 1.5)
    }
  }

}
