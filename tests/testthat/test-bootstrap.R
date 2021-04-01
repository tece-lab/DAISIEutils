test_that("bootstrap works", {
  # skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_name <- "Galapagos_datalist"
  data(Galapagos_datalist, package = "DAISIE")
  model <- "cr_dd"
  seed <- 1
  cond <- 1
  results_folder <- file.path("results", "Galapagos_datalist")

  # Place files need to run bootstrap
  reference_files <- list.files(
    "tests/testdata/",
    full.names = TRUE
  )
  expect_true(all(file.copy(reference_files, results_folder)))
  print(list.files(results_folder))

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

  expected_path <- readRDS(file.path(
    getwd(), "tests", "testdata", "Galapagos_datalist_boot_1.rds"
  ))
  expected_output <- readRDS(expected_path)

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
