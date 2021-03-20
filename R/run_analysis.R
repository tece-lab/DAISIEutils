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
#'   model = 1,
#'   seed = 1,
#'   file_path
#' )
#' }
#' @author Pedro Neves, Luis Valente
run_analysis <- function(datalist,
                         datalist_name,
                         m,
                         model,
                         seed,
                         file_path) {

  island_age <- datalist[[1]]$island_age

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
  methode <- "lsodes"
  cond <- 1
  res <- 100
  complete_initparsopt <- model_arguments$complete_initparsopt

  ##### RUN1 ML Optimization
  lik_res <- DAISIE::DAISIE_ML(
    datalist = datalist,
    initparsopt = initparsopt,
    idparsnoshift = idparsnoshift,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    ddmodel = ddmodel,
    methode = methode,
    cond = cond,
    res = res
  )

  lik_res <- as.matrix(lik_res)
  to_write <- c(
    datalist_name,
    model,
    seed,
    island_age,
    m,
    type,
    p_type2,
    res,
    methode,
    "R1",
    as.matrix(lik_res),
    complete_initparsopt
  )
  write(
    to_write,
    file = file_path,
    ncolumns = length(to_write),
    append = TRUE,
    sep = "\t"
  )

  ##### RUN2 ML Optimization

  initparsopt <- lik_res[idparsopt]


  lik_res <- DAISIE::DAISIE_ML(
    datalist = datalist,
    initparsopt = initparsopt,
    idparsnoshift = idparsnoshift,
    idparsopt = idparsopt,
    parsfix = parsfix,
    idparsfix = idparsfix,
    ddmodel = ddmodel,
    methode = methode,
    cond = cond,
    res = res
  )

  lik_res <- as.matrix(lik_res)
  to_write <- c(
    datalist_name,
    model,
    seed,
    island_age,
    m,
    type,
    p_type2,
    res,
    methode,
    "R2",
    as.matrix(lik_res),
    complete_initparsopt
  )
  write(
    to_write,
    file = file_path,
    ncolumns = length(to_write),
    append = TRUE,
    sep = "\t"
  )
}
