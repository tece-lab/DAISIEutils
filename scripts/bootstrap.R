args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[3]))

DAISIEutils::bootstrap(
  daisie_data = get(data_name),
  data_name = data_name,
  model = args[2],
  array_index = as.numeric(args[4]),
  cond = as.numeric(args[5]),
  optimmethod = args[6]
)
