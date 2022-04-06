import os

trimmed_dir = "/g/data/xf3/ht5438/data/RNAseq/protoplast_RNAseq/trimmed"
outdir = "/scratch/xf3/ht5438/protoplast_RNAseq/kallisto-abundance"
index_path = "/g/data/xf3/ht5438/data/RNAseq/protoplast_RNAseq/transcriptome/Triticum_aestivum.transcripts.idx"

samples = list(set([x.split(".trimmed.fq.gz")[0][:-2] for x in os.listdir(trimmed_dir) if x.endswith("fq.gz")]))

with open("/home/106/ht5438/nci_scripts/RNAseq_analysis/kallisto/kallisto_quant_cmds.txt", "w") as txt:
    for n in samples:
        print(f"kallisto quant -i {index_path} -o {outdir}/{n} -b 100 \
                {trimmed_dir}/{n}_1.trimmed.fq.gz {trimmed_dir}/{n}_2.trimmed.fq.gz \
                --threads 4", file=txt)
