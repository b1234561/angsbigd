#!/bin/bash -l
#SBATCH -D /home/adurvasu/angsbigd/
#SBATCH -J trip_fasta
#SBATCH -o outs/out-%j.txt
#SBATCH -p bigmem
#SBATCH -e errors/error-%j.txt

module load angsd
angsd -i /group/jrigrp/hapmap2_bam/Disk3CSHL_bams_bwamem/TDD39103_ZEAHWCRAYDIAAPE_7.bam -doFasta 1 -out /home/adurvasu/angsbigd/outs/TRIP_try
angsd -i /group/jrigrp/hapmap2_bam/Disk3CSHL_bams_bwamem/TDD39103_merged.bam -doFasta 1 -out /home/adurvasu/angsbigd/data/TRIP
