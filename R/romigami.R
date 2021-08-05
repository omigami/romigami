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
#' @param include_metadata Metadata keys to include in the response. Will make response slower.
#' Please check the documentation for a list of valid keys.
#' @param ion_mode Selects which model will be used for the predictions:
#' Either a model trained with positive or negative ion mode spectra data. Defaults to positive.

#' @return A list of dataframes result
#' @export
match_spectra_from_path <- function(token, mgf_path, n_best, include_metadata, ion_mode){
  omigami <- reticulate::import("omigami")

  client <- omigami$Spec2Vec(token=token)
  results <- client$match_spectra_from_path(mgf_path,
                                            as.integer(n_best),
                                            include_metadata,
                                            ion_mode)

  return(results)
}


#' Generate a grid image representation of the hits returned from Spec2Vec and MS2DeepScore outputs.
#' All structures passed MUST have valid smiles or inchi representations.
#'
#' @param spectra_matches DataFrame resulting from either Spec2Vec or MS2DeepScore. Need to feature smiles or inchi, score and compound_name as columns.
#' @param representation The representation of the molecules found in the provided dataframe
#' @param draw_indices If true draws the indices of the atoms
#' @param molecule_image_size The size of every individual image of a molecule. Need to be provided as a list with two ints.
#' @param substructure_highlight Needs to be a molecule substructure represented as a smiles.

#' @return A image of the molecules
#' @export
plot_molecule_structure_grid <- function(spectra_matches, representation, draw_indices, molecule_image_size, substructure_highlight){
  omigami <- reticulate::import("omigami")

  plotter <- omigami$MoleculePlotter()
  results <- plotter$plot_molecule_structure_grid(spectra_matches = spectra_matches,
                                                  representation = representation,
                                                  draw_indices = draw_indices,
                                                  molecule_image_size = molecule_image_size,
                                                  substructure_highlight = substructure_highlight)

  return(results)
}


#' Uses the ClassyFire API to classify and plot a barchart of the classifications
#'
#' @param spectra_matches DataFrame resulting from either Spec2Vec or MS2DeepScore. Need to feature smiles or inchi, score and compound_name as columns.
#' @param color Color of the displayed bars


#' @return A Barplot displaying the best matches
#' @export
plot_classyfire_result <- function(spectra_matches, color){
  omigami <- reticulate::import("omigami")

  plotter <- omigami$MoleculePlotter()
  results <- plotter$plot_classyfire_result(spectra_matches = spectra_matches,
                                            color = color)

  return(results)
}

#' Uses the NP-Classifier API to classify natural products.
#'
#' @param spectra_matches DataFrame resulting from either Spec2Vec or MS2DeepScore. Need to feature smiles or inchi, score and compound_name as columns.
#' @param color Color of the displayed bars


#' @return A Barplot displaying the best matches
#' @export
plot_NPclassifier_result <- function(spectra_matches, color){
  omigami <- reticulate::import("omigami")

  plotter <- omigami$MoleculePlotter()
  results <- plotter$plot_NPclassifier_result(spectra_matches = spectra_matches,
                                              color = color)

  return(results)
}