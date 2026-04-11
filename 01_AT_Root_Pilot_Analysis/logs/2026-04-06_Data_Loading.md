# Data Ingestion and Metadata Alignment
**Date:** April 6, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Loaded the raw `gene_count_matrix.csv` and the sample metadata (`phenodata.csv`) into the R environment. Identified and resolved a critical structural mismatch where the column order of the count matrix did not align with the row order of the metadata.

## 🛠 Data Processing Steps

### 1. Data Ingestion
Imported both CSV files. The `check.names = FALSE` parameter was strictly enforced to prevent R from modifying the sample identifiers (e.g., converting hyphens to periods).
* **Matrix:** `gene_count_matrix.csv`
* **Metadata:** `phenodata.csv`

### 2. Alignment Diagnostics
An initial check revealed an ordering discrepancy due to alphabetical sorting during the matrix generation phase:
* **Matrix Columns:** `R1-1_WT`, `R1-9_Cond`, `R2-1_WT`, `R2-9_Cond`... 
* **Metadata Rows:** `R1-1_WT`, `R2-1_WT`, `R3-1_WT`, `R1-9_Cond`...

### 3. Structural Harmonization
Reordered the count matrix columns to match the row indices of the metadata dataframe exactly. This is a strict prerequisite for generating a `DESeqDataSet` object in DESeq2.

### 4. Verification Output
A boolean verification script confirmed perfect alignment prior to proceeding.
```text
✅ PERFECT: Columns and Rows are now aligned!
```

## Next Steps
With the data structures properly synchronized, the environment is ready for the construction of the edgeR object and subsequent differential expression modeling.