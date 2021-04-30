test_that("check_repeated_seeds_long works no duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "no_dups", "old"
  )
  print("long")
  print(reference_path)
  print(list.files(reference_path))
  print(getwd())
  print(list.files(getwd()))
  print(list.files(file.path(getwd(), "testdata")))
  print(list.files(file.path(getwd(), "testdata", "testlogs")))
  print(list.files(file.path(getwd(), "testdata", "testlogs", "no_dups")))
  obtained_output <- check_repeated_seeds_long(logs_path = reference_path)
  expected_output <- data.frame(
    "Data" = character(),
    "Models" = character(),
    "Seeds" = numeric(),
    "Array_indices" = numeric()
  )
  expect_identical(object = obtained_output, expected = expected_output)
})

test_that("check_repeated_seeds_long works with duplicates", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")

  reference_path <- file.path(
    getwd(), "testdata", "testlogs", "dups", "old"
  )
  print("long")
  print(reference_path)
  print(list.files(reference_path))
  obtained_output <- check_repeated_seeds_long(logs_path = reference_path)
  expected_output <- data.frame(
    "Data" = "y_c_min",
    "Models" = "cr_dd_0laa",
    "Seeds" = 2922,
    "Array_indices" = 4
  )
  expect_identical(object = obtained_output, expected = expected_output)
})
