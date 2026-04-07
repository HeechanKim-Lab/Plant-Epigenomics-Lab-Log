# Quality Control: Principal Component Analysis (PCA)
**Date:** April 8, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Performed Principal Component Analysis (PCA) on the filtered and TMM-normalized dataset to assess sample clustering and overall data quality prior to differential expression modeling.

## 🛠 Pipeline Steps

### 1. Data Transformation
Converted the normalized count data into log-CPM (Counts Per Million) using `edgeR`. Log transformation normalizes the distribution and stabilizes the variance, which is required for standard PCA algorithms.
```R
logcpm <- cpm(dge, log = TRUE)
```

### 2. PCA Execution & Visualization
Utilized the base `prcomp()` function on the transposed log-CPM matrix. Extracted the principal components and plotted PC1 vs. PC2 using `ggplot2` to visualize the primary axes of variation.

## 📊 Results & Biological Interpretation

![Arabidopsis Root PCA Plot](Plant-Epigenomics-Lab-Log/assets/AT_PCA_plot.png)

* **PC1 (49% Variance):** Successfully captures the primary biological effect. The Wild Type (WT) and Conditioned (Cond) samples cleanly separate along the X-axis, confirming that the epigenetic conditioning induced a massive, systemic transcriptional shift in the roots.
* **PC2 (18% Variance) & The Outlier:** The Conditioned replicates cluster tightly on the right. However, the Wild Type samples show significant spread along the Y-axis. Specifically, **`R1-1_WT` is a severe outlier**. 

### 🚨 Outlier Diagnostic Plan for `R1-1_WT`
Before proceeding to Phase 4 (Differential Expression), we must decide how to handle `R1-1_WT`. Leaving an outlier in the model can artificially inflate biological dispersion (variance), which kills statistical power and results in fewer significant DEGs. 