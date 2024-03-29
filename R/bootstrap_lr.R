#' Runs a parameteric bootstrapping likelihood ratio test on two DAISIE models
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing. Writes bootstrapping results to a `.rds` file. This
#'   file is stored in `file_path`. The directory in of `file_path` is created
#'   if it doesn't exist.
#' @export
#'
#' @examples
#' \dontrun{
#' data(Galapagos_datalist, package = "DAISIE")
#' bootstrap_lr(
#'   daisie_data = Galapagos_datalist,
#'   model_1 = "cr_dd",
#'   model_2 = "cr_di",
#'   array_index = 1,
#'   cond = 1,
#' )
#' }
bootstrap_lr <- function(daisie_data,
                         data_name,
                         model_1,
                         model_2,
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
    model = paste("boot_lr", model_1, model_2, sep = "_"),
    array_index = array_index,
    seed = seed,
    methode = methode,
    optimmethod = optimmethod
  )

  data_to_read_path <- create_results_dir_path(
    data_name = data_name,
    results_dir = results_dir
  )

  model_1_files <- list.files(
    path = data_to_read_path,
    full.names = TRUE,
    pattern = paste0(data_name, "_", model_1, "_[0-9].rds$"),
    recursive = TRUE
  )
  model_1_lik_res <- lapply(model_1_files, readRDS)

  model_2_files <- list.files(
    path = data_to_read_path,
    full.names = TRUE,
    pattern = paste0(data_name, "_", model_2, "_[0-9].rds$")
  )
  model_2_lik_res <- lapply(model_2_files, readRDS)
  best_model_1 <- choose_best_model(model_1_lik_res)
  best_model_2 <- choose_best_model(model_2_lik_res)

  lik_ratio_0 <- calc_loglik_ratio(
    model_1_lik_res = best_model_1,
    model_2_lik_res = best_model_2
  )

  sim_1 <- run_sim(
    daisie_data = daisie_data,
    model = model_1,
    lik_res = best_model_1,
    cond = cond
  )

  model_1_arguments <- setup_model(
    model = model_1
  )
  model_2_arguments <- setup_model(
    model = model_2
  )

  model_1_initparsopt <- model_1_arguments$initparsopt
  model_1_idparsnoshift <- model_1_arguments$idparsnoshift
  model_1_idparsopt <- model_1_arguments$idparsopt
  model_1_parsfix <- model_1_arguments$parsfix
  model_1_idparsfix <- model_1_arguments$idparsfix
  model_1_ddmodel <- model_1_arguments$ddmodel
  model_1_cs_version <- model_1_arguments$cs_version

  model_2_initparsopt <- model_2_arguments$initparsopt
  model_2_idparsnoshift <- model_2_arguments$idparsnoshift
  model_2_idparsopt <- model_2_arguments$idparsopt
  model_2_parsfix <- model_2_arguments$parsfix
  model_2_idparsfix <- model_2_arguments$idparsfix
  model_2_ddmodel <- model_2_arguments$ddmodel
  model_2_cs_version <- model_2_arguments$cs_version

  ##### ML Optimization ####
  model_1_sim_1_lik_res <- DAISIE::DAISIE_ML(
    datalist = sim_1[[1]],
    initparsopt = model_1_initparsopt,
    idparsnoshift = model_1_idparsnoshift,
    idparsopt = model_1_idparsopt,
    parsfix = model_1_parsfix,
    idparsfix = model_1_idparsfix,
    ddmodel = model_1_ddmodel,
    cond = cond,
    CS_version = model_1_cs_version
  )

  ##### ML Optimization ####
  model_2_sim_1_lik_res <- DAISIE::DAISIE_ML(
    datalist = sim_1[[1]],
    initparsopt = model_2_initparsopt,
    idparsnoshift = model_2_idparsnoshift,
    idparsopt = model_2_idparsopt,
    parsfix = model_2_parsfix,
    idparsfix = model_2_idparsfix,
    ddmodel = model_2_ddmodel,
    cond = cond,
    CS_version = model_2_cs_version
  )

  lik_ratio_1 <- calc_loglik_ratio(
    model_1_lik_res = model_1_sim_1_lik_res,
    model_2_lik_res = model_2_sim_1_lik_res
  )

  sim_2 <- run_sim(
    daisie_data = daisie_data,
    model = model_1,
    lik_res = best_model_1,
    cond = cond
  )

  ##### ML Optimization ####
  model_1_sim_2_lik_res <- DAISIE::DAISIE_ML(
    datalist = sim_2[[1]],
    initparsopt = model_1_initparsopt,
    idparsnoshift = model_1_idparsnoshift,
    idparsopt = model_1_idparsopt,
    parsfix = model_1_parsfix,
    idparsfix = model_1_idparsfix,
    ddmodel = model_1_ddmodel,
    cond = cond,
    CS_version = model_1_cs_version
  )

  ##### ML Optimization ####
  model_2_sim_2_lik_res <- DAISIE::DAISIE_ML(
    datalist = sim_2[[1]],
    initparsopt = model_2_initparsopt,
    idparsnoshift = model_2_idparsnoshift,
    idparsopt = model_2_idparsopt,
    parsfix = model_2_parsfix,
    idparsfix = model_2_idparsfix,
    ddmodel = model_2_ddmodel,
    cond = cond,
    CS_version = model_2_cs_version
  )

  lik_ratio_2 <- calc_loglik_ratio(
    model_1_lik_res = model_1_sim_1_lik_res,
    model_2_lik_res = model_2_sim_1_lik_res
  )

  output <- list(
    model_1_lik_res = model_1_lik_res,
    model_2_lik_res = model_2_lik_res,
    lik_ratio_0 = lik_ratio_0,
    sim_1 = sim_1,
    model_1_sim_1_lik_res = model_1_sim_1_lik_res,
    model_2_sim_1_lik_res = model_2_sim_1_lik_res,
    lik_ratio_1 = lik_ratio_1,
    sim_2 = sim_2,
    model_1_sim_2_lik_res = model_1_sim_2_lik_res,
    model_2_sim_2_lik_res = model_2_sim_2_lik_res,
    lik_ratio_2 = lik_ratio_2
  )
  output_folder_path <- create_output_folder(
    data_name = data_name,
    results_dir = results_dir
  )
  output_path <- file.path(
    output_folder_path,
    paste0(
      data_name,
      "_boot_lr_",
      model_1,
      "_",
      model_2,
      "_",
      array_index,
      ".rds"
    )
  )
  saveRDS(
    output,
    file = output_path
  )
}
