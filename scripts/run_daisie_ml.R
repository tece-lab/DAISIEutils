args <- commandArgs(TRUE)
print(args)
print(length(args))
if (args[10] == "NULL") {
  data_name <- do.call(data, args = list(args[1], package = args[3]))
  daisie_data <- get(data_name)
} else {
  rep <- as.numeric(args[10])
  data_name <- do.call(data, args = list(args[1], package = args[3]))
  print(get(data_name))
  daisie_data <- get(data_name)[[rep]]
  print(daisie_data)
}

if (identical(args[6], "NULL")) {
  DAISIEutils::run_daisie_ml(
    daisie_data = daisie_data,
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = NULL,
    methode = args[7],
    optimmethod = args[8],
    low_rates = as.logical(args[9])
  )
} else if (identical(args[6], "NA")){
  DAISIEutils::run_daisie_ml(
    daisie_data = daisie_data,
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
    daisie_data = daisie_data,
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
