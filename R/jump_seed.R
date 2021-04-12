#' Jumps forward in a seed stream
#'
#' @param index stub
#' @param jump_size stub
#'
#' @return Nothing, this is a void function.
#' @export
#'
#' @examples
#' \dontrun{
#' jump_seed(index = 1, jump_size = 1e8)
#' }
jump_seed <- function(
  index,
  jump_size = 1e8) {

  for (i in seq_len(index)) {
    samples <- stats::runif(n = jump_size, min = 0, max = 1)
  }
}
