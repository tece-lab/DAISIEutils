#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=boot_pipe
#SBATCH --output=logs/DAISIE/b-%a.log
#SBATCH --mem=2GB
#SBATCH --array=1-1000
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
#         ! THIS BASH FILE IS NOT TO BE CALLED MANUALLY. FOR MANUAL OPERATION  #
#                         USE submit_bootstrap.sh INSTEAD!                     #
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


# See DAISIEutils::bootstrap_lr() documentation for help.
# Arguments to follow the Rscript are as follows:
datalist_name=$1
model_1=$2
model_2=$3
package=$4
cond=$5
seed=${SLURM_ARRAY_TASK_ID}

ml R
Rscript DAISIEutils/scripts/bootstrap_lr.R ${datalist_name} \
                                           ${model_1} \
                                           ${model_2} \
                                           ${package} \
                                           ${seed} \
                                           ${cond} \

