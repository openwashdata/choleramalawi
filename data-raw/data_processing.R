# Description ------------------------------------------------------------------
# R script to process uploaded raw data into a tidy, analysis-ready data frame
# Load packages ----------------------------------------------------------------
## Run the following code in console if you don't have the packages
## install.packages(c("usethis", "fs", "here", "readr", "tidyverse"))
library(usethis)
library(fs)
library(here)
library(readr)
library(tidyverse)
library(lubridate)

# Read data --------------------------------------------------------------------
data_in <- read.csv("data-raw/cholera_epi_weekly_district.csv")

# Tidy data --------------------------------------------------------------------
# Extract the names for all districts from the data (these are stored as column names)
# There are empty columns which R defines as X, X.1, X.2, etc. These need to be removed.
cols <- colnames(data_in)
districts <- cols[!grepl("^X[ .]*[0-9]*$", cols)]

# Updating the column names
new_colnames <- data_in[1, ]
data <- data_in |> slice(-1) |> set_names(new_colnames)

# First 3 columns are common across the data
# Post that every 4 columns represent a district
# We will melt the data to long format, however, due to the structure, inbuilt functions cannot be used
results_df <- data.frame()
index_df <- data |> select(all_of(1:3))
for (i in 1:((ncol(data)-3)/4)){
  district_data <- data.frame()
  district <- districts[i]
  selected_col = 4 * i
  district_data <- data |> select(all_of(selected_col:(selected_col+3)))
  colnames(district_data) <- c("cases", "deaths", "c_cases", "c_deaths")
  district_data$district <- district
  district_data <- cbind(index_df, district_data)
  if (i == 1){
    results_df <- district_data
  } else {
    results_df <- rbind(results_df, district_data)
  }
}

# Replace blank values with NAs
results_df <- results_df |> mutate_all(~na_if(., ""))

# Drop rows where all values are NA (except district)
results_df <- results_df |> filter(!is.na(cases) | !is.na(deaths) | !is.na(c_cases) | !is.na(c_deaths))

# Rename first 3 columns
results_df <- results_df |>
  rename("epi_week" = "Epi week", "week_start" = "Week start", "week" = "Week")

# Use lubridate to convert week column to dates
results_df$week <- dmy(results_df$week)

# Convert to numeric for cases, deaths, c_cases, c_deaths
results_df <- results_df |>
  mutate(across(cases:c_deaths, as.numeric))

choleramalawi <- results_df


# Export Data ------------------------------------------------------------------
usethis::use_data(choleramalawi, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(choleramalawi,
                 here::here("inst", "extdata", paste0("choleramalawi", ".csv")))
openxlsx::write.xlsx(choleramalawi,
                     here::here("inst", "extdata", paste0("choleramalawi", ".xlsx")))
