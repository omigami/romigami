# Title     : romigami
# Created by: Data Revenue
# Created on: 02/06/2021
# Updated on: 13/07/2021

#' Initialize environment and import Omigami module
#' @return Omigami module
#' @export
omigami_init <- function(){
  reticulate::virtualenv_create("Romigami", python_version = "3.8")
  reticulate::use_virtualenv("Romigami", required = TRUE)
  reticulate::py_install("omigami")

  omigami <- reticulate::import("omigami")

  return (omigami)
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