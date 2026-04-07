# edgeR Pre-processing: Filtering and Normalization
**Date:** April 7, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Initialized the core `edgeR` data structure (`DGEList`) using the aligned count matrix and metadata. Performed statistical pre-filtering to remove lowly expressed transcripts and applied Trimmed Mean of M-values (TMM) normalization to account for library size discrepancies.

## 🛠 Pre-processing Pipeline

### 1. DGEList Initialization
Constructed the `DGEList` object, explicitly mapping the biological condition (WT vs. Cond) as the grouping factor for downstream generalized linear modeling (GLM).
```R
# Define grouping factor from metadata
group <- factor(phenodata$condition)

# Initialize edgeR object
dge <- DGEList(counts = counts, group = group)
```

### 2. Low Expression Filtering
Applied the `filterByExpr` function to identify and retain only genes with statistically sufficient read counts across a minimum number of samples.
```R
# Identify robustly expressed genes
keep <- filterByExpr(dge)

# Subset the DGEList and recalculate library sizes
dge <- dge[keep, , keep.lib.sizes=FALSE]
```
**Filtering Results:**
* Initial Gene Count: 32,540
* Remaining Gene Count: 20,971
* *Observation:* Removed ~11,500 noisy, lowly expressed features, thereby reducing the multiple testing penalty for differential expression analysis.

### 3. TMM Normalization
Calculated the scaling factors using the TMM method. This step normalizes the data for compositional bias, ensuring that highly expressed outlier genes do not artificially deflate the apparent expression of the remaining transcriptome.
```R
# Calculate normalization factors
dge <- calcNormFactors(dge)
```

## Next Steps
The normalized `DGEList` object is now ready for exploratory data analysis (e.g., MDS plotting) and the estimation of biological dispersion.