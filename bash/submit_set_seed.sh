#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=set_seed
#SBATCH --output=set_seed.log
#SBATCH --mem=1GB
#SBATCH --partition=gelifes

ml R

Rscript -e 'DAISIEutils::set_seed()'
