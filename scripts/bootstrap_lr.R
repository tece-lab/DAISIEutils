args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[4]))

if (identical(args[6], "NULL")) {
  DAISIEutils::bootstrap_lr(
    daisie_data = get(data_name),
    data_name = data_name,
    model_1 = args[2],
    model_2 = args[3],
    array_index = as.numeric(args[5]),
    cond = as.numeric(args[6]),
    results_dir = NULL,
    methode = args[8],
    optimmethod = args[9]
  )
} else if (identical(args[6], "NA")){
  DAISIEutils::bootstrap_lr(
    daisie_data = get(data_name),
    data_name = data_name,
    model_1 = args[2],
    model_2 = args[3],
    array_index = as.numeric(args[5]),
    cond = as.numeric(args[6]),
    results_dir = NA,
    methode = args[8],
    optimmethod = args[9]
  )
} else {
  DAISIEutils::bootstrap_lr(
    daisie_data = get(data_name),
    data_name = data_name,
    model_1 = args[2],
    model_2 = args[3],
    array_index = as.numeric(args[5]),
    cond = as.numeric(args[6]),
    results_dir = args[7],
    methode = args[8],
    optimmethod = args[9]
  )
}
