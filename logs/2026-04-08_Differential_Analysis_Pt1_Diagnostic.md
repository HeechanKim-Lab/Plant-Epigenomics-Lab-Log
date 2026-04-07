# Differential Analysis (Part 1): The Outlier Diagnostic
**Date:** April 8, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Initiated Phase 4 (Differential Expression) using the `edgeR` Quasi-Likelihood (QL) pipeline. The initial run utilizing all 6 replicates completely failed to detect meaningful biological variance, directly confirming the hypothesis generated during the PCA Quality Control phase regarding the severity of the `R1-1_WT` outlier.

## 🛠 The Diagnostic Pipeline

### 1. Initial Model Fit (6 Samples)
Fitted a generalized linear model (GLM) comparing Conditioned vs. Wild Type across all 6 samples. 
* **Design Matrix:** `~group` (Comparing WT and Cond, intercept removed)
* **Testing Method:** Quasi-Likelihood F-Test (`glmQLFTest`)
* **Result:** Only **1 significant gene** was identified (FDR < 0.05).

### 2. Robust Estimation Attempt
Attempted to rescue the 6-sample model by using `edgeR`'s robust dispersion estimation (`estimateDisp(robust=TRUE)`).
* **Result:** Still only **1 significant gene**. The variance introduced by the `R1-1_WT` replicate was too extreme for algorithmic suppression.

### 3. Outlier Removal & Re-calculation
To improve statistical sensitivity and reveal the underlying conditioning response, `R1-1_WT` was systematically removed from both the count matrix and the metadata structure. The `edgeR` pipeline (filtering, TMM normalization, and dispersion estimation) was completely re-initialized for the 5 remaining "clean" samples.

```R
# Removing the outlier safely
samples_to_keep <- setdiff(colnames(counts), "R1-1_WT")
counts_clean <- counts[, samples_to_keep]
phenodata_clean <- phenodata[samples_to_keep, , drop = FALSE]
```

### 4. Cleaned Model Results
Re-running the QLF test on the 5-sample dataset yielded an immediate improvement, identifying 12 significant genes. While still conservative, this proved the outlier was suppressing the model's sensitivity.