test_that("check_rep_seeds_depr works no duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "no_dups", "deprecated"
  )

  # Suppress message, still test
  obtained_output <- suppressMessages(
    check_rep_seeds_depr(logs_path = reference_path)
  )
  expected_output <- data.frame(
    "Data" = character(),
    "Models" = character(),
    "Seeds" = numeric(),
    "Array_indices" = numeric()
  )
  expect_identical(object = obtained_output, expected = expected_output)
})

test_that("check_rep_seeds_depr works with duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "dups", "deprecated"
  )

  # Suppress message, still test
  obtained_output <- suppressMessages(
    check_rep_seeds_depr(logs_path = reference_path)
  )
  expected_output <- data.frame(
    "Data" = rep("y_c_min", 2),
    "Models" = rep("cr_dd_0laa", 2),
    "Seeds" = rep(2922, 2),
    "Array_indices" = c(3, 4)
  )
  expect_identical(object = obtained_output, expected = expected_output)
})
