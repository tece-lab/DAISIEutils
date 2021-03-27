test_that("Style is good", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  lintr::expect_lint_free()
})
