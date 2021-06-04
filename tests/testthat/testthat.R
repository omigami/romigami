library(testthat)
library(romigami)

test_that("integration is correct", {
  initialize_environment()
  results <- match_spectra_from_path("8DmWwNrFB8oSQcjHsEabHoNcUy30MZLY",
                        "/Users/pierre/Downloads/GNPS-COLLECTIONS-MISC.mgf",
                        10)
  expect_equal(length(results), 46)
})

test_that("invalid credentials", {
  initialize_environment()
  expect_error(
    match_spectra_from_path("Random_token",
                        "/Users/pierre/Downloads/GNPS-COLLECTIONS-MISC.mgf",
                        10),
    "InvalidCredentials: Your credentials are invalid, please revise your API token."
  )
})