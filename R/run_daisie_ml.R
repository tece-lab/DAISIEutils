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
                          methode = "lsodes",
                          optimmethod = "subplex",
                          results_dir = NULL,
                          low_rates = FALSE,
                          rep_index = "NULL",
                          res = 100,
                          par_upper_bound = Inf,
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
    optimmethod = optimmethod
  )

  output_folder_path <- create_output_folder(
    data_name = data_name,
    results_dir = results_dir
  )

  testit::assert(is.numeric(array_index) && is.finite(array_index))
  testit::assert(is.numeric(cond) && is.finite(cond))

  model_arguments <- setup_model(
    model = model,
    low_rates = low_rates,
    par_upper_bound = par_upper_bound
  )

  initparsopt <- model_arguments$initparsopt
  idparsnoshift <- model_arguments$idparsnoshift
  idparsopt <- model_arguments$idparsopt
  parsfix <- model_arguments$parsfix
  idparsfix <- model_arguments$idparsfix
  ddmodel <- model_arguments$ddmodel
  cs_version <- model_arguments$cs_version

  # for relaxed model run initial optimisation for initial parameters
  if (grepl("rr", model)) {

    # setup diversity-dependent DAISIE model
    init_model_arguments <- setup_model(
      model = "cr_dd",
      low_rates = low_rates,
      par_upper_bound = Inf
    )
    lik_res <- DAISIE::DAISIE_ML(
      datalist = daisie_data,
      initparsopt = init_model_arguments$initparsopt,
      idparsnoshift = init_model_arguments$idparsnoshift,
      idparsopt = init_model_arguments$idparsopt,
      parsfix = init_model_arguments$parsfix,
      idparsfix = init_model_arguments$idparsfix,
      res = res,
      ddmodel = init_model_arguments$ddmodel,
      cond = cond,
      methode = methode,
      optimmethod = optimmethod,
      CS_version = init_model_arguments$cs_version
    )

    # extract DAISIE parameters for initial parameters
    initparsopt[1:5] <- unlist(lik_res)[1:5]

    # prevent infinite parameter estimates given as initial parameters
    initparsopt[is.infinite(initparsopt)] <- 1e5

    # prevent initial parameters being greater than upper parameter limit
    pick <- which(c("cladogenesis", "extinction", "carrying_capacity",
                    "immigration", "anagenesis") == cs_version$relaxed_par)
    initparsopt[initparsopt[pick] > par_upper_bound] <- par_upper_bound
  }

  ##### ML Optimization ####
  lik_res <- DAISIE::DAISIE_ML(
    datalist = daisie_data,
    initparsopt = initparsopt,
    idparsnoshift = idparsnoshift,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    res = res,
    ddmodel = ddmodel,
    cond = cond,
    methode = methode,
    optimmethod = optimmethod,
    CS_version = cs_version
  )

  bic <- calc_bic(results = lik_res, daisie_data = daisie_data)
  lik_res <- cbind(lik_res, bic)

  if (identical(rep_index, "NULL")) {
    output_path <- file.path(
      output_folder_path,
      paste0(
        data_name,
        "_",
        model,
        "_",
        array_index,
        ".rds"
      )
    )
  } else {
    output_path <- file.path(
      output_folder_path,
      paste0(
        data_name,
        "_",
        model,
        "_",
        array_index,
        "_",
        rep_index,
        ".rds"
      )
    )
  }

  if (is.na(output_path)) {
    return(lik_res)
  } else {
    saveRDS(
      lik_res,
      file = output_path
    )
  }
}
