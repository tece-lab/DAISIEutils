% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_p_value.R
\name{calc_p_value}
\alias{calc_p_value}
\title{Calculates p-value for rejecting a model from a distribution of likelihood
ratios}
\usage{
calc_p_value(daisie_data, results_dir = NULL)
}
\arguments{
\item{daisie_data}{A list, conforming to the \code{\link{DAISIE}} object format.
Usually preprocessed by \code{\link[DAISIE:DAISIE_dataprep]{DAISIE::DAISIE_dataprep()}}, see it's documentation
for details. Otherwise it may be generated via simulations, using
\code{\link[DAISIE:DAISIE_sim]{DAISIE::DAISIE_sim_cr()}} and friends.}

\item{results_dir}{A string with the path to the directory where results
are to be stored or can be found. For example, if the data in question
is (to be) stored in \verb{folder_with_res/$data_name}, then \code{results_dir}
should be \code{"folder_with_res"}.
Defaults to \code{NULL}, which indicates the default directories are to be used.
Default directories are:
* \verb{$HOME/results/$data_name} if on the cluster
* \verb{getwd()/results/$data_name} if called from another environment
If \code{is.na(results_dir)}, then the object is returned to the R session and
not saved to file.}
}
\value{
Numeric p-value
}
\description{
Calculates p-value for rejecting a model from a distribution of likelihood
ratios
}
