library(testthat)
library(yaml)
source("R/romigami.R")

test_that("integration is correct", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-COLLECTIONS-MISC.mgf")
  config_path <- file.path("~/.config/omigami/config.yaml")
  config <- yaml::yaml.load_file(input = config_path)
  token <- config$login$dev$token
  results <- match_spectra_from_path(token,
                                     mgf_path,
                                     10,
                                     list("Smiles", "Compound_name"),
                                     "positive"
  )
  expect_equal(length(results), 46)
})

test_that("token is invalid", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-COLLECTIONS-MISC.mgf")
  expect_error(
    match_spectra_from_path(token = "Random_token",
                            mgf_path = mgf_path,
                            n_best = 10,
                            include_metadata = list("Smiles", "Compound_name"),
                            ion_mode = "positive"),
    "InvalidCredentials: Your credentials are invalid, please revise your API token."
  )
})
