#!/bin/bash
#SBATCH --time=5:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=up_res
#SBATCH --output=upload_results.log
#SBATCH --mem=9GB
#SBATCH --partition=regular

ml R
Rscript /home/$USER/DAISIEutils/scripts/upload_results.R
