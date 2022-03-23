# Uploads results directory to google drive
# Run this script interactively first to set up google drive OAUTH
results_present <- dir.exists("results")
logs_present <- dir.exists("logs")
if (isTRUE(all(logs_present, results_present))) {
  zip("results.zip", "results")
  zip("logs.zip", "logs")
} else {
  stop("results folder not found")
}

if (isFALSE("googledrive" %in% rownames(installed.packages()))) {
  install.packages("googledrive")
}

options(gargle_oauth_email = TRUE)

time_suffix <- format(Sys.time(), "%H%M_%d%m%Y")
results_upload_name <- paste0("results_", time_suffix)
logs_upload_name <- paste0("logs_", time_suffix)

googledrive::drive_upload(
  media = "results.zip",
  path = paste0("inflow_r/", results_upload_name)
)

googledrive::drive_upload(
  media = "logs.zip",
  path = paste0("inflow_r/", logs_upload_name)
)

# Clean up
file.remove("results.zip")
file.remove("logs.zip")

if (isFALSE(any(file.exists("results.zip"), file.exists("logs.zip")))) {

}
