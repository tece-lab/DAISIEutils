#!/bin/bash
#SBATCH --time=9-23:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=DAISIE
#SBATCH --output=logs/DAISIE/job-%j.log
#SBATCH --mem=2GB
#SBATCH --partition=regular

# DAISIEutils: Utility Functions for the DAISIE Package
# Copyright (C) 2021 Pedro Neves
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

################################################################################
# This script can either be called directly, or by submit_models_peregrine.sh  #
# script found in the same folder.                                             #
################################################################################

# See DAISIEutils::run_main() documentation for help.
# See also DAISIEutils/bash/submit_run_robustness_peregrine.sh for help.
# Arguments to follow the Rscript are as follows:
datalist_name=$1
M=$2
model_to_run=$3
seed_range_1=$4
seed_range_2=$5
verbose=$6

ml R
Rscript DAISIEutils/scripts/run_main_peregrine.R ${datalist_name} \
                                                 ${M} \
                                                 ${model_to_run} \
                                                 ${seed_range_1} \
                                                 ${seed_range_2} \
                                                 ${verbose}
