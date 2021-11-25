#' Run DAISIE analysis
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing. Writes [`DAISIE`] analysis results to a `.rds` file. This
#'   file is stored in `file_path`. The directory in of `file_path` is created
#'   if it doesn't exist.
#' @export
#'
#' @examples
#' \dontrun{
#' data(Galapagos_datalist, package = "DAISIE")
#' run_daisie_ml(
#'   data = Galapagos_datalist,
#'   data_name = "Galapagos_datalist",
#'   model = "cr_dd",
#'   array_index = 1,
#'   cond = 1,
#'   optimmethod = "subplex",
#'   output_file_dir = "results"
#' )
#' }
#' @author Pedro Neves, Joshua W. Lambert, Luis Valente
run_daisie_ml <- function(
  data,
  data_name,
  model,
  array_index,
  cond,
  optimmethod,
  output_folder,
  cluster_dir = Sys.getenv("HOME"),
  test = FALSE) {

  if (test) {
    seed <- array_index
  } else {
    seed <- as.integer(Sys.time()) %% 10000L * array_index
  }

  set.seed(
    seed,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  # testit::assert(is_daisie_data(daisia_data = data)) #nolint
  print_metadata(
    data_name = data_name,
    model = model,
    array_index = array_index,
    seed = seed)

  if (!is.null(output_folder)) {
    file_path <- create_output_folder(
     output_folder = output_folder,
     cluster_dir = cluster_dir
    )
  }

  testit::assert(is.numeric(array_index) && is.finite(array_index))
  testit::assert(is.numeric(cond) && is.finite(cond))

  model_arguments <- setup_model(
    model = model
  )

  initparsopt <- model_arguments$initparsopt
  idparsnoshift <- model_arguments$idparsnoshift
  idparsopt <- model_arguments$idparsopt
  parsfix <- model_arguments$parsfix
  idparsfix <- model_arguments$idparsfix
  ddmodel <- model_arguments$ddmodel
  cs_version <- model_arguments$cs_version

  ##### ML Optimization ####
  lik_res <- DAISIE::DAISIE_ML(
    datalist = data,
    initparsopt = initparsopt,
    idparsnoshift = idparsnoshift,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    ddmodel = ddmodel,
    cond = cond,
    optimmethod = optimmethod,
    CS_version = cs_version
  )

  bic <- calc_bic(results = lik_res, data = data)
  lik_res <- cbind(lik_res, bic)

  if (is.null(output_folder)) {
    return(lik_res)
  } else {
    create_file_path(
      output_folder = output_folder,
      data_name = data_name,
      model = model,
      array_index = array_index,
      cluster_dir = cluster_dir)
    saveRDS(
      lik_res,
      file = file_path
    )
  }
}
