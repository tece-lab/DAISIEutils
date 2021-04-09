plot_col_ranks <- function(tt) {
    ## COLONISATION RANKS
    barplot(tt[,2],
            names.arg = c('1st','2nd','3rd','4th','5th'),
            col='cornsilk3',
            border='cornsilk3',
            xlab='Largest clade')
}
