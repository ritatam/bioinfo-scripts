## Tagging BAM alignments with read group id with bamaddrg

This script uses the bamaddrg package to add read group (RG) tags to input BAM files, and streams tagged BAM output (.rg.bam). Running `bamaddrg_cmds_generator.sh` generates a list of bamaddrg commands for all samples, and saves them into `run_cmds.sh` in the same directory. Commands will be printed on screen, and the user will be asked to confirm before proceeding to running them.


#### Before running this script

- bamaddrg must have been installed in the environment. (`conda install -c bioconda bamaddrg`)

- The input directory should contain subdirectories named as your samples, each containing a corresponding BAM alignment file. Filename must match subdirectory name exactly except the .bam suffix.

- If there are replicates, subdirectory (sample) names must be followed by "_n", and all samples/conditions must have the same number of replicates. Alignments from separate BAMs will be tagged with read group id (e.g. gs_1, gs_2, 0_dpi_1, 0_dpi_2, 3_dpi_1, 3_dpi_2) and the corresponding sample name (gs, 0_dpi, 3_dpi).

- If there is no replicate, alignments will be tagged with read group id (gs, 0_dpi, 3_dpi) identical to sample name (gs, 0_dpi, 3_dpi).


#### Usage

1. Edit set-up in `bamaddrg_cmds_generator.sh`
	- $working_dir: absolute path to directory where the scripts are located
	- $input_dir: absolute path to input directory, structure requirement described above
	- $replicates: true if replicates are used, false if no replicate

2. Generate bamaddrg commands

	`bash bamaddrg_cmds_generator.sh`

User will be asked to confirm before proceeding to running them.

3. (Optional) Commands will be saved in run_cmds.sh, which can be later modified freely by user. To directly run the script:

	`bash run_cmds.sh`
