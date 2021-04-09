args <- commandArgs(TRUE)

data_name <- do.call(data, args = list(args[1], package = args[4]))

DAISIEutils::bootstrap_lr(
  data = get(data_name),
  data_name = data_name,
  model_1 = args[2],
  model_2 = args[3],
  seed = as.numeric(args[5]),
  cond = as.numeric(args[6]))
