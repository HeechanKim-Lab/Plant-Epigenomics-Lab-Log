# ==============================================================================
# Script: 08_pca_analysis_20260408.R
# Purpose: Perform PCA on log-CPM values and generate QC plots
# Author: Heechan
# Date: 2026-04-08
# ==============================================================================

# Ensure libraries are loaded
library(edgeR)
library(ggplot2)

cat("Starting PCA Quality Control...\n")

# --- 1. Data Transformation ---
# Convert TMM-normalized counts to log2-Counts Per Million (log-CPM)
# The prior count of 2 dampens the variance of genes with very low counts
logcpm <- cpm(dge, log = TRUE, prior.count = 2)

# --- 2. Perform PCA ---
# prcomp expects features as columns and samples as rows, so we transpose (t)
pca_res <- prcomp(t(logcpm), scale. = TRUE)

# Extract variance explained by PC1 and PC2 for axis labels
pca_summary <- summary(pca_res)
pc1_var <- round(pca_summary$importance[2, 1] * 100, 1)
pc2_var <- round(pca_summary$importance[2, 2] * 100, 1)

# --- 3. Prepare Data for ggplot2 ---
pca_data <- data.frame(
    Sample = rownames(pca_res$x),
    PC1 = pca_res$x[, 1],
    PC2 = pca_res$x[, 2],
    Condition = dge$samples$group
)

# --- 4. Plotting ---
pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Condition, label = Sample)) +
    geom_point(size = 5, alpha = 0.8) +
    geom_text(vjust = 2, size = 4) +
    labs(
        title = "PCA Plot: Arabidopsis Root Samples",
        x = paste0("PC1: ", pc1_var, "% variance"),
        y = paste0("PC2: ", pc2_var, "% variance")
    ) +
    theme_minimal() +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14)
    )

# --- 5. Export ---
# Ensure the assets directory exists
dir.create("assets", showWarnings = FALSE)

# Save the plot
ggsave("assets/at_pcaplot.png", plot = pca_plot, width = 8, height = 6, dpi = 300)
cat("✅ PCA computation complete. Plot saved to assets/at_pcaplot.png\n")