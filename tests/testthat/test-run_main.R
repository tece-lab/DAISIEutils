test_that("run_main works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  data(Galapagos_datalist, package = "DAISIE")
  datalist_name <- "Galapagos_datalist"
  M <- 50
  model <- 1
  seed <- 1
  # file_path <- create_output_folder(output_name = datalist_name, model = model)

  run_main(
    datalist = Galapagos_datalist,
    m = m,
    model = model,
    seeds = seed
  )

  Galapagos_datalist_results <- read.delim(file_path, header = TRUE)

  expected_data_frame <- data.frame(
    "Galapagos_datalist",
    1,
    1,
    4,
    50,
    1,
    0,
    100,
    "lsodes",
    "R1",
    2.578389,
    2.704829,
    3074.828,
    0.009357763,
    1.003214,
    -75.99996,
    5,
    0,
    0.5310173,
    0.7442478,
    117.1336,
    9.082078e-05,
    0.8865595
  )
  colnames(expected_data_frame) <- c(
    "datalist_name",
    "model",
    "seed",
    "island_age",
    "M",
    "type",
    "p_type2",
    "res",
    "methode",
    "run_number",
    "lambda_c",
    "mu",
    "K",
    "gamma",
    "lambda_a",
    "loglik",
    "df",
    "conv",
    "initparsopt_lac",
    "initparsopt_mu",
    "initparsopt_K",
    "initparsopt_gamma",
    "initparsopt_laa"
  )
  expect_equal(
    expected = expected_data_frame,
    object = Galapagos_datalist_results[1, ],
    tolerance = 1e-6
  )
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
