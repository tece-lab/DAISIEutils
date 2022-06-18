args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[3]))

if (identical(args[6], "NULL")) {
  DAISIEutils::bootstrap(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = NULL,
    methode = args[7],
    optimmethod = args[8]
  )
} else if (identical(args[6], "NA")){
  DAISIEutils::bootstrap(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = NA,
    methode = args[7],
    optimmethod = args[8]
  )
} else {
  DAISIEutils::bootstrap(
    daisie_data = get(data_name),
    data_name = data_name,
    model = args[2],
    array_index = as.numeric(args[4]),
    cond = as.numeric(args[5]),
    results_dir = args[6],
    methode = args[7],
    optimmethod = args[8]
  )
}
