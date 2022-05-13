#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -p core
#SBATCH -n 2
#SBATCH -J eggNOG.job
#SBATCH -t 100:00:00
#SBATCH --mail-user milena.doroszko.0019@student.uu.se
#SBATCH --mail-type=ALL

set -x

# Load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.5


#check which modules were loaded
module list
mkdir -p /home/mildo141/ga/output/08_EggNOG_mapper
mkdir -p /home/mildo141/ga/output/08_EggNOG_mapper/SRR4342129
mkdir -p /home/mildo141/ga/output/08_EggNOG_mapper/SRR4342133

IN29=/home/mildo141/ga/output/06_prokka/SRR4342129
IN33=/home/mildo141/ga/output/06_prokka/SRR4342133
OUT29=/home/mildo141/ga/output/08_EggNOG_mapper/SRR4342129
OUT33=/home/mildo141/ga/output/08_EggNOG_mapper/SRR4342133


#emapper.py -i $IN29/bin29.10.fa.faa  -o $OUT29/bin29.10.eggNOG
#emapper.py -i /home/mildo141/ga/output/06_prokka/SRR4342129/bin29.10.fa.faa -o /home/mildo141/ga/output/08_EggNOG_mapper/SRR4342129/bin29.10.eggNOG

cd $IN29
for sample in *.faa
do
emapper.py -i ${sample} -o $OUT29/${sample}_egg
done

