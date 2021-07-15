<img src="./omigami-gradient.png" width="50%">

# R Omigami Client

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<!-- image:: https://img.shields.io/travis/datarevenue-berlin/omigami.svg :target: https://travis-ci.org/datarevenue-berlin/omigami -->

<!-- image:: https://readthedocs.org/projects/omigami/badge/?version=latest :target: https://omigami.readthedocs.io/en/latest/?badge=latest :alt: Documentation Status -->


An R client package to access Omigami services.

*Please note that R version >= 4.1.0 and the `devtools` library are required to install and use Omigami.*

## Installation

```r
devtools::install_github("omigami/romigami")
```

## Acknowledgement

### Spec2Vec 
Huber F, Ridder L, Verhoeven S, Spaaks JH, Diblen F, Rogers S, et al. (2021) Spec2Vec: Improved mass spectral similarity scoring through learning of structural relationships. PLoS Comput Biol 17(2): e1008724. https://doi.org/10.1371/journal.pcbi.1008724

### MS2DeepScore
Florian Huber, Sven van der Burg, Justin J.J. van der Hooft, Lars Ridder. (2021) MS2DeepScore - a novel deep learning similarity measure for mass fragmentation spectrum comparisons. bioRxiv 2021, doi: https://doi.org/10.1101/2021.04.18.440324

## Motivation

We aim to support metabolomics research by providing the following :
- **Easy-to-use** tools 
- **Access and scalability** to the newest algorithms
- **Maintenance, support and documentation** of software, models and data
- **A community** of metabolomics researchers via our [Slack](https://join.slack.com/t/ml4metabolomics/shared_invite/zt-r39udtdg-G36YE6GQt1YdVIwTdeT8aw)

## Features

- [x] Spec2Vec spectra matching
- [x] MS2DeepScore

## Usage

### Spec2Vec
#### Quickstart

```r
library(romigami)

omigami <- omigami_init()
client <- omigami$Spec2Vec(token="my_token")


mgf_file_path <- "path_to_file.mgf"
n_best_matches <- 10
include_metadata <- list("Smiles", "Compound_name")
ion_mode <- "positive"  # either positive or negative

results <- client$match_spectra_from_path(
                                   mgf_path = mgf_file_path,
                                   n_best = n_best_matches,
                                   include_metadata = include_metadata,
                                   ion_mode = ion_mode
) 
  ```
The supported metadata keys for omigami are (case insensitive):
- "smiles",
- "compound_name",
- "instrument",
- "parent_mass",
- "inchikey_smiles",
- "inchikey_inchi"

#### Notebooks
You can find a [tutorial](https://github.com/omigami/romigami/blob/master/notebook/spec2vec/tutorial.ipynb) notebook in the `/notebooks/` folder.

And an [R Markdown document](https://github.com/omigami/romigami/blob/master/vignettes/spec2vec/tutorial.Rmd) on the `/vignettes/` folder.

### MS2DeepScore
#### Quickstart

```r
library(romigami)

omigami <- omigami_init()
client <- omigami$MS2DeepScore(token="my_token")

mgf_file_path <- "path_to_file.mgf"
n_best_matches <- 10
include_metadata <- list("Smiles", "Compound_name")
ion_mode <- "positive"  # either positive or negative

results <- client$match_spectra_from_path(
                                   mgf_path = mgf_file_path,
                                   n_best = n_best_matches,
                                   include_metadata = include_metadata,
                                   ion_mode = ion_mode
)
  ```

#### MS2DeepScore Notebooks
You can find a [tutorial](https://github.com/omigami/romigami/blob/master/notebook/ms2deepscore/tutorial.ipynb) notebook in the `/notebooks/` folder.

And an [R Markdown document](https://github.com/omigami/romigami/blob/master/vignettes/ms2deepscore/tutorial.Rmd)) on the `/vignettes/` folder.


## How it works

### Spec2Vec
1. Save your spectra data in a MGF file locally
2. Create an Spec2Vec with your user token
3. Call `match_spectra_from_path` with the location of your mgf file.
4. The MGF spectra data will be processed and sent to the spec2vec model that will convert it into embeddings. 
5. These embeddings will be compared against the reference embeddings around the Precursor MZ.
6. The N best matches per spectrum are returned on the response as pandas dataframes.  

### MS2DeepScore
1. Save your pair of spectra data in a MGF file locally
2. Create an MS2DeepScore with your user token
3. Call `match_spectra_from_path` with the location of your mgf file.
4. The MGF spectra data will be processed and sent to the trained neural network that will predict the molecular structural similarity. 
5. The prediction is returned on the response as a dictionary.

## Contribute to Omigami

1. Fork it (https://github.com/omigami/omigami/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request

## License
MIT license - free software.