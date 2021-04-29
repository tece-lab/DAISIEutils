test_that("check_repeated_seeds works no duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "current"
  )
  print(reference_path)
  obtained_output <- check_repeated_seeds(logs_path = reference_path)
  expected_output <- list(
    duplicated_seeds = character(),
    duplicated_array_indices = character()
  )
  expect_identical(object = obtained_output, expected = expected_output)
})
