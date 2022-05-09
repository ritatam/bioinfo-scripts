#!/bin/bash

# Subset a bam file using a given csv file listing genome regions, and write new BAMs accordingly in the working dir.

set -eo pipefail

module purge

module load pbs
module load samtools


REGIONS_CSV=regions_to_subset.csv
BAM=Pst_PRJNA704774.merged.bam



mkdir -p subset/

while read REGION;
do
	samtools view -b -h ${BAM} ${REGION} -o ./subset/${REGION}.bam
	samtools index -b ./subset/${REGION}.bam
done <${REGIONS_CSV}
