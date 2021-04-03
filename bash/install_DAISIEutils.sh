#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=install_DAISIEutils
#SBATCH --output=install_DAISIEutils.log
#SBATCH --mem=2GB
#SBATCH --partition=gelifes

mkdir -p logs/DAISIE
ml R

Rscript -e 'remotes::install_github("tece-lab/DAISIEutils")'
