#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 11:00:00
#SBATCH -J Phylophlan.job
#SBATCH --mail-user milena.doroszko.0019@student.uu.se
#SBATCH --mail-type=ALL

#to help identify the work
cat $0
echo QOS = $SLURM_QOS
set -x


# Load modules
module load bioinfo-tools
module load phylophlan/0.99
module unload python
module load biopython/1.73
module load FastTree/2.1.10
module load usearch/5.2.32
module load muscle/3.8.31

#check which modules were loaded
module list
#
mkdir -p /home/mildo141/ga/output/07_Phylo
mkdir -p /home/mildo141/ga/output/07_Phylo/input/metagenome
mkdir -p /home/mildo141/ga/output/07_Phylo/output
mkdir -p /home/mildo141/ga/output/07_Phylo/data/ppaalns


#define directories
OUT=/home/mildo141/ga/output/07_Phylo

# symlink phylophlan data files
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/*.bz2 $OUT/data/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppaalns/*.bz2 $OUT/data/ppaalns/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppafull.tax.txt $OUT/data/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/taxcuration/ $OUT/
ln -sf /home/mildo141/ga/output/06_prokka/SRR4342129/*.faa $OUT/input/metagenome
ln -sf /home/mildo141/ga/output/06_prokka/SRR4342133/*.faa $OUT/input/metagenome


#PhyloPhlAn (-d phylophlan, 400 universal marker genes) presented in Segata, N et al. NatComm 4:2304 (2013)
#AMPHORA2 (-d amphora2, 136 universal marker genes) presented in Wu M, Scott AJ Bioinformatics 28.7 (2012)

cd $OUT
phylophlan.py -i metagenome -t --nproc 4

