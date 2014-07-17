#!/bin/bash -l
#SBATCH -D /home/jri/projects/bigd/angsbigd/
#SBATCH -J trip_fasta
#SBATCH -o outs/out-%j.txt
#SBATCH -p bigmem
#SBATCH -e errors/error-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32

angsdir=/home/jri/src/angsd0.609

$angsdir/angsd -i /group/jrigrp/hapmap2_bam/Disk3CSHL_bams_bwamem/TDD39103_merged.bam -doFasta 1 -out data/TRIP -P 32
