# Description ------------------------------------------------------------------
# R script to process uploaded raw data into a tidy, analysis-ready data frame
# Load packages ----------------------------------------------------------------
## Run the following code in console if you don't have the packages
## install.packages(c("usethis", "fs", "here", "readr", "readxl", "openxlsx"))
library(usethis)
library(fs)
library(here)
library(readr)
library(readxl)
library(openxlsx)
library(dplyr)

# Read data --------------------------------------------------------------------
data_in <- read_excel("data-raw/RAW_DATA-water-points-SL.xlsx") |>
  janitor::clean_names()

# codebook <- readxl::read_excel("data-raw/codebook.xlsx") |>
#  clean_names()

# Tidy data --------------------------------------------------------------------

washdataportalsl <- data_in |>
  select(district:section, type_of_water_point)

washdataportalsl |>
  count(type_of_water_point) |> View()

# Export Data ------------------------------------------------------------------
usethis::use_data(washdataportalsl, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(washdataportalsl,
                 here::here("inst", "extdata", paste0("washdataportalsl", ".csv")))
openxlsx::write.xlsx(washdataportalsl,
                     here::here("inst", "extdata", paste0("washdataportalsl", ".xlsx")))
