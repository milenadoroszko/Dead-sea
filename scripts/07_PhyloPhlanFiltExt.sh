#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 12:00:00
#SBATCH -J Phylophlan.job
#SBATCH --mail-user milena.doroszko.0019@student.uu.se
#SBATCH --mail-type=ALL

#to help identify the work
cat $0
echo QOS = $SLURM_QOS
set -x
#this code choses only the filtered bins

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

mkdir -p /proj/genomeanalysis2022/nobackup/work/milena/07_Phylo
mkdir -p /proj/genomeanalysis2022/nobackup/work/milena/07_Phylo/input/SRR4342129
mkdir -p /proj/genomeanalysis2022/nobackup/work/milena/07_Phylo/input/SRR4342133
mkdir -p /proj/genomeanalysis2022/nobackup/work/milena/07_Phylo/output
mkdir -p /proj/genomeanalysis2022/nobackup/work/milena/07_Phylo/data/ppaalns


#define directories
OUT=/proj/genomeanalysis2022/nobackup/work/milena/07_Phylo

# symlink phylophlan data files
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/*.bz2 $OUT/data/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppaalns/*.bz2 $OUT/data/ppaalns/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppafull.tax.txt $OUT/data/
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/taxcuration/ $OUT/


for sample in 1 6 7 8 9 10 11 12 13 14 16 18 20 21 22 23 24 26 28 30 31 34 35 36
do
    ln -sf /home/mildo141/ga/output/06_prokka/SRR4342129/*.faa $OUT/input/SRR4342129
done

for sample in 1 2 3 4 5 6 7 8 11 13 14 15 16 17 18 19 20 21 22 23 26 27 28 31 32 33 34 35 36 37 40 41 43 44 45 46 47 48 49 51 52
do
    ln -sf /home/mildo141/ga/output/06_prokka/SRR4342133/*.faa $OUT/input/SRR4342133
done

cd $OUT
phylophlan.py -i SRR4342129 -t --nproc 4 2> SRR4342129.phylophlan.err
phylophlan.py -i SRR4342133 -t --nproc 4 2> SRR4342133.phylophlan.err
