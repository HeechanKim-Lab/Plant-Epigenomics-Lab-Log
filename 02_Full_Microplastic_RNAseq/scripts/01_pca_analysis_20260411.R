# ==============================================================================
# Script: 01_pca_analysis_20260411.R
# Purpose: Global PCA on 27-sample root matrix and 12-sample subset
# Phase: 02_Full_Microplastic_RNAseq
# Date: 2026-04-11
# ==============================================================================

library(edgeR)

cat("Starting Phase 2 Quality Control (PCA)...\n")

# Note: Assumes 'dge_full' is initialized with the 27-sample count matrix 
# and 'phenodata_full' contains the treatment metadata (0%, 1%, 5%).

# --- 1. Data Transformation ---
# Apply TMM normalization and calculate log2-CPM
dge_full <- calcNormFactors(dge_full)
logcpm_full <- cpm(dge_full, log = TRUE, prior.count = 2)

# Calculate PCA for all 27 samples
pca_full <- prcomp(t(logcpm_full), scale. = TRUE)
pc_var_full <- round(summary(pca_full)$importance[2, ] * 100, 1)

# --- 2. Plotting: Full 27-Sample Matrix ---
png("assets/root00_pca.png", width = 2400, height = 1500, res = 300)

# Define colors based on plastic concentration
# Adjust logical matching based on actual phenodata structure
colors_full <- ifelse(phenodata_full$plastic == "0%", "black",
               ifelse(phenodata_full$plastic == "1%", "red", "blue"))

plot(pca_full$x[,1], pca_full$x[,2], 
     col = colors_full, 
     pch = as.numeric(factor(phenodata_full$replicate)), # Shapes for replicates
     cex = 2, lwd = 2,
     main = "PCA: Full 27-Sample Root Dataset",
     xlab = paste0("PC1 (", pc_var_full[1], "%)"),
     ylab = paste0("PC2 (", pc_var_full[2], "%)"))

legend("topright", legend = c("0% Plastic", "1% Plastic", "5% Plastic"), 
       col = c("black", "red", "blue"), pch = 16, pt.cex = 1.5)
dev.off()
cat("✅ Full 27-sample PCA plot exported to assets/root00_pca.png\n")

# --- 3. Plotting: 12-Sample Characteristic Subset ---
# Extract a clean subset for visualization of the dose-response gradient
subset_samples <- rownames(phenodata_full)[phenodata_full$subset == TRUE] # Example filter
logcpm_sub <- logcpm_full[, subset_samples]
pheno_sub <- phenodata_full[subset_samples, ]

pca_sub <- prcomp(t(logcpm_sub), scale. = TRUE)
pc_var_sub <- round(summary(pca_sub)$importance[2, ] * 100, 1)

png("assets/root01_pca.png", width = 2400, height = 1500, res = 300)
colors_sub <- ifelse(pheno_sub$plastic == "0%", "black",
              ifelse(pheno_sub$plastic == "1%", "red", "blue"))

plot(pca_sub$x[,1], pca_sub$x[,2], 
     col = colors_sub, 
     pch = as.numeric(factor(pheno_sub$replicate)), 
     cex = 2, lwd = 2,
     main = "PCA: Characteristic 12-Sample Subset",
     xlab = paste0("PC1 (", pc_var_sub[1], "%)"),
     ylab = paste0("PC2 (", pc_var_sub[2], "%)"))

legend("topright", legend = c("0% Plastic", "1% Plastic", "5% Plastic"), 
       col = c("black", "red", "blue"), pch = 16, pt.cex = 1.5)
dev.off()
cat("✅ 12-sample subset PCA plot exported to assets/root01_pca.png\n")