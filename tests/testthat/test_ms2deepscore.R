library(testthat)
source("R/ms2deepscore.R")

test_that("integration is correct", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-2-EQUAL-SPECTRA.mgf")
  results <- predict_similarity_of_pair(token = "8DmWwNrFB8oSQcjHsEabHoNcUy30MZLY",
                                        mgf_path = mgf_path)
  expect_equal(results["Tanimoto Score"], 1)
})

test_that("token is invalid", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-2-SPECTRA.mgf")
  expect_error(
    predict_similarity_of_pair(token = "Random_token",
                               mgf_path = mgf_path),
    "InvalidCredentials: Your credentials are invalid, please revise your API token."
  )
})
