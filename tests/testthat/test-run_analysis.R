test_that("integration test", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data(Galapagos_datalist, package = "DAISIE")
  m <- 50
  model <- 1
  seed <- 1

  file_path <- create_output_folder(output_name = "test_name", model = model)

  run_analysis(
    datalist = Galapagos_datalist, # nolint
    m = m,
    model = model,
    seed = seed,
    file_path = file_path
  )
  test_results <- read.delim(file_path, header = FALSE)
  column_names <- colnames(test_results[1, ])

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
  colnames(expected_data_frame) <- column_names
  expect_equal(expected_data_frame, test_results[1, ],
               tolerance = 1e-6)
  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
