#!/bin/bash -l
#SBATCH -D /home/jri/projects/bigd/angsbigd/
#SBATCH -J angsdo
#SBATCH -o outs/out-%j.txt
#SBATCH -p bigmem
#SBATCH -e errors/error-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32

# script to run ANGSD on hapmap2 bam files
module load angsd

angsdir=/home/jri/src/angsd0.588
taxon=$1
windowsize=1000
step=500
nInd=$( wc -l data/"$taxon"_list.txt | cut -f 1 -d " " )
n=$( expr 2 \* $nInd )
minperc=0.8
minInd=$( printf "%.0f" $(echo "scale=2;$minperc*$nInd" | bc))
glikehood=1
minMapQ=30
cpu=32
range=""
#range="-r 10:"

#(estimate an SFS)
# -bam list of paths to bamfiles you want to use
# -out output file (prior for SFS I believe)
# -doSaf estimates SFS, do 2 if you have inbreeding coefficients (-indF)
# -uniqueOnly 1=use only uniquely mapping reads
# -anc ancestral sequence (see trip.sh script for how this is generated)
# -minMapQ 40 minimum mapping quality of reads to accepy
# -minQ 20 minimum bp quality
# -setMaxDepth 20 sets max depth to accept -- useful to deal with highly repetitive regions
# -baq 1=realign locally (I think)
# -GL $glikehood 1 is samtools, 2 is GATK, 3 SOAPsnp 4 SYK
# -r 10:1- ony analyze this range (here all of chromosome 10)
# -P 8 use 8 threads
# -indF individiual inbreeding coefficient. for inbred lines just make a files of "1" on each line for each bamfile. otherwise use ngsF to estimate (see inbreeding.sh script)

command1="-bam data/"$taxon"_list.txt -out temp/"$taxon" -indF data/$taxon.indF -uniqueOnly 0 -anc data/TRIP.fa.gz -minMapQ $minMapQ -minQ 20 -nInd $nInd -minInd $minInd -baq 1 -ref /home/jri/genomes/Zea_mays.AGPv2.17.dna.toplevel.fa -show 1 -GL $glikehood -P $cpu $range"
echo $command
$angsdir/angsd $command1

