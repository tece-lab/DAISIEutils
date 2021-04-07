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
#'   seed = 1,
#'   cond = 1
#' )
#' }
#' @author Pedro Neves, Joshua W. Lambert, Luis Valente
run_daisie_ml <- function(
  data,
  data_name,
  model,
  seed,
  cond) {

  # testit::assert(is_daisie_data(daisia_data = data)) #nolint
  print_metadata(
    data_name = data_name,
    model = model,
    seed = seed)
  file_path <- create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  )
  testit::assert(is.numeric(seed) && is.finite(seed))
  testit::assert(is.numeric(cond) && is.finite(cond))
  if (file.exists(file_path)) {
    return("File already present, job completed.")
  }
  set.seed(
    seed,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

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
    CS_version = cs_version
  )

  bic <- calc_bic(results = lik_res, data = data)
  lik_res <- cbind(lik_res, bic)

  saveRDS(
    lik_res,
    file = file_path
  )
}
