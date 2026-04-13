# ==============================================================================
# Script: 03_plotting_20260413.R
# Purpose: Generate Volcano Plot and Heatmap for Plastic x Time Interaction
# Phase: 02_Full_Microplastic_RNAseq
# Date: 2026-04-13
# ==============================================================================

# Load necessary libraries
library(ggplot2)
library(ggrepel)  # For non-overlapping text labels
library(pheatmap)
library(dplyr)

cat("Starting Phase 2 Visualization: Interaction Signatures...\n")

# Note: Assumes 'res01_inter' (the LRT interaction result) and 'logcpm_sub' 
# are loaded in the environment from the previous DEG script.

# --- 1. Volcano Plot: Interaction Term ---
# Extract table and define significance
volcano_data <- topTags(res01_inter, n = Inf)$table
volcano_data$Gene <- rownames(volcano_data)
volcano_data$Significance <- "Not sig."
volcano_data$Significance[abs(volcano_data$logFC) > 1] <- "LogFC"
volcano_data$Significance[volcano_data$FDR < 0.05 & abs(volcano_data$logFC) > 1] <- "FDR & LogFC"

# Filter top genes for labeling
top_genes <- volcano_data %>% 
  filter(Significance == "FDR & LogFC") %>% 
  top_n(25, wt = -PValue)

# Generate Volcano Plot
volcano_plot <- ggplot(volcano_data, aes(x = logFC, y = -log10(PValue))) +
  geom_point(aes(color = Significance), alpha = 0.6, size = 2) +
  scale_color_manual(values = c("FDR & LogFC" = "#e74c3c", "LogFC" = "#7f8c8d", "Not sig." = "#95a5a6")) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "#2c3e50") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "#2c3e50") +
  geom_text_repel(data = top_genes, aes(label = Gene), size = 3, max.overlaps = 20) +
  theme_bw() +
  labs(title = "Plastic x Time Interaction (146 Genes)",
       subtitle = "LRT Method: Rescuing the Root Signal",
       x = expression(Log[2]~fold~change),
       y = expression(-Log[10]~P)) +
  theme(legend.position = "top", legend.title = element_blank())

# Export Volcano Plot
ggsave("assets/root00_volcano_plot.jpg", plot = volcano_plot, width = 9, height = 6, dpi = 300)
cat("✅ Volcano plot saved to assets/root00_volcano_plot.jpg\n")

# --- 2. Heatmap: The 146 Interaction DEGs ---
# Extract the 146 significant interaction genes
sig_interaction_genes <- volcano_data %>% filter(FDR < 0.05 & abs(logFC) > 1) %>% pull(Gene)

# Subset the logCPM matrix for these specific genes and the 4 primary groups
# Assumes pheno_sub contains the 12 samples and a 'Group' column (e.g., c0_d0)
heatmap_matrix <- logcpm_sub[sig_interaction_genes, ]

# Z-score scaling by row (gene)
heatmap_scaled <- t(scale(t(heatmap_matrix)))

# Set up group annotations for the heatmap
annotation_df <- data.frame(Group = pheno_sub$Group)
rownames(annotation_df) <- rownames(pheno_sub)

# Define custom colors for the groups
ann_colors <- list(
  Group = c(c0_d0 = "#8cc63f", c0_d120 = "#ff7f7f", c5_d0 = "#00ced1", c5_d120 = "#d18cff")
)

# Generate and save Heatmap
png("assets/root01_heatmap.png", width = 3000, height = 1800, res = 300)
pheatmap(heatmap_scaled,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_rownames = FALSE,
         show_colnames = TRUE,
         annotation_col = annotation_df,
         annotation_colors = ann_colors,
         color = colorRampPalette(c("blue", "white", "red"))(100),
         main = "Interaction Signature: Plastic Response Over Time")
dev.off()
cat("✅ Heatmap saved to assets/root01_heatmap.png\n")