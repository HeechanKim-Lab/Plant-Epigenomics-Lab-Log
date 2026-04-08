# ==============================================================================
# Script: 10_plotting_20260409.R
# Purpose: Generate Volcano Plot and Z-score Heatmap for Phase 5
# Author: Heechan
# Date: 2026-04-09
# ==============================================================================

# Ensure required libraries are loaded
library(ggplot2)
library(pheatmap)

cat("Starting Phase 5: Visualization generation...\n")

# --- 1. Volcano Plot ---
# Prepare data using the LRT results
plot_data <- res_lrt
plot_data$sig <- ifelse(plot_data$FDR < 0.05 & abs(plot_data$logFC) > 1, "Significant", "Not Sig")

# Build the Volcano Plot
volcano_plot <- ggplot(plot_data, aes(x = logFC, y = -log10(PValue), color = sig)) +
    geom_point(alpha = 0.4, size = 1.2) +
    scale_color_manual(values = c("grey", "red")) +
    theme_minimal() +
    geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
    geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
    ggtitle("Volcano Plot: Conditioned vs WT (LRT Method)") +
    xlab("Log2 Fold Change") +
    ylab("-log10(P-value)")

# Export Volcano Plot
ggsave("assets/at_volcano.png", plot = volcano_plot, width = 8, height = 6, dpi = 300)
cat("✅ Volcano plot saved to assets/at_volcano.png\n")

# --- 2. Heatmap (Top 50 DEGs) ---
# Extract the IDs of the top 50 most significant genes
top50_ids <- rownames(final_sig_genes)[1:50]

# Extract these 50 rows from the 6-sample logCPM matrix
# Ensure logCPM_all is defined from the previous script: cpm(counts, log=TRUE)
heatmap_matrix <- logCPM_all[top50_ids, , drop=FALSE]

# Scale the data (Z-score computation)
# scale() works on columns, so we transpose (t), scale, and transpose back
heatmap_scaled <- t(scale(t(heatmap_matrix)))

# Generate and export the Heatmap directly to a file
pheatmap(
    heatmap_scaled, 
    cluster_rows = TRUE, 
    cluster_cols = TRUE, 
    show_rownames = FALSE, 
    annotation_col = phenodata[, "condition", drop=FALSE],
    main = "Top 50 Differentially Expressed Transcripts (Z-score)",
    color = colorRampPalette(c("blue", "white", "red"))(100),
    border_color = NA,
    filename = "assets/at_heatmap.png",
    width = 8, 
    height = 6
)
cat("✅ Heatmap saved to assets/at_heatmap.png\n")