library(testthat)
library(yaml)
source("../../R/romigami.R")

test_that("integration is correct", {

  mgf_path <- paste0(dirname(getwd()), "/assets/GNPS-COLLECTIONS-MISC.mgf")
  config_path <- file.path("~/.config/omigami/config.yaml")
  config <- yaml::yaml.load_file(input = config_path)
  token <- config$login$dev$token

  omigami <- omigami_init()
  client <- omigami$Spec2Vec(token=token)
  results <- client$match_spectra_from_path(
                      mgf_path, 10, list("Smiles", "Compound_name"), "positive"
            )

  expect_equal(length(results), 46)
})

test_that("token is invalid", {

  mgf_path <- paste0(dirname(getwd()), "/assets/GNPS-COLLECTIONS-MISC.mgf")

  omigami <- omigami_init()
  client <- omigami$Spec2Vec(token="Random Token")


  expect_error(
    client$match_spectra_from_path(mgf_path = mgf_path,
                            n_best = 10,
                            include_metadata = list("Smiles", "Compound_name"),
                            ion_mode = "positive"),
    "InvalidCredentials: Your credentials are invalid, please revise your API token."
  )
})
