#!/bin/bash
#PBS -P xf3
#PBS -q normal
#PBS -l walltime=02:00:00
#PBS -l ncpus=48
#PBS -l mem=48G
#PBS -l jobfs=1G
#PBS -l storage=scratch/xf3+gdata/xf3
#PBS -l wd

source /g/data/xf3/ht5438/miniconda3/etc/profile.d/conda.sh

function useconda() {
	                eval "$(/g/data/xf3/ht5438/miniconda3/bin/conda shell.zsh hook)"
			        }

useconda

conda activate trim

module load nci-parallel/1.0.0a
export ncores_per_task=4
export ncores_per_numanode=12

mpirun -np $((PBS_NCPUS/ncores_per_task)) --bind-to core:overload-allowed --map-by ppr:$((ncores_per_numanode/ncores_per_task)):NUMA:PE=${ncores_per_task} nci-parallel --input-file /home/106/ht5438/nci_scripts/RNAseq_fastp/fastp/fastp_cmds.txt
