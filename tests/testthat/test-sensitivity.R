test_that("sensitivity works", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  data_names <- c("Azores", "Azores_alt_m")

  # Place files need for sensitivity
  reference_files <- list.files(
    file.path(getwd(), "testdata/"), full.names = TRUE, pattern = "*.rds"
  )
  azores_filepath <- create_output_folder(
    data_name = data_names[1],
    model = "cr_di",
    array_index = 1
  )
  azores_alt_m_filepath <- create_output_folder(
    data_name = data_names[2],
    model = "cr_di",
    array_index = 1
  )

  azores_folder <- dirname(azores_filepath)
  expect_true(all(file.copy(reference_files, azores_folder)))

  azores_alt_m_folder <- dirname(azores_alt_m_filepath)
  expect_true(all(file.copy(reference_files, azores_alt_m_folder)))

  obtained_result <- sensitivity(data_names = data_names, full_output = TRUE)

  expected_result <- readRDS(file.path(
    getwd(), "testdata/Azores_Azores_alt_m.rds")
  )

  expect_equal(object = obtained_result, expected = expected_result)

  # Delete temp folder
  expect_equal(unlink(file.path(getwd(), "results"), recursive = TRUE), 0)
})
