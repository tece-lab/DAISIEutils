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
