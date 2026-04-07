# ==============================================================================
# Script: 09_differential_analysis_20260408.R
# Purpose: edgeR Differential Expression, Outlier Removal, and Validation
# Author: Heechan
# Date: 2026-04-08
# ==============================================================================

library(edgeR)
library(ggplot2)
library(reshape2)
library(dplyr)

# Note: Assumes 'counts', 'phenodata', and 'dge' are loaded from previous scripts

# --- 1. Initial 6-Sample Diagnostic ---
cat("Running initial 6-sample model...\n")
design_6 <- model.matrix(~factor(phenodata$condition))
dge_6 <- estimateDisp(dge, design_6)
fit_6 <- glmQLFit(dge_6, design_6)
qlf_6 <- glmQLFTest(fit_6, coef=2)

cat("Initial DEGs (6 samples):\n")
print(summary(decideTests(qlf_6)))

# --- 2. Outlier Removal (R1-1_WT) ---
cat("\nRemoving outlier R1-1_WT...\n")
samples_to_keep <- setdiff(colnames(counts), "R1-1_WT")
counts_clean <- counts[, samples_to_keep]
phenodata_clean <- phenodata[samples_to_keep, , drop = FALSE]

# Re-initialize clean edgeR Object
group_clean <- factor(phenodata_clean$condition)
dge_clean <- DGEList(counts = counts_clean, group = group_clean)
dge_clean <- dge_clean[filterByExpr(dge_clean), , keep.lib.sizes=FALSE]
dge_clean <- calcNormFactors(dge_clean)

# --- 3. Cleaned Model Fit (QLF) ---
design_clean <- model.matrix(~group_clean)
dge_clean <- estimateDisp(dge_clean, design_clean)
fit_clean <- glmQLFit(dge_clean, design_clean)
qlf_clean <- glmQLFTest(fit_clean, coef=2)

# --- 4. Likelihood Ratio Test (Final Extraction) ---
# Switching to LRT for the final DEG extraction
fit_lrt <- glmFit(dge_clean, design_clean)
lrt_test <- glmLRT(fit_lrt, coef=2)

res_lrt <- topTags(lrt_test, n=Inf)$table
final_sig_genes <- res_lrt %>% filter(FDR < 0.05 & abs(logFC) > 1)

cat("\n✅ Final LRT Extraction Complete.\n")
cat("Total Significant DEGs (FDR < 0.05, |logFC| > 1):", nrow(final_sig_genes), "\n")

# --- 5. Visualizations (Exported to assets/) ---
dir.create("assets", showWarnings = FALSE)

# 5A. Density Plot
logCPM_all <- cpm(counts, log=TRUE, prior.count=2)
melted_counts <- melt(logCPM_all)
colnames(melted_counts) <- c("Gene", "Sample", "Log2CPM")
melted_counts$Condition <- ifelse(grepl("WT", melted_counts$Sample), "WT", "Cond")

density_plot <- ggplot(melted_counts, aes(x=Log2CPM, color=Sample, linetype=Condition)) +
    geom_density(linewidth=1) +
    theme_minimal() +
    ggtitle("Per-Sample Expression Distribution (All 6 Samples)") +
    xlab("Log2 Counts Per Million") +
    ylab("Density")

ggsave("assets/expression_distribution.png", plot = density_plot, width=8, height=6, dpi=300)

# 5B. P-Value Comparison Histogram
png("assets/p-value_plot(6vs5).png", width=1200, height=600, res=150)
par(mfrow=c(1,2))
res_6_table <- topTags(qlf_6, n=Inf)$table
res_clean_table <- topTags(qlf_clean, n=Inf)$table

hist(res_6_table$PValue, breaks=50, col="salmon", main="Original (6 Samples)", xlab="P-value", ylim=c(0, 1600))
abline(v=0.05, col="red", lty=2)

hist(res_clean_table$PValue, breaks=50, col="skyblue", main="Cleaned (5 Samples)", xlab="P-value", ylim=c(0, 1600))
abline(v=0.05, col="red", lty=2)
dev.off()

cat("Plots saved to assets folder.\n")