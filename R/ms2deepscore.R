# Title     : ms2deepscore
# Created by: Data Revenue
# Created on: 22/06/2021

#' Creates a `reticulate` virtual environment and install the Python omigami package on it
#' @export
initialize_environment <- function(){
  reticulate::virtualenv_create("Romigami", python_version = "3.8")
  reticulate::use_virtualenv("Romigami", required = TRUE)
  reticulate::py_install("omigami")
}

#' Instantiates the MS2DeepScore tool of the `Omigami` client and returns a prediction for the structural similitarity
#' of two spectra
#'
#' @param token Bearer token needed for authentication
#' @param mgf_path Path to the mgf file with two spectra

#' @return A dictionary with the Tanimoto score
#' @export
predict_similarity_of_pair <- function(token, mgf_path){
  omigami <- reticulate::import("omigami")

  client <- omigami$MS2DeepScore(token=token)
  results <- client$predict_similarity_of_pair(mgf_path=mgf_path)

  return(results)
}
