test_that("check_repeated_seeds works no duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "no_dups", "current"
  )

  # Suppress message, still test
  obtained_output <- suppressMessages(
    check_rep_seeds(logs_path = reference_path)
  )
  expected_output <- data.frame(
    "Data" = character(),
    "Models" = character(),
    "Seeds" = numeric(),
    "Array_indices" = numeric()
  )
  expect_identical(object = obtained_output, expected = expected_output)
})

test_that("check_repeated_seeds works with duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "dups", "current"
  )

  # Suppress message, still test
  obtained_output <- suppressMessages(
    check_rep_seeds(logs_path = reference_path)
  )
  expected_output <- data.frame(
    "Data" = "Aldabra_Group",
    "Models" = "cr_di",
    "Seeds" = 2994,
    "Array_indices" = 9
  )
  expect_identical(object = obtained_output, expected = expected_output)
})
