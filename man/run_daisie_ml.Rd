% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_daisie_ml.R
\name{run_daisie_ml}
\alias{run_daisie_ml}
\title{Run DAISIE analysis}
\usage{
run_daisie_ml(
  daisie_data,
  data_name,
  model,
  array_index,
  cond,
  methode = "lsodes",
  optimmethod = "subplex",
  results_dir = NULL,
  low_rates = FALSE,
  rep_index = "NULL",
  res = 100,
  par_upper_bound = Inf,
  test = FALSE
)
}
\arguments{
\item{daisie_data}{A list, conforming to the \code{\link{DAISIE}} object format.
Usually preprocessed by \code{\link[DAISIE:DAISIE_dataprep]{DAISIE::DAISIE_dataprep()}}, see it's documentation
for details. Otherwise it may be generated via simulations, using
\code{\link[DAISIE:DAISIE_sim]{DAISIE::DAISIE_sim_cr()}} and friends.}

\item{data_name}{String. Will be used for the name of the created output
folder.}

\item{model}{A string with model that should run. Models are as follows:
\itemize{
\item \code{"cr_dd"} Clade specific model - diversity dependent. All parameters
free.
\item \code{"cr_di"} Clade specific model - diversity independent (K = Inf). All
other parameters free.
\item \code{"cr_dd_0laa"} Clade specific model - diversity dependent and no
anagenesis (laa fixed to zero). All other parameters free.
\item \code{"cr_di_0laa"} Clade specific model - diversity independent (K = Inf)
and no anagenesis (laa fixed to zero). All other parameters free.
\item \code{"cr_di_0lac"} Clade specific model - diversity indendent (K = Inf)
and no cladogenesis (lac fixed to zero). All other parameters free.
\item \code{"cr_dd_0lac"} Clade specific model - diversity dependent and no
cladogenesis (lac fixed to zero). All other parameters free.
\item \code{"rr_lac_di"} Clade specific model - diversity independent (K = Inf)
and relaxed cladogenesis. All other parameters free.
\item \code{"rr_lac_dd"} Clade specific model - diversity dependent and relaxed
cladogenesis. All other parameters free.
\item \code{"rr_mu_di"} Clade specific model - diversity independent (K = Inf) and
relaxed extinction. All other parameters free.
\item \code{"rr_mu_dd"} Clade specific model - diversity dependent and relaxed
extinction. All other parameters free.
\item \code{"rr_k"} Clade specific model - diversity dependent and relaxed carrying
capacity. All other parameters free.
\item \code{"rr_gam_di"} Clade specific model - diversity independent (K = Inf)
and relaxed colonisation. All other parameters free.
\item \code{"rr_gam_dd"} Clade specific model - diversity dependent and relaxed
colonisation. All other parameters free.
\item \code{"rr_laa_di"} Clade specific model - diversity independent (K = Inf)
and relaxed anagenesis. All other parameters free.
\item \code{"rr_laa_dd"} Clade specific model - diversity dependent and relaxed
anagenesis. All other parameters free.
\item \code{"rr_mu_di_0lac"} Clade specific model - diversity independent,
relaxed extinction, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"rr_mu_dd_0lac"} Clade specific model - diversity dependent, relaxed
extinction, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"rr_k_0lac"} Clade specific model - diversity dependent, relaxed
carrying capacity, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"rr_gam_di_0lac"} Clade specific model - diversity independent,
relaxed colonisation, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"r_gam_dd_0lac"} Clade specific model - diversity dependent, relaxed
colonisation, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"rr_laa_di_0lac"} Clade specific model - diversity independent,
relaxed anagenesis, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"r_laa_dd_0lac"} Clade specific model - diversity dependent, relaxed
anagenesis, and no cladogenesis (lac fixed to zero). All other
parameters free.
\item \code{"rr_lac_di_0laa"} Clade specific model - diversity independent,
relaxed cladogenesis, and no anagenesis (laa fixed to zero)
\item \code{"rr_lac_dd_0laa"} Clade specific model - diversity dependent
\item \code{"rr_mu_di_0laa"} Clade specific model - diversity independent
\item \code{"rr_mu_dd_0laa"} Clade specific model - diversity dependent
\item \code{"rr_k_0laa"} Clade specific model - diversity dependent
\item \code{"rr_gam_di_0laa"} Clade specific model - diversity independent, relaxed
colonisation, and no anagenesis (laa fixed to zero). All other parameters
free
\item \code{"rr_gam_dd_0laa"} Clade specific model - diversity dependent, relaxed
colonisation, and no anagenesis (laa fixed to zero). All other parameters
free
}}

\item{array_index}{A single numeric with the array index. It is used for
naming the output file.}

\item{cond}{An integer specifying conditioning, as described in
\code{\link[DAISIE:DAISIE_ML]{DAISIE::DAISIE_ML_CS()}}.}

\item{methode}{Method of the ODE-solver. Supported Boost \code{ODEINT}
solvers (steppers) are:
\code{"odeint::runge_kutta_cash_karp54"}
\code{"odeint::runge_kutta_fehlberg78"}
\code{"odeint::runge_kutta_dopri5"}
\code{"odeint::bulirsch_stoer"}
without \verb{odeint::}-prefix, \verb{\link{deSolve}{ode}()} method is
assumed. The default method overall is
\code{"lsodes"} for \verb{\link{DAISIE_ML_CS}()}
and \code{"ode45"} from \verb{\link[deSolve]\{ode\}()} for
\verb{\link{DAISIE_ML_IW}()}.}

\item{optimmethod}{Method used in likelihood optimization. Default is
\code{subplex} (see \verb{\link[subplex]\{subplex\}()} for full details).
Alternative is \code{"simplex"} which was the method in previous versions.}

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

\item{low_rates}{Boolean determining whether the random sampling of initial
parameter estimates should be sampled from a broad range (FALSE) or from a
restricted range where the initial rates a ensured to be smaller (TRUE).
The latter helps when using large datasets that may fail the initial
likelihood computation with higher rates that could be sampled from the
broad range of rates.}

\item{rep_index}{A string which by default is "NULL" (it is a string and not
a true NULL due to being passed from the command line), or can be a string
of a numeric which is used to detect whether multiple data set from the
same data source is being run. This is the case, for example, when fitting
a DAISIE model to a posterior distribution of data.}

\item{res}{A numeric determining the resolution of the likelihood
calculations, it sets the limit for the maximum number of species for
which a probability must be computed, which must be larger than the size
of the largest clade.}

\item{par_upper_bound}{A numeric defining the upper limit of the integration
of a parameter when fitting the relaxed-rate DAISIE model. If the DAISIE
model being applied is not the relaxed-rate model, this parameter can be
ignored and left as its default as it does not influence the model.}

\item{test}{A boolean, defaults to \code{FALSE}. Set to \code{TRUE} for testing
purposes, to fix the seed.}
}
\value{
Nothing. Writes \code{\link{DAISIE}} analysis results to a \code{.rds} file. This
file is stored in \code{file_path}. The directory in of \code{file_path} is created
if it doesn't exist.
}
\description{
Run DAISIE analysis
}
\examples{
\dontrun{
data(Galapagos_datalist, package = "DAISIE")
run_daisie_ml(
  daisie_data = Galapagos_datalist,
  data_name = "Galapagos_datalist",
  model = "cr_dd",
  array_index = 1,
  cond = 1
)
}
}
\author{
Pedro Santos Neves, Joshua W. Lambert, Luis Valente
}
