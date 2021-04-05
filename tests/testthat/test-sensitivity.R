test_that("sensitivity works", {
skip("WIP")
  data_name <- "Azores"
  model <- "cr_dd"
  seed <- 1
  cond <- 1
  results_folder <- dirname(create_output_folder(
    data_name = data_name,
    model = model,
    seed = seed
  ))

  # Place files need to run bootstrap
  reference_files <- list.files("testdata/", full.names = TRUE)
  expect_true(all(file.copy(reference_files, results_folder)))



  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
