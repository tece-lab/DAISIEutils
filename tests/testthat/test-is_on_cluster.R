test_that("use", {
  # If HOSTNAME
  if (identical(Sys.getenv("SLURM_CLUSTER_NAME"), "habrok")) {
    expect_true(is_on_cluster())

    Sys.unsetenv("SLURM_CLUSTER_NAME")
    expect_false(is_on_cluster())
    identical(Sys.getenv("SLURM_CLUSTER_NAME"), "habrok")
  } else {
    stored_cluster_name <- Sys.getenv("SLURM_CLUSTER_NAME")
    expect_false(is_on_cluster())

    Sys.setenv(SLURM_CLUSTER_NAME = "habrok")
    expect_true(is_on_cluster())
    Sys.setenv(SLURM_CLUSTER_NAME = stored_cluster_name)
  }
})
