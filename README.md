
# DAISIEutils

<!-- badges: start -->
![GitHub R package version](https://img.shields.io/github/r-package/v/tece-lab/DAISIEutils)
[![R-CMD-check](https://github.com/tece-lab/DAISIEutils/workflows/R-CMD-check/badge.svg)](https://github.com/tece-lab/DAISIEutils/actions)
[![Codecov test coverage](https://codecov.io/gh/tece-lab/DAISIEutils/branch/master/graph/badge.svg)](https://codecov.io/gh/tece-lab/DAISIEutils?branch=master)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4721424.svg)](https://doi.org/10.5281/zenodo.4721424)
<!-- badges: end -->

The goal of DAISIEutils is to collect useful utility functions that are used recurrently in DAISIE projects. DAISIEutils is a companion package of the R package [DAISIE](https://github.com/rsetienne/DAISIE).
This includes pipelines for typical analyses using the DAISIE's maximum likelihood inference.

## Installation

You can install the released version of DAISIEutils from [GitHub](https://github.com/tece-lab/DAISIEutils) with:

``` r
install.packages("remotes")
remotes::install_github("tece-lab/DAISIEutils")
```

## Features

DAISIEutils allows a researcher to easily accomplish the following tasks:

* Choose and specify any number of common DAISIE models, with different combinations of free and initial parameters.
* Fit said models to data, sampling from a number of initial parameters to minimize model convergence on local optima.
* Choose best fitting models.
* Run bootstrap likelihood ratio tests.
* Test the sensitivity of results to changing data sets.
