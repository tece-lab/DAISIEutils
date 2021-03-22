test_that("load_txt_results works", {

  file_path <- create_output_folder(
    output_name = "Galapagos_datalist",
    model = 1
  )

  output_file_header <- c(
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

  write(
    output_file_header,
    file = file_path,
    ncolumns = length(output_file_header),
    sep = "\t"
  )


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

  write.table(
    expected_data_frame,
    file = file_path,
    append = TRUE,
    col.names = FALSE,
    row.names = FALSE,
    sep = "\t"
  )
  output_df <- load_txt_results(dirname(dirname(file_path)))
  colnames(expected_data_frame) <- output_file_header
  expected_tibble <- tibble::tibble_row(expected_data_frame)
  expect_equal(
    expected = expected_tibble,
    object = output_df[], # Need to remove class(output_df) == "spec_tbl_df"
    tolerance = 1e-6
  )

  # Clean-up
  expect_equal(unlink("results", recursive = TRUE), 0)
})
