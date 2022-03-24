# Uploads results directory to google drive
# Make sure to manually configure token first

project_name <- basename(getwd())
message(
  "Attempting to upload results and logs from ", project_name,
  " to google drive.")

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

time_suffix <- format(Sys.time(), "%H%M_%d%m%Y")
results_upload_name <- paste("results", project_name, time_suffix, sep = "_")
logs_upload_name <- paste("logs_", project_name, time_suffix, sep = "_")

# Use cached token
options(gargle_oauth_email = TRUE)

# Upload files
googledrive::drive_upload(
  media = "results.zip",
  path = paste0("inflow_r/", results_upload_name)
)

googledrive::drive_upload(
  media = "logs.zip",
  path = paste0("inflow_r/", logs_upload_name)
)

# Clean up
if (isTRUE(all(file.remove("results.zip"), file.remove("logs.zip")))) {
  message("Temporary files deleted successfully.")
}

if (isTRUE(any(file.exists("results.zip"), file.exists("logs.zip")))) {
  stop("Unable do delete temporary .zip files. Please delete manually.")
}
