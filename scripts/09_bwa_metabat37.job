#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J 07_bwaRNA.job
#SBATCH --mail-user milena.doroszko.0019@student.uu.se
#SBATCH --mail-type=ALL

#to help identify the work
cat $0
echo QOS = $SLURM_QOS
set -x


# Load modules
module load bioinfo-tools
module load bwa/0.7.17
module load samtools/1.14
module load MetaBat/2.12.1

#check which modules were loaded
module list
mkdir -p /home/mildo141/ga/output/04_bwa
mkdir -p /home/mildo141/ga/output/04_bwa/SRR4342137R
mkdir -p /home/mildo141/ga/output/03_metabat/SRR4342137R
mkdir -p /home/mildo141/ga/output/03_metabat/SRR4342137R/bins_normalized

#define directories
OUT=/home/mildo141/ga/output/04_bwa/SRR4342137R
OUTM=/home/mildo141/ga/output/03_metabat/SRR4342137R/bins_normalized
IN=/home/mildo141/ga/output/01_trimming



REF37=/home/mildo141/ga/output/02_megahit/SRR4342137R_assembly.contigs/final.contigs.fa

#RNA_trim_37.LP.trim.fastq.gz  RNA_trim_37.RP.trim.fastq.gz  RNA_trim_39.LP.trim.fastq.gz  RNA_trim_39.RP.trim.fastq.gz  trim_D1.log
#RNA_trim_37.LU.trim.fastq.gz  RNA_trim_37.RU.trim.fastq.gz  RNA_trim_39.LU.trim.fastq.gz  RNA_trim_39.RU.trim.fastq.gz  trim_D3.log

bwa index $REF37
bwa mem -t 2 $REF37 $IN/RNA_trim_37.LP.trim.fastq.gz $IN/RNA_trim_37.RP.trim.fastq.gz | samtools sort -o $OUT/SRR4342137.bam

jgi_summarize_bam_contig_depths --outputDepth $OUTM/depth.txt --pairedContigs $OUTM/paired.txt $OUT/*.bam

#run metabat after normalization to sequencing depth
metabat -i $REF37 -a $OUTM/depth.txt -p $OUTM/paired.txt -o $OUTM/bin37 --specific -v --saveTNF $OUTM/saved.tnf --saveDistance $OUTM/saved.gprob
