library(testthat)
library(romigami)

test_that("integration is correct", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-COLLECTIONS-MISC.mgf")
  token <- Sys.getenv("ROMIGAMI_TOKEN")
  results <- match_spectra_from_path(token = token,
                                     mgf_path = mgf_path,
                                     n_best = 10)
  expect_equal(length(results), 46)
})

test_that("token is invalid", {
  initialize_environment()
  mgf_path <- paste0(dirname(getwd()), "/romigami/tests/assets/GNPS-COLLECTIONS-MISC.mgf")
  expect_error(
    match_spectra_from_path(token = "Random_token",
                            mgf_path = mgf_path,
                            n_best = 10),
    "InvalidCredentials: Your credentials are invalid, please revise your API token."
  )
})
