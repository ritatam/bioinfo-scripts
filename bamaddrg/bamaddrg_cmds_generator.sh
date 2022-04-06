#!/bin/bash

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
