#' Title
#'
#' @param index
#' @param jump_size
#'
#' @return
#' @export
#'
#' @examples
jump_seed <- function(
  index,
  jump_size = 1e8) {

  for (i in seq_len(index)) {
    samples <- runif(n = jump_size, min = 0, max = 1)
  }
}
