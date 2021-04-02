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
    file.path(getwd(), "testdata/"),
    full.names = TRUE
  )

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

  expected_output <- readRDS(file.path(
    "tests", "testdata", "Galapagos_datalist_boot_1.rds"
  ))

  expect_equal(actual_output, expected_output)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
