#!/bin/bash


# This script uses the bamaddrg package to add read group (RG) tags to input BAM files,
# and streams tagged BAM output (.rg.bam). Running this script (bamaddrg_cmds_generator.sh)
# generates a list of bamaddrg commands for all samples, and saves them into run_cmds.sh in
# the same directory. Commands will be printed on screen. User will be asked to confirm
# before proceeding to running them.


# Before running this script:

# - bamaddrg must have been installed in the environment.

# - The input directory should contain subdirectories named as your samples, each containing a
#   corresponding BAM alignment file.

# - If there are replicates, subdirectory (sample) names must be followed by "_n",
#   and all samples/conditions must have the same number of replicates.
#   Alignments from separate bam will be tagged with read group id (e.g. gs_1, gs_2, 0_dpi_1, 
#   0_dpi_2, 3_dpi_1, 3_dpi_2) and the corresponding sample name (gs, 0_dpi, 3_dpi).

# - If there is no replicate, alignments will be tagged with read group id (gs, 0_dpi, 3_dpi)
#   and sample name (gs, 0_dpi, 3_dpi).


########## set up ##########
working_dir="/media/hardDrive-02/rita/Pst_rnaToGenome/script"
input_dir="/media/hardDrive-02/rita/Pst_rnaToGenome/20210504/RNAseq_genome_map"
replicates=true  # false if no replicates
############################


# generate run_cmds.sh to store commands
cmds_sh_path=${working_dir}/run_cmds.sh
touch $cmds_sh_path
echo '#!/bin/bash' > $cmds_sh_path
printf "\n"

for subdir in ${input_dir}/*; do
  base=$(basename $subdir)

  # if replicates=true, sample names will have "_n" suffix removed
  # if replicates=false, sample name and read group id will be the same  
  if $replicates
  then
    freq=$(echo $base | awk -F"_" '{print NF-1}')
    samp=$(echo $base | cut -f-${freq} -d"_")
  else
    echo "rep is false"
    samp=$base
  fi
  
  # print commands on screen and save into run_cmds.sh
  echo "bamaddrg -b ${subdir}/${base}.bam -s ${samp} -r ${base} > ${subdir}/${base}.rg.bam" >> $cmds_sh_path
  echo "bamaddrg -b ${subdir}/${base}.bam -s ${samp} -r ${base} > ${subdir}/${base}.rg.bam"
  done
printf "\nCommands printed in ${cmds_sh_path}.\n\n"

# ask user if proceed to running the commands in run_cmds.sh
while true; do
  read -p "Proceed? (Y to run commands above; N to exit) " yn
  case $yn in
    [Yy]* ) source ${cmds_sh_path}; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done
