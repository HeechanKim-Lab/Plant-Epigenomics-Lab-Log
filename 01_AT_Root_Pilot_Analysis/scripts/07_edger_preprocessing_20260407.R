# ==============================================================================
# Script: 07_edger_preprocessing_20260407.R
# Purpose: Initialize DGEList, filter lowly expressed genes, and apply TMM
# Author: Heechan
# Date: 2026-04-07
# ==============================================================================

# Ensure edgeR is loaded
# library(edgeR)

# --- 1. Object Initialization ---
# Define the experimental grouping factor
group <- factor(phenodata$condition)

# Create the core edgeR data structure
dge <- DGEList(counts = counts, group = group)
cat("DGEList initialized with", nrow(dge), "genes.\n")

# --- 2. Statistical Filtering ---
# Keep genes with biologically meaningful expression levels
keep <- filterByExpr(dge)

# Subset the DGEList (keep.lib.sizes=FALSE forces recalculation of library sizes)
dge <- dge[keep, , keep.lib.sizes=FALSE]
cat("📊 Pre-filtering complete. Genes remaining:", nrow(dge), "out of", length(keep), "\n")

# --- 3. TMM Normalization ---
# Calculate scaling factors to mitigate compositional bias
dge <- calcNormFactors(dge)

# Display the calculated normalization factors
cat("\nCalculated TMM Normalization Factors:\n")
print(dge$samples)