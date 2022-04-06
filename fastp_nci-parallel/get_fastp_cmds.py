import os

rawdir = "/g/data/xf3/ht5438/data/RNAseq/protoplast_RNAseq/raw"
trimdir = "/g/data/xf3/ht5438/data/RNAseq/protoplast_RNAseq/trimmed"

out = list(set([x.split(".fq.gz")[0][:-2] for x in os.listdir(rawdir) if x.endswith("fq.gz")]))

with open("/home/106/ht5438/nci_scripts/RNAseq_fastp/fastp/fastp_cmds.txt", "w") as txt:
    for n in out:
        print(f"fastp --in1 {rawdir}/{n}_1.fq.gz --in2 {rawdir}/{n}_2.fq.gz --out1 {trimdir}/{n}_1.trimmed.fq.gz \
        --out2 {trimdir}/{n}_2.trimmed.fq.gz --failed_out {trimdir}/failed/{n}.fastp_fails.fq.gz \
        --html {trimdir}/qc_report/html/{n}.fastp.html --json {trimdir}/qc_report/json/{n}.fastp.json \
        --disable_trim_poly_g --trim_poly_x \
        --disable_adapter_trimming \
        --thread 4", file=txt)


