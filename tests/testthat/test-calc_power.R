test_that("calc_power produces correct output", {
  skip("WIP")
  data("Galapagos_datalist", package = "DAISIE")
  output <- calc_power(data = Galapagos_datalist)
  expected_output <- 0.904095904096
  expect_equal(output, expected_output)
})

test_that("calc_power produces error", {
  expect_error(calc_power(data = "nonsense"))
})
