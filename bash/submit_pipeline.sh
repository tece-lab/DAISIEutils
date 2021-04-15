#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=DAISIE
#SBATCH --output=logs/pipeline.log
#SBATCH --mem=1GB
#SBATCH --partition=short

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
#         This bash script submits a pipeline running analysis of two DAISIE   #
#                models and then bootstraps from the produced output.          #
#         !BOOTSTRAP MUST TAKE 3 DAYS OR LESS! If more time is needed, run     #
#             submit_run_analysis.sh and submit_bootstrap.sh manually.         #
#         If doing so, ensure submit_run_analysis.sh has finished before       #
#                             starting bootstraps.
#                                                                              #
#                 Submissions are made to the gelifes partition.               #
################################################################################
### Arguments ###
# datalist_name - the name of the datalist object, as found as data on
#   the hawaiispiders package.
# model_1 - the name of a DAISIE model to indicate which parameters are estimated
# or fixed.
# model_2 - the name of a DAISIE model to indicate which parameters are estimated
# or fixed.
# package - the name of the package where the data is stored.
# seed - The seed used to sample the optimization initial parameters.
# cond - The conditioning for DAISIE_ML
################################################################################
##### Before running make sure install_DAISIEutils.sh has been run ####
# Example:
# sbatch DAISIEutils/bash/submit_pipeline.sh Aldabra_Group cr_di cr_dd relaxedDAISIE 5
################################################################################


# See DAISIEutils::bootstrap() documentation for help.
# Arguments to follow the Rscript are as follows:
datalist_name=$1
model_1=$2
model_2=$3
package=$4
cond=$5

sbatch DAISIEutils/bash/submit_run_daisie_ml.sh ${datalist_name} \
                                                ${model_1} \
                                                ${package} \
                                                ${cond}

sbatch DAISIEutils/bash/submit_run_daisie_ml.sh ${datalist_name} \
                                                ${model_2} \
                                                ${package} \
                                                ${cond}

sbatch --dependency=singleton --job-name=DAISIE DAISIEutils/bash/submit_bootstrap_lr.sh ${datalist_name} \
                                                                                        ${model_1} \
                                                                                        ${model_2} \
                                                                                        ${package} \
                                                                                        ${cond}
