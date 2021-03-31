test_that("bootstrap works", {
  data_name <- "Galapagos_datalist"
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  ))

  # Place files need to run bootstrap
  reference_files <- list.files("tests/testdata/", full.names = TRUE)
  expect_true(all(file.copy(reference_files, results_folder)))


  bootstap(
    data = Galapagos_datalist,
    model_1 = "cr_dd",
    model_2 = "cr_di",
    seed = seed,
    cond = cond
  )
  actual_output <- readRDS(
    "results/Galapagos_datalist/Galapagos_datalist_boot_1.rds"
  )
  expected_output <- readRDS("tests/testdata/Galapagos_datalist_boot_1.rds")

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
