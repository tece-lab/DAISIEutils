test_that("calc_p_value produces correct output", {
  skip("WIP")
  data("Galapagos_datalist", package = "DAISIE")
  output <- calc_p_value(data = Galapagos_datalist)
  expected_output <- 0.904095904096
  expect_equal(output, expected_output)
})

test_that("calc_p_value produces error", {
  expect_error(calc_p_value(data = "nonsense"))
})
