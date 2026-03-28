# Transcript Quantification & Matrix Generation
**Date:** March 23, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Performed transcript quantification against the previously merged Arabidopsis reference transcriptome (`at_merged.gtf`). Used the `StringTie` Ballgown-compatible pipeline to extract abundance estimates (FPKM/TPM) and generated raw count matrices for downstream differential expression analysis in R.

## 🛠 Pipeline Steps

### 1. Quantification (`StringTie -e -B`)
Restricted StringTie to only estimate expression levels for the transcripts in the merged GTF file (`-e` flag), and generated Ballgown input table files (`-B` flag).
* **Threads:** 10 (Maximized for M5 architecture)
* **Output:** Sample-specific subdirectories inside the `ballgown/` directory containing `.ctab` files.

### 2. Verification
Verified the successful generation of expression metrics by inspecting the output table for the first Wild Type replicate:
```bash
cat ballgown/R1-1_WT/t_data.ctab | head -n 10
```

### 3. Count Matrix Generation (`prepDE.py3`)
Downloaded and executed the Python script provided by the Johns Hopkins Center for Computational Biology (CCB) to extract raw read counts from the StringTie output.
* **Input:** `ballgown/` directory
* **Output:** `transcript_count_matrix.csv` (and `gene_count_matrix.csv`)

### 4. Phenotype Data Preparation
Created the metadata file mapping each sample ID to its biological condition (WT vs. Cond) to allow for seamless integration into R (DESeq2/Ballgown).
```bash
printf "ids,condition\nR1-1_WT,WT\nR2-1_WT,WT\nR3-1_WT,WT\nR1-9_Cond,Cond\nR2-9_Cond,Cond\nR3-9_Cond,Cond" > phenodata.csv
```

## Next Steps
The command-line portion of the Tuxedo protocol is complete. The count matrices and phenotype data will now be moved into RStudio for statistical analysis and visualization.