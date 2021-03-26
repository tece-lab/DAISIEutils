args <- commandArgs(TRUE)

data(args[1], package = args[3])

DAISIEutils::run_analysis(data = args[1],
                          model = args[2],
                          seed = as.numeric(args[4]),
                          cond = as.numeric(args[5]))
