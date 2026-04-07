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

### 5. Data Distribution (Quartile Check)
Performed a quick statistical summary of the `gene_count_matrix.csv` using Python's `pandas` library to verify the distribution of raw read counts across all replicates. 
```bash
python3 -c "import pandas as pd; df = pd.read_csv('gene_count_matrix.csv', index_col=0); print(df.describe())"
```

**Output:**
```text
            R1-1_WT     R1-9_Cond       R2-1_WT     R2-9_Cond       R3-1_WT     R3-9_Cond
count  3.254000e+04  32540.000000  32540.000000  32540.000000  32540.000000  32540.000000
mean   1.816885e+03   1864.297203   1923.668562   1898.085218   1853.212938   1934.903042
std    1.280226e+04   7093.061024   8556.711389   8355.400183   7894.838757   7836.689055
min    0.000000e+00      0.000000      0.000000      0.000000      0.000000      0.000000
25%    0.000000e+00      0.000000      0.000000      0.000000      0.000000      0.000000
50%    1.040000e+02    170.000000    152.500000    140.000000    152.000000    135.000000
75%    1.093250e+03   1391.250000   1379.000000   1273.250000   1360.000000   1311.000000
max    1.531773e+06 405114.000000 783371.000000 598885.000000 735200.000000 346520.000000
```
*Note: The extreme gap between the median (50%) and the maximum values highlights the high degree of right-skewness typical in RNA-seq count data, underscoring the necessity for downstream normalization (e.g., TPM, DESeq2 median of ratios).*

## Next Steps
The command-line portion of the Tuxedo protocol is complete. The count matrices and phenotype data will now be moved into RStudio for statistical analysis and visualization.