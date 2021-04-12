#!/bin/bash
#SBATCH --time=9-23:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=DAISIE
#SBATCH --output=logs/DAISIE/a-%a.log
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
################################################################################
##### Before running make sure install_DAISIEutils.sh has been run ####
# Example:
# sbatch DAISIEutils/bash/submit_run_analysis.sh Aldabra_Group cr_di relaxedDAISIE 5
################################################################################


# See DAISIEutils::run_daisie_ml() documentation for help.
# Arguments to follow the Rscript are as follows:
data=$1
model=$2
package=$3
cond=$4
seed=${SLURM_ARRAY_TASK_ID}

ml R
Rscript DAISIEutils/scripts/run_daisie_ml.R ${data} \
                                            ${model} \
                                            ${package} \
                                            ${seed} \
                                            ${cond} \

