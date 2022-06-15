test_that("sensitivity works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_names <- c("Azores", "Azores_alt_m")

  # Place files need for sensitivity
  reference_files <- list.files(
    file.path("testdata", "results"),
    full.names = TRUE,
    pattern = "Azores_cr_d*",
    recursive = TRUE
  )
  reference_files_alt <- list.files(
    file.path("testdata", "results"),
    full.names = TRUE,
    pattern = "Azores_alt_m_d*",
    recursive = TRUE
  )
  temp_dir <- tempdir()
  azores_folder <- create_output_folder(
    data_name = data_names[1],
    results_dir = temp_dir
  )
  azores_alt_m_folder <- create_output_folder(
    data_name = data_names[2],
    results_dir = temp_dir
  )

  expect_true(all(file.copy(reference_files, azores_folder)))
  expect_true(all(file.copy(reference_files_alt, azores_alt_m_folder)))

  obtained_result <- sensitivity(
    data_names = data_names,
    full_output = TRUE,
    results_dir = temp_dir
  )

  expected_result <- readRDS(file.path("testdata", "Azores_Azores_alt_m.rds"))

  expect_equal(object = obtained_result, expected = expected_result)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
  expect_equal(unlink(file.path(getwd(), "tempdir"), recursive = TRUE), 0)
})
