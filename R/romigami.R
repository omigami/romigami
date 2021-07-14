# Title     : romigmi
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