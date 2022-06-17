args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[3]))
if (identical(args[8], "NULL")) {
  DAISIEutils::run_daisie_ml(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = NULL,
    methode = args[7],
    optimmethod = args[8],
    low_rates = as.logical(args[9])
  )
} else if (identical(args[8], "NA")){
  DAISIEutils::run_daisie_ml(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = NA,
    methode = args[7],
    optimmethod = args[8],
    low_rates = as.logical(args[9])
  )
} else {
  DAISIEutils::run_daisie_ml(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = args[6],
    methode = args[7],
    optimmethod = args[8],
    low_rates = as.logical(args[9])
  )
}
