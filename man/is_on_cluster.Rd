% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_on_cluster.R
\name{is_on_cluster}
\alias{is_on_cluster}
\title{Check if code is running on Peregrine HPCC}
\usage{
is_on_cluster()
}
\value{
Boolean. \code{TRUE} if called from Peregrine HPCC, FALSE if not.
}
\description{
Check if code is running on Peregrine HPCC
}
\examples{
on_cluster <- is_on_cluster()

}
\author{
Pedro Neves
}