#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=daisie_ml
#SBATCH --output=logs/%x-%j-array-%a.log
#SBATCH --mem=2GB
#SBATCH --array=1-10
#SBATCH --partition=gelifes

# DAISIEutils: Utility Functions for the DAISIE Package
# Copyright (C) 2021 Pedro Neves, Joshua W. Lambert
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

################################ Usage #########################################
#         This bash script submits a set of DAISIE model inference jobs        #
#                 Submissions are made to the gelifes partition.               #
################################################################################
### Arguments ###
# data - the name of the datalist object, as found as data on
#   the hawaiispiders package.
# model - the name of a DAISIE model to indicate which parameters are estimated
# or fixed.
# package - the name of the package where the data is stored.
# seed - The seed used to sample the optimization initial parameters.
# cond - The conditioning for DAISIE_ML
# results_dir - The directory where results should be read from and saved to.
# Defaults to /results/$datalist_name if left unspecified.
# methode - The numerical integrator used to calculate the likelihood of the
# model. If left unspecified defaults to the lsodes method.
# optimmethod - The optimization algorithm used to maximize the likelihood. If
# left unspecified, the default subplex algorithm is used.
# low_rates - A boolean determining whether to sample the initial parameter
# estimates from the standard distribution (FALSE, default) or whether to sample
# from a restricted distribution in which the upper bound of the initial
# parameter estimates are lower
# rep_index - A numeric or NULL which determines whether the data being read is
# a single data set (i.e. a single replicate), set by NULL which is default, or
# one of several data sets, in which case the data set to choice is set by
# rep_index
# res - A numeric determining the resolution of the likelihood calculations, it
# sets the limit for the maximum number of species for which a probability
# must be computed, which must be larger than the size of the largest clade
# prop_type2_pool - A numeric determining the proportion of the mainland species
# pool that is composed on type 2 species

################################################################################
##### Before running make sure install_DAISIEutils.sh has been run ####
# Example:
# sbatch DAISIEutils/bash/submit_run_daisie_ml.sh Aldabra_Group cr_di relaxedDAISIE 5
# Example with methode set to lsodes and optimmethod set to simplex
################################################################################


# See DAISIEutils::run_daisie_ml() documentation for help.
# Arguments to follow the Rscript are as follows:
data=$1
model=$2
package=$3
cond=$4
results_dir=${5-NULL}
methode=${6-lsodes}
optimmethod=${7-subplex}
low_rates=${8-FALSE}
rep_index=${9-NULL}
res=${10-100}
prop_type2_pool=${11}
seed=${SLURM_ARRAY_TASK_ID}

ml R
Rscript DAISIEutils/scripts/run_daisie_2type_ml.R ${data} \
                                                  ${model} \
                                                  ${package} \
                                                  ${seed} \
                                                  ${cond} \
                                                  ${results_dir} \
                                                  ${methode} \
                                                  ${optimmethod} \
                                                  ${low_rates} \
                                                  ${rep_index} \
                                                  ${res} \
                                                  ${prop_type2_pool}
