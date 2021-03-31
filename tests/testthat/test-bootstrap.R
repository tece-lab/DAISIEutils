test_that("bootstrap works", {
  data_name <- "Galapagos_datalist"
  model <- "cr_dd"
  seed <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  ))

  reference_files <- list.files("tests/testdata/", full.names = TRUE)
  expect_true(all(file.copy(reference_files, results_folder)))

  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
