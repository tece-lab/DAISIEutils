# DAISIEutils 1.6.2

* Prevent parameter values above upper bound being passed to the relaxed rate model in `run_daisie_ml()` (#34).
* Lower the value given as initial parameter value when estimated as infinite for the relaxed rate model in `run_daisie_ml()`.

# DAISIEutils 1.6.1

* Migrate from now defunct Peregrine HPCC to the new Hábrók HPCC
* Prevent `Inf` from being passed to the relaxed rate model in `run_daisie_ml()` (#33)

# DAISIEutils 1.6.0

* The version of R and DAISIE are incremented to 4.2 and 4.4.0, respectively
* The relaxed-rate DAISIE model now has an initial DAISIE optimisation to get better initial conditions (in `run_daisie_ml()`)
* Removed an old documentation section causing warning

# DAISIEutils 1.5.0

* Allow relaxed-rate DAISIE ML models. 
  * This requires new a argument for `run_daisie_ml()` and `setup_model()`: 
  `par_upper_bound`, which sets the upper limit of the integration of a relaxed 
  parameter. This defaults to `Inf` in the R function and shell scripts, which
  is no upper bound of integration for the relaxed-rate DAISIE model. This 
  parameter is ignored when using the standard constant-rate case 
  (i.e., not relaxed-rate).
* Allow 2 type DAISIE ML analyses, handled by `run_daisie_2type_ml()` and 
adjacent function `setup_2type_model()`. Similarly add required R 
`run_daisie_2type_ml.R` script and shell scripts `submit_run_daisie_2type_ml.sh`
and `submit_run_daisie_2type_ml_long.sh` to run said analyses in an HPCC.
* Package depends on CRAN DAISIE release instead of GitHub repository. Now
requires DAISIE >= v4.3.1 to ensure latest ML related bugfixes are used.
* Add new tests covering new cases.
* Add Rampal Etienne's details to zenodo release.

# DAISIEutils 1.4.0

* Add new argument `res` to change resolution in `DAISIE::DAISIE_ML_CS()`.
Default values allows for backwards compatibility in functions and job scripts
for Peregrine.

# DAISIEutils 1.3.0

* Can now extract a single data set (or replicate) from a data set that stores 
several within the same list.
* Add support for non-oceanic models (which can be chosen in the relevant 
functions and start with `nonoceanic` in relevant functions).

# DAISIEutils 1.2.1

* Correct `.zenodo.json` for automatic release and archiving on Zenodo.

# DAISIEutils 1.2.0

* Reworked all reference test file infrastructure to use `tempdir()`.
* Added `results_dir` argument to functions that load and/or write to the file 
system to allow the user to specify a custom directory appropriate for their 
environment. The default, `NULL` maintains previous behaviour, i.e., saves
and loads from a folder `results/` in the root of the working directory.
* Removed `is_daisie_data()` as it was incomplete and seldom used. May be ported
from other packages in the future.
* Rework `create_output_folder()` to only handle directory creation. 
The file path generation is now handled by `create_results_dir_path()` assuming 
previous functionality with new added flexibility via the `results_dir` argument
as described above.
* Add alternative (lower) CES rates to `run_daisie_ml()` and setup model to
allow certain datasets to be begin estimation from valid parameters.
* Renamed argument `data` to `daisie_data` for consistency with more recent
DAISIE related packages and to avoid conflicts with base R's `data()`.
* Add functions to plot bootstrap results to check model
goodness of fit: `plot_bootstrap_results()`, `summarize_bootstrap_results()` 
adding to `plot_sim_metrics()` which now is split into `calc_sim_metrics()`.
* Add `setup_std_pars2()` to generate common `pars2`, useful for development
within 'DAISIE'.
* `run_daisie_ml()` can now return it's output to session rather than saving
to file by setting `results_dir` to `NA`.
* `run_daisie_ml()` uses `lsodes` as default `methode`, in line with 'DAISIE'.
* Style entire package with 'styler'.
* Require 'DAISIE' v4.2.1.
* No longer depend on private packages, to ensure package can be accessed by 
more users.
* Due to new plot functions, depend on 'ggplot2'and 'cowplot'.
* Added `upload_results.R` and `upload_results.sh` to upload to Google drive
directly from Peregrine.
* Added `.zenodo.json` with metadata for automatic Zenodo releases.

# DAISIEutils 1.1.0

-   `choose_best_model()` correctly handles results where no model was estimated successfully, and returns `NA` appropriately.

-   `sensitivity()` now works correctly regardless of the number of parameters used to estimate the chosen models. This means relaxed-rate models and any model fitting that returns results with more than the base `DAISIE` parameters is accommodated.

-   `sensitivity()` no longer saves to file and instead returns results to the environment.

-   Improved `sensitivity()` documentation.

-   Depend on and install `DAISIE` v4.0.2.

# DAISIEutils 1.0.0

-   Complete overhaul of package.

-   Add `run_daisie_ml()` to fit DAISIE models on DAISIE datasets. Returns model fitting results and BIC value.

-   Add `bootstrap_lr()` to conduct a likelihood ratio bootstrap test on two DAISIE models.

-   Add `bootstrap()` to conduct goodness of fit bootstrapping test.

-   Add `sensitivity()` to calculate the sensitivity of the model to two alternative data sets.

# DAISIEutils 0.0.0.9001

-   Create package skeleton.
-   Add `print_main_header()`.
-   Use `default_params_doc.R` to document package.
-   Write `README.md` stub.
-   Add tests and coverage.
-   Added a `NEWS.md` file to track changes to the package.
