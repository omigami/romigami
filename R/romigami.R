# Title     : romigami
# Created by: pierre
# Created on: 02/06/2021

#' Creates a `reticulate` virtual environment and install the Python omigami package on it
#' @export
initialize_environment <- function(){
  reticulate::virtualenv_create("Romigami", python_version = "3.8")
  reticulate::use_virtualenv("Romigami", required = TRUE)
  reticulate::py_install("omigami")
}

#' Instantiates the Spec2Vec tool of the `Omigami` client and returns the n_best spectra matches for each input in mgf_path
#'
#' @param token Bearer token needed for authentication
#' @param mgf_path Path to the mgf file
#' @param n_best number of spectra matches to return for each spectrum input

#' @return A list of dataframes result
#' @export
match_spectra_from_path <- function(token, mgf_path, n_best){
  omigami <- reticulate::import("omigami")

  client <- omigami$Spec2Vec(token=token)
  results <- client$match_spectra_from_path(mgf_path=mgf_path, n_best=as.integer(n_best))

  return(results)
}
