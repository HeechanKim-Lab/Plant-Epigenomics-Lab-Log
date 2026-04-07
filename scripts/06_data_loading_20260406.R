# ==============================================================================
# Script: 06_data_loading_20260406.R
# Purpose: Import and align raw count matrices with sample metadata
# Author: Heechan
# Date: 2026-04-06
# ==============================================================================

# Set working directory to data root
setwd("~/Desktop/at_pr/at_data")

# --- 1. Data Ingestion ---
# Import count matrix; disable automatic name formatting to preserve original IDs
counts <- read.csv("gene_count_matrix.csv", row.names = 1, check.names = FALSE)

# Import phenotype data
phenodata <- read.csv("phenodata.csv", row.names = 1, check.names = FALSE)

# --- 2. Structural Harmonization ---
# Align count matrix columns to match metadata row order exactly
counts <- counts[, rownames(phenodata)]

# --- 3. Verification ---
# Validate alignment for downstream DESeq2 compatibility
if (all(colnames(counts) == rownames(phenodata))) {
    cat("✅ PERFECT: Columns and Rows are now aligned!\n")
} else {
    stop("❌ ALIGNMENT ERROR: Mismatch detected between count columns and metadata rows.\n")
}

# (Optional) Preview synchronized structures
# head(counts)
# print(phenodata)