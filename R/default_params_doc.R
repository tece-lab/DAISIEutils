#' Default parameters documentation
#'
#' @param model A string with model that should run. Models are as follows:
#'   * `"cr_dd"` Clade specific model - diversity dependent. All parameters
#'     free.
#'   * `"cr_di"` Clade specific model - diversity independent (K = Inf). All
#'     other parameters free.
#'   * `"cr_dd_0laa"` Clade specific model - diversity dependent and no
#'     anagenesis (laa fixed to zero). All other parameters free.
#'   * `"cr_di_0laa"` Clade specific model - diversity independent (K = Inf)
#'     and no anagenesis (laa fixed to zero). All other parameters free.
#'   * `"cr_di_0lac"` Clade specific model - diversity indendent (K = Inf)
#'     and no cladogenesis (lac fixed to zero). All other parameters free.
#'   * `"cr_dd_0lac"` Clade specific model - diversity dependent and no
#'     cladogenesis (lac fixed to zero). All other parameters free.
#'   * `"rr_lac_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed cladogenesis. All other parameters free.
#'   * `"rr_lac_dd"` Clade specific model - diversity dependent and relaxed
#'     cladogenesis. All other parameters free.
#'   * `"rr_mu_di"` Clade specific model - diversity independent (K = Inf) and
#'     relaxed extinction. All other parameters free.
#'   * `"rr_mu_dd"` Clade specific model - diversity dependent and relaxed
#'     extinction. All other parameters free.
#'   * `"rr_k"` Clade specific model - diversity dependent and relaxed carrying
#'     capacity. All other parameters free.
#'   * `"rr_gam_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed colonisation. All other parameters free.
#'   * `"rr_gam_dd"` Clade specific model - diversity dependent and relaxed
#'     colonisation. All other parameters free.
#'   * `"rr_laa_di"` Clade specific model - diversity independent (K = Inf)
#'     and relaxed anagenesis. All other parameters free.
#'   * `"rr_laa_dd"` Clade specific model - diversity dependent and relaxed
#'     anagenesis. All other parameters free.
#'   * `"rr_mu_di_0lac"` Clade specific model - diversity independent,
#'     relaxed extinction, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_mu_dd_0lac"` Clade specific model - diversity dependent, relaxed
#'     extinction, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_k_0lac"` Clade specific model - diversity dependent, relaxed
#'     carrying capacity, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_gam_di_0lac"` Clade specific model - diversity independent,
#'     relaxed colonisation, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"r_gam_dd_0lac"` Clade specific model - diversity dependent, relaxed
#'     colonisation, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_laa_di_0lac"` Clade specific model - diversity independent,
#'     relaxed anagenesis, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"r_laa_dd_0lac"` Clade specific model - diversity dependent, relaxed
#'     anagenesis, and no cladogenesis (lac fixed to zero). All other
#'     parameters free.
#'   * `"rr_lac_di_0laa"` Clade specific model - diversity independent,
#'     relaxed cladogenesis, and no anagenesis (laa fixed to zero)
#'   * `"rr_lac_dd_0laa"` Clade specific model - diversity dependent
#'   * `"rr_mu_di_0laa"` Clade specific model - diversity independent
#'   * `"rr_mu_dd_0laa"` Clade specific model - diversity dependent
#'   * `"rr_k_0laa"` Clade specific model - diversity dependent
#'   * `"rr_gam_di_0laa"` Clade specific model - diversity independent, relaxed
#'     colonisation, and no anagenesis (laa fixed to zero). All other parameters
#'     free
#'   * `"rr_gam_dd_0laa"` Clade specific model - diversity dependent, relaxed
#'     colonisation, and no anagenesis (laa fixed to zero). All other parameters
#'     free
#' @param data_name String. Will be used for the name of the created output
#'   folder.
#' @param results_root_folder Character. A path to the root folder containing
#'   subfolders. Each subfolder contains result files for analysis runs.
#' @param daisie_data A list, conforming to the [`DAISIE`] object format.
#'   Usually preprocessed by [DAISIE::DAISIE_dataprep()], see it's documentation
#'   for details. Otherwise it may be generated via simulations, using
#'   [DAISIE::DAISIE_sim_cr()] and friends.
#' @param array_index A single numeric with the array index. It is used for
#'   naming the output file.
#' @param file_path The system directory where the output files will be stored.
#' @param results A data frame containing model results as created by
#'   [run_daisie_ml()]. These results are the [DAISIE::DAISIE_ML_CS()] and the
#'   bic, and they're saved as an RDS file by [run_daisie_ml()].
#' @param cond An integer specifying conditioning, as described in
#'   [DAISIE::DAISIE_ML_CS()].
#' @param methode Method of the ODE-solver. Supported Boost `ODEINT`
#'   solvers (steppers) are:
#'   `"odeint::runge_kutta_cash_karp54"`
#'   `"odeint::runge_kutta_fehlberg78"`
#'   `"odeint::runge_kutta_dopri5"`
#'   `"odeint::bulirsch_stoer"`
#'   without `odeint::`-prefix, `\link{deSolve}{ode}()` method is
#'   assumed. The default method overall is
#'   `"lsodes"` for `\link{DAISIE_ML_CS}()`
#'   and `"ode45"` from `\link[deSolve]{ode}()` for
#'   `\link{DAISIE_ML_IW}()`.
#' @param optimmethod Method used in likelihood optimization. Default is
#'   `subplex` (see `\link[subplex]{subplex}()` for full details).
#'   Alternative is `"simplex"` which was the method in previous versions.
#' @param model_1 A string with model that should run. For a list of options
#'   see documentation for `model`  parameter in [run_daisie_ml()].
#' @param model_2 A string with model that should run. For a list of options
#'   see documentation for `model` parameter in [run_daisie_ml()].
#' @param model_1_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param model_2_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param model_lik_res A data frame with results from a DAISIE maximum
#'   likelihood model.
#' @param lik_res A data frame with results from a DAISIE maximum likelihood
#'   model.
#' @param data_names A vector of strings with the names of the data sets you
#'   want to compare sensitivity.
#' @param full_output A boolean determining whether the full model output is
#'   returned.
#' @param seed Integer with value to be used as the seed for Mersenne-Twister.
#'   This value is determined by [Sys.time()] and `array_index` to ensure
#'   parallel jobs have different seeds. Only the last 6 digits of the
#'   [Sys.time()] (as an integer) are used.
#' @param test A boolean, defaults to `FALSE`. Set to `TRUE` for testing
#'   purposes, to fix the seed.
#' @param logs_path Character with path to the folder containing logs. Only log
#'   files should be present, in plain text format.
#' @param results_dir A string with the path to the directory where results
#'   are to be stored or can be found. For example, if the data in question
#'   is (to be) stored in `folder_with_res/$data_name`, then `results_dir`
#'   should be `"folder_with_res"`.
#'   Defaults to `NULL`, which indicates the default directories are to be used.
#'   Default directories are:
#'     * `$HOME/results/$data_name` if on the cluster
#'     * `getwd()/results/$data_name` if called from another environment
#'   If `is.na(results_dir)`, then the object is returned to the R session and
#'   not saved to file.
#' @param overall_results summary results obtained with
#'   [summarize_bootstrap_results()].
#' @param sumstats vector with the number of species, number
#'   of colonization, size of the largest clade and the rank of the largest
#'   clade in the empirical data
#' @param ylim4 maximum of the plot of the rank of the largest clade.
#' @param title title of the plot.
#' @param ddmodel Sets the model of diversity-dependence:
#'   * `ddmodel = 0`: no diversity dependence
#'   * `ddmodel = 1`: linear dependence in speciation rate
#'   * `ddmodel = 11`: linear dependence in speciation rate and in immigration
#'     rate
#'   * `ddmodel = 2`: exponential dependence in speciation rate
#'   * `ddmodel = 21`: exponential dependence in speciation rate and in
#'   immigration rate
#' @param verbose In simulation and dataprep functions a logical,
#'   \code{Default = TRUE} gives intermediate output should be printed.
#'   For ML functions a numeric determining if intermediate output should be
#'   printed, \code{Default = 0} does not print, \code{verbose = 1} prints
#'   intermediate output of the parameters and loglikelihood, \code{verbose = 2}
#'   means also intermediate progress during loglikelihood computation is shown.
#' @param island_ontogeny In \code{\link{DAISIE_sim_time_dep}()},
#'   \code{\link{DAISIE_ML_CS}} and plotting a string describing the type of
#'   island ontogeny. Can be \code{"const"}, \code{"beta"} for a beta function
#'   describing area through time. String checked by
#'   \code{\link{is_island_ontogeny_input}()}. \cr In all other functions a
#'   numeric describing the type of island ontogeny. Can be \code{0} for
#'   constant, \code{1} for a beta function describing area through time. In ML
#'   functions \code{island_ontogeny = NA} assumes constant ontogeny. Time
#'   dependent estimation is not yet available as development is still ongoing.
#'   Will return an error if called in that case.
#' @param eqmodel Sets the equilibrium constraint that can be used during the
#'   likelihood optimization. Only available for datatype = 'single'.\cr\cr
#'   eqmodel = 0 : no equilibrium is assumed \cr eqmodel = 13 : near-equilibrium
#'   is assumed on endemics using deterministic equation for endemics and
#'   immigrants. Endemics must be within x_E of the equilibrium value\cr eqmodel
#'   = 15 : near-equilibrium is assumed on endemics and immigrants using
#'   deterministic equation for endemics and immigrants. Endemics must be within
#'   x_E of the equilibrium value, while non-endemics must be within x_I of the
#'   equilibrium value.
#' @param tol Sets the tolerances in the optimization. Consists of:
#'   * `reltolx` - relative tolerance of parameter values in optimization.
#'   * `reltolf` - relative tolerance of function value in optimization.
#'   * `abstolx` - absolute tolerance of parameter values in optimization.
#' @param maxiter Sets the maximum number of iterations in the optimization.
#' @param x_E Sets the fraction of the equlibrium endemic diversity above which
#'   the endemics are assumed to be in equilibrium; only active for
#'   `eqmodel = 13` or `15`.
#' @param x_I Sets the fraction of the equlibrium non-endemic diversity above
#'   which the system is assumed to be in equilibrium; only active for
#'   `eqmodel = 15`.
#' @param mainland_n A numeric stating the number of mainland species, that
#'   is the number of species that can potentially colonize the island.
#'   If using a clade-specific diversity dependence, this value is set to 1
#'   internally in the simulation.
#'   If using an island-wide diversity dependence, this value is set to the
#'   number of mainland species.
#' @param low_rates Boolean determining whether the random sampling of initial
#'   parameter estimates should be sampled from a broad range (FALSE) or from a
#'   restricted range where the initial rates a ensured to be smaller (TRUE).
#'   The latter helps when using large datasets that may fail the initial
#'   likelihood computation with higher rates that could be sampled from the
#'   broad range of rates.
#' @param rep_index A string which by default is "NULL" (it is a string and not
#'   a true NULL due to being passed from the command line), or can be a string
#'   of a numeric which is used to detect whether multiple data set from the
#'   same data source is being run. This is the case, for example, when fitting
#'   a DAISIE model to a posterior distribution of data.
#' @param res A numeric determining the resolution of the likelihood
#'   calculations, it sets the limit for the maximum number of species for
#'   which a probability must be computed, which must be larger than the size
#'   of the largest clade.
#' @param prop_type2_pool A numeric determining the proportion of the mainland
#'   species pool that is composed on type 2 species.
#' @param par_upper_bound A numeric defining the upper limit of the integration
#'   of a parameter when fitting the relaxed-rate DAISIE model. If the DAISIE
#'   model being applied is not the relaxed-rate model, this parameter can be
#'   ignored and left as its default as it does not influence the model.
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(model,
                               data_name,
                               results_root_folder,
                               daisie_data,
                               array_index,
                               file_path,
                               results,
                               cond,
                               optimmethod,
                               methode,
                               model_1,
                               model_2,
                               model_1_lik_res,
                               model_2_lik_res,
                               model_lik_res,
                               lik_res,
                               data_names,
                               full_output,
                               seed,
                               test,
                               logs_path,
                               results_dir,
                               overall_results,
                               sumstats,
                               ylim4,
                               title,
                               ddmodel,
                               verbose,
                               island_ontogeny,
                               eqmodel,
                               tol,
                               maxiter,
                               x_E, # nolint
                               x_I, # nolint
                               mainland_n,
                               low_rates,
                               rep_index,
                               res,
                               prop_type2_pool,
                               par_upper_bound) {
  # Nothing
}
