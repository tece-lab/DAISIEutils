test_that("default dir works", {
  file_path <- create_results_dir_path(data_name = "test")
  expect_equal(
    file_path,
    file.path("results", "test")
  )
})

test_that("custom dir works", {
  file_path <- create_results_dir_path(
    data_name = "test",
    results_dir = "results_folder"
  )
  expect_equal(
    file_path,
    file.path("results_folder", "test")
  )
})
