#' Run DAISIE analysis
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing. Writes [`DAISIE`] analysis results to a `.txt` file. This
#'   file is stored in `file_path`. The directory in of `file_path` is created
#'   if it doesn't exist.
#' @export
#'
#' @examples
#' \dontrun{
#' data(Galapagos_datalist, package = "DAISIE")
#' run_analysis(
#'   datalist = Galapagos_datalist,
#'   m = 165,
#'   model = cr_dd,
#'   seed = 1,
#'   file_path
#' )
#' }
#' @author Pedro Neves, Joshua W. Lambert, Luis Valente
run_analysis <- function(
  data,
  model,
  seed,
  cond) {

  # TODO: Write is DAISIE object assert is_daisie_object()

  data_name <- deparse(substitute(data))
  print_metadata(
    data_name = data_name,
    model = model,
    seed = seed)
  file_path <- create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  )

  island_age <- data[[1]]$island_age

  set.seed(
    seed,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  r_lamc <- stats::runif(1, min = 0, max = 2)
  r_mu <- stats::runif(1, min = 0, max = 2)
  r_k <- stats::runif(1, min = 6, max = 200)
  r_gam <- stats::runif(1, min = 0, max = 0.0001)
  r_ana <- stats::runif(1, min = 0.1, max = 4)

  type <- 1
  p_type2 <- 0


  model_arguments <- setup_standard_model_args(
    model = model,
    r_lamc = r_lamc,
    r_mu = r_mu,
    r_k = r_k,
    r_gam = r_gam,
    r_ana = r_ana
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
