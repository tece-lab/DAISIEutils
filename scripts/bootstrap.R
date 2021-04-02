args <- commandArgs(TRUE)

data(args[1], package = args[4])

DAISIEutils::bootstap(
  data = args[1],
  model_1 = args[2],
  model_2 = args[3],
  seed = as.numeric(args[5]),
  cond = as.numeric(args[6]))
