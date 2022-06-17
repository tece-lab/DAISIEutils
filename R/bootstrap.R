#' Runs a bootstrapping on a DAISIE model to determine parameter precision
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing. Writes bootstrapping results to a `.rds` file. This
#'   file is stored in `$HOME/results/data_name` if running on the cluster or
#'   `/results/data_name` if running locally. The directory is created if it
#'   doesn't exist.
#' @export
#'
#' @examples
#' \dontrun{
#' data(Galapagos_datalist, package = "DAISIE")
#' bootstrap(
#'   daisie_data = Galapagos_datalist,
#'   data_name = "Galapagos_datalist",
#'   model = "cr_dd",
#'   array_index = 1,
#'   cond = 1
#' )
#' }
bootstrap <- function(daisie_data,
                      data_name,
                      model,
                      array_index,
                      cond,
                      methode = "lsodes",
                      optimmethod = "subplex",
                      results_dir = NULL,
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
    model = paste("boot", model, sep = "_"),
    array_index = array_index,
    seed = seed,
    methode = methode,
    optimmethod = optimmethod
  )
  data_to_read_path <- create_results_dir_path(
    data_name = data_name,
    results_dir = results_dir
  )

  model_files <- list.files(
    path = data_to_read_path,
    full.names = TRUE,
    pattern = paste0(data_name, "_", model, "_[0-9].rds$")
  )

  model_lik_res <- lapply(model_files, readRDS)

  best_model <- choose_best_model(model_lik_res)

  sim <- run_sim(
    daisie_data = daisie_data,
    model = model,
    lik_res = best_model,
    cond = cond
  )

  model_arguments <- setup_model(
    model = model
  )

  model_initparsopt <- model_arguments$initparsopt
  model_idparsnoshift <- model_arguments$idparsnoshift
  model_idparsopt <- model_arguments$idparsopt
  model_parsfix <- model_arguments$parsfix
  model_idparsfix <- model_arguments$idparsfix
  model_ddmodel <- model_arguments$ddmodel
  model_cs_version <- model_arguments$cs_version

  ##### ML Optimization ####
  model_sim_lik_res <- DAISIE::DAISIE_ML(
    datalist = sim[[1]],
    initparsopt = model_initparsopt,
    idparsnoshift = model_idparsnoshift,
    idparsopt = model_idparsopt,
    parsfix = model_parsfix,
    idparsfix = model_idparsfix,
    ddmodel = model_ddmodel,
    cond = cond,
    methode = methode,
    optimmethod = optimmethod,
    CS_version = model_cs_version
  )

  output <- list(
    model_lik_res = model_lik_res,
    sim = sim,
    model_sim_lik_res = model_sim_lik_res
  )

  output_folder_path <- create_output_folder(
    data_name = data_name,
    results_dir = results_dir
  )
  output_path <- file.path(
    output_folder_path,
    paste0(
      data_name,
      "_boot_",
      model,
      "_",
      array_index,
      ".rds"
    )
  )
  saveRDS(output, file = output_path)
}
