#' Run analysis from a set of initial parameters
#'
#' @inheritParams default_params_doc
#'
#' @return Saves results to .txt file.
#' @export
#'
#' @examples
#' # Run 1 set of randomly sampled initial parameters for scenario 1 and
#' # model 1 of the Galapagos datalist.
#' \dontrun{
#' data(Galapagos_datalist, package = "DAISIE")
#' run_main(
#'   datalist = Galapagos_datalist,
#'   m = 50,
#'   model = 1,
#'   seeds = 1
#' )
#' }
#' @author Pedro Neves
run_main <- function(datalist,
                     m,
                     model,
                     seeds) {
  # TODO: Write is DAISIE object assert

  datalist_name <- deparse(substitute(datalist))
  testit::assert(is.character(datalist_name))


  print_main_header(run_name = datalist_name, m = m, metadata = model)



  file_path <- create_output_folder(
    output_name = datalist_name,
    model = model,
    verbose = verbose
  )

  output_file_header <- c(
    "datalist_name",
    "model",
    "seed",
    "island_age",
    "M",
    "type",
    "p_type2",
    "res",
    "methode",
    "run_number",
    "lambda_c",
    "mu",
    "K",
    "gamma",
    "lambda_a",
    "loglik",
    "df",
    "conv",
    "initparsopt_lac",
    "initparsopt_mu",
    "initparsopt_K",
    "initparsopt_gamma",
    "initparsopt_laa"
  )

  write(
    output_file_header,
    file = file_path,
    ncolumns = length(output_file_header),
    append = TRUE,
    sep = "\t"
  )

  for (seed in seeds) {
    message(
      "Running analysis with seed: ", seed, "\n",
      "This is seed ", which(seeds == seed), " out of ", length(seeds)
    )
    run_analysis(
      datalist = datalist,
      datalist_name,
      m = m,
      model = model,
      seed = seed,
      file_path = file_path
    )
  }
}
