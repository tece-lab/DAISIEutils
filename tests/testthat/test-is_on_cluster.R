test_that("use", {
  # If HOSTNAME
  if (identical(Sys.getenv("HOSTNAME"), "peregrine.hpc.rug.nl")) {
    expect_true(is_on_cluster())

    Sys.unsetenv("HOSTNAME")
    expect_false(is_on_cluster())
    Sys.setenv(HOSTNAME = "peregrine.hpc.rug.nl")
  } else {
    stored_hostname <- Sys.getenv("HOSTNAME")
    expect_false(is_on_cluster())

    Sys.setenv(HOSTNAME = "peregrine.hpc.rug.nl")
    expect_true(is_on_cluster())
    Sys.setenv(HOSTNAME = stored_hostname)
  }
})
