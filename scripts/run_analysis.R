args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[3]))

DAISIEutils::run_analysis(
  data = get(data_name),
  data_name = data_name,
  model = args[2],
  seed = as.numeric(args[4]),
  cond = as.numeric(args[5]))
