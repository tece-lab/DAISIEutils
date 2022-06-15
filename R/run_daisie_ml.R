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
#'   daisie_data = Galapagos_datalist,
#'   data_name = "Galapagos_datalist",
#'   model = "cr_dd",
#'   array_index = 1,
#'   cond = 1
#' )
#' }
#' @author Pedro Santos Neves, Joshua W. Lambert, Luis Valente
run_daisie_ml <- function(daisie_data,
                          data_name,
                          model,
                          array_index,
                          cond,
                          methode = "odeint::runge_kutta_fehlberg78",
                          optimmethod = "subplex",
                          results_dir = NULL,
                          low_rates = FALSE,
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

  print_metadata(
    data_name = data_name,
    model = model,
    array_index = array_index,
    seed = seed,
    methode = methode,
    optimmethod = optimmethod)

  output_folder_path <- create_output_folder(
    data_name = data_name,
    results_dir = results_dir
  )

  testit::assert(is.numeric(array_index) && is.finite(array_index))
  testit::assert(is.numeric(cond) && is.finite(cond))

  model_arguments <- setup_model(
    model = model,
    low_rates = low_rates
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
    datalist = daisie_data,
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

  bic <- calc_bic(results = lik_res, daisie_data = daisie_data)
  lik_res <- cbind(lik_res, bic)

  output_path <- file.path(
    output_folder_path,
    paste(
      model,
      array_index,
      sep = "_"
    )
  )

  if (is.na(output_path)) {
    return(lik_res)
  } else {
    saveRDS(
      lik_res,
      file = output_path
    )
  }
}
